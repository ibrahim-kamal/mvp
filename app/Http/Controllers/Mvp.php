<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use DB;
class Mvp extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;
    public $postion_player = 4;
    public $team = 3;
    function index(){
        return view('mvp');
    }  
    function mvp(){
        $lines = explode("\n",$_POST['file']);
        echo json_encode($this->read_file($lines),JSON_UNESCAPED_UNICODE);
    }

    function read_file($lines){
        // $file = "files_test/test2.txt";
        // $lines = file($file);
        if($points_system = $this->get_sport($lines[0])){
            $result = $this->calculate($lines,$points_system);
            return array("status" => 1 , "player" => $this->print_mvp($result));
        }
        else{
            return array("status"=>0);
        }
    }

    function calculate($details,$points_system){
        $var = array("Team A","Team B");
        $result = array();
        $limit = count($details);
        $teams = array();
        for ($i=1; $i < $limit ; $i++) 
        { 
            $player_details = explode(';',$details[$i]);
            
            $result[$player_details[$this->team]]['score'] = isset($result[$player_details[$this->team]]['score']) ? ($result[$player_details[$this->team]]['score'] + $player_details[$points_system['pos']]  ) : $player_details[$points_system['pos']];
            $result[$player_details[$this->team]]['score'] = $player_details[$points_system['pos']];
            if(!in_array($player_details[$this->team] , $teams)){
                $teams[] = $player_details[$this->team];
            }
            if(!isset($result[$player_details[$this->team]]['mvp'])){
                $r = $this->calculate_player($player_details,$points_system);
                $result[$player_details[$this->team]]['mvp'] = $r[1];
                $result[$player_details[$this->team]]['mvp_point'] = $r[0];
            }
            else{
                $r = $this->calculate_player($player_details,$points_system);
                if($result[$player_details[$this->team]]['mvp_point'] < $r[0]){
                    $result[$player_details[$this->team]]['mvp'] = $r[1];
                    $result[$player_details[$this->team]]['mvp_point'] = $r[0];
                }
            }

        }
        $result['title'] = $teams[0] ." vs ".$teams[1]."<br>";
        return $result;
    }

    function calculate_player($player_points,$points_system){
        $total = 0;
        $player = "player_name : ". $player_points[0] ."<br>nickname    : ". $player_points[1] ."<br>number      : ". $player_points[2] ."<br>team name   : ". $player_points[3] ."";
        foreach ($points_system[$player_points[$this->postion_player]] as $point) {
            $number  = ($point->sys_id_order == -1 ) ? 1 :  $player_points[$point->sys_id_order];
            $total += (intval($number) * intval($point->point));
            if($point->sys_id_order != -1 ){
                $player .= "<br>".$point->points_system_name." : ".$player_points[$point->sys_id_order]."" ;
            }
        }
        return array($total,$player);
    }

    function get_sport($sport_name){
        $sport_name = isset($sport_name) ? trim($sport_name) : '-1';
        $sportname = DB::table('sport')
        ->select('points.*','points_system_name','postion_name','short_name')
        ->join('points','points.sport_id','sport.sport_id')
        ->join('points_system','points_system.points_system_id','points.point_system_id')
        ->join('postion','points.postion_id','postion.position_id')
        ->where('sport_name',$sport_name)
        ->orderByRaw('sys_id_order asc')
        ->get();
        if(count($sportname)>0){
            return $this->changeformat($sportname);
        }
        else{
            return 0;
        }
    }

    function print_mvp($result){
        if($result['Team A']['score'] > $result['Team B']['score'] ){
            $result['Team A']['mvp_point'] = $result['Team A']['mvp_point'] + 10;
        }
        else{
            $result['Team B']['mvp_point'] = $result['Team B']['mvp_point'] + 10;
        }
        if($result['Team A']['mvp_point'] > $result['Team B']['mvp_point'] ){
            return $result['title'].$result['Team A']['mvp'];
        }
        else{
            return $result['title'].$result['Team B']['mvp'];
        }
    }

    function changeformat($sportname){
        $array = array();
        $pos;
        foreach($sportname as $row){
            $array[$row->short_name][] = $row;
            if($row->sys_id_order != -1 && (!isset($array['pos']))){
                $array['pos'] = $row->sys_id_order;
            }  
        }
        return $array;
    }

    

    



}
