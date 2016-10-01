<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
 

<script type="text/javascript">
var baseURL ="http://localhost:8080/JsonTestProject";
// http://localhost:8080/examples/UserServlet?op=user_list
 
var liste=[];
function getJsonList(servlet, list, objeArray,id) {
    var listjson = new Array();
    
    var formObj = new Object();
    formObj.op = list; 
    
    if(id!= null){
    formObj.id = id; 
    }
    
    formObj.arrayName = "arrayList";
    formObj[formObj.arrayName] = objeArray;
    
    if (objeArray != null) { 
    	formObj.arrayList = objeArray;
     }
         
    $.ajax({
        type: "POST",
        url: baseURL + servlet,
        data: formObj,
        async: false,
//         crossDomain: true,
        //dataType : 'jsonp',
//         dataType: "json",
        success: function(res) {
            console.log(res);
            listjson = res;
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert(errorThrown); 
        },
        beforeSend: function(jqXHR, settings){  
//          alert("beforeSend");

        },
        complete: function(jqXHR, textStatus){
//         	alert("complete");
        }
    });
    return listjson;
}

function list(listee){
	$('#here_table').text("");
	var row="";
	  
	   for(var i=0;i<listee.length;i++)
	  {
		   row+="<tr> <td>"+listee[i].name+"</td> <td>"+listee[i].surname+"</td>  <td>"+listee[i].phone+"</td> <td><a  class='silme' href='javascript:void(0)' onClick=\"del("+listee[i].id+");\" id=\""+listee[i].id+"\">sil</td> </tr>";
	  }
	   
	$('#here_table').append(  '<table border="1" style="width:700px;"> <tr bgcolor="#d3d3d3"> <td>Name</td>  <td>Surname</td> <td>Phone</td> <td>Process</td></tr>'+row+'</table>');


	}
	
function del(id){alert(id);
liste= getJsonList("/UserServlet", "user_silme",null,id);
list(liste);
}



$(document).ready(function() {
	liste= getJsonList("/UserServlet", "user_list");
	list(liste);
	
	 /*$("a.silme").bind('click', function () {
		  var personid =  $(this).attr("id");
		 
		  del(personid);
	 });*/
	/*$('a.silme').on("click",function(){
		  var personid =  $(this).attr("id");
		  alert(personid);
		  del(personid);
		});*/
	 
});

function add(){
	alert("asdasd");
    var name=  $("#name").val();
    var surname= $("#surname").val();
    var number=  $("#phone").val();  
    

    
    var formArray = new Array();
    formArray[0] = name;
    formArray[1] = surname;
    formArray[2] = number;


    
// for (i = 0; i < formObj.length; i++) { 
//    console.log(formObj[i]);
// }
 
//     console.log(formObj.length);
    
   liste= getJsonList("/UserServlet", "user_ekleme",formArray);

  
    list(liste);
}

// 	function modal_popup(){ 
     		
//         var popup = window.open("", "popup","resizable,width=300,height=200");
//         popup.document.write(
//        "<label for='newFirstName'>First Name</label><input type=\"text\" id=\"name\" style='margin-top:10px; margin-left:10px;''/><br/>"+	
//        "<label for='newLastName'>Last Name</label><input type='text' id=\"surname\" style='margin-top:10px; margin-left:12px;' /><br/>"+
//        "<label for='newLastName'>Number</label><input type='text' id=\"phone\" style='margin-top:10px; margin-left:30px;'/><br/>"+
//    		"<input type=\"submit\" value=\"submit\"  onclick=\"add();\" style='margin-top:10px; margin-left:200px;'/>"        
//         );
        
// 	}
	

	
</script>	

<title>Infonal-Examples</title>
</head>
<body>
      <label for="newFirstName">First Name</label><input type="text" id="name" style="margin-top:10px; margin-left:10px;" /><br/>
      <label for="newLastName">Last Name</label><input type="text" id="surname" style="margin-top:10px; margin-left:12px;" /><br/>
      <label for="newLastName">Number</label><input type="text" id="phone" style="margin-top:10px; margin-left:30px;"/><br/>
  
 
 <input type="submit" value="Add Person" onclick="add();" style="margin-bottom:10px; margin-top:20px; margin-left:615px;"  >
 
<div id="here_table">
 
</div>		

</body>
</html>