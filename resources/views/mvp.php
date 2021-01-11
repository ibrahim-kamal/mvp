<!DOCTYPE html> 
<html> 
  
<head> 
    <title>Read Text File</title> 
</head> 
  
<body> 
    <input type="file" name="inputfile"id="inputfile" multiple> 
    <br> 
   
    <pre id="output"></pre> 
    <script src="jquery.js"></script> 
    <script type="text/javascript"> 
        document.getElementById('inputfile').addEventListener('change', function() { 
            var fr = [];
            var list = "";
            var error = 0;
            var myurl = '<?php echo url("/api/mvp"); ?>';
            var file_len = this.files.length;
            for (let index = 0; index < file_len; index++) {
                fr[index] = new FileReader(); 
                fr[index].onload=function(){ 
                    console.log(fr[index].result);
                    
                    $.ajax(
                        {
                            url:myurl,
                            method: "POST",
                            data: {
                                "file":fr[index].result
                            },
                            success:function(result){
                                result = JSON.parse(result);
                                if(result.status == 1){
                                    console.log(result);
                                    list += result.player;
                                }
                                else{
                                    error = 1
                                    $('#output').text('eror has happend');
                                }
                                if(index + 1 == file_len){
                                    if(error == 0){

                                        $('#output').html("<div>"+list+"<div>");
                                    }
                                }
                            }
                        }
                    )
                } 
                fr[index].readAsText(this.files[index]);                 
            }
        })
    </script> 
</body> 
  
</html> 