<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Training Details</title>
<!--Bootstrap Select -->
<link href="assets/plugins/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">

<script src="assets/panelActions.js"></script>
<!--Bootstrap Select2 [ OPTIONAL ]-->
<link href="assets/plugins/select2/select2.min.css" rel="stylesheet">


<!--Datepicker [ OPTIONAL ]-->
<link href="assets/plugins/jqueryUI-DatepickerCSS/datepicker.css" rel="stylesheet">

<script src="assets/plugins/jquery-ui-1.12.1/jquery-ui.min.js"></script>

	
<!--Bootstrap Select -->
<script src="assets/plugins/bootstrap-select/bootstrap-select.min.js"></script>


<!--Bootstrap Select2 [ OPTIONAL ]-->
<script src="assets/plugins/select2/select2.min.js"></script>

<!--Bootstrap Validator [ OPTIONAL ]-->
<script src="assets/plugins/bootstrap-validator/bootstrapValidator.min.js"></script>


<!--Bootstrap Validator -->
<script src="assets/plugins/jquery-validation/jquery.validate.min.js"></script>


<!--Data Parsley [ OPTIONAL ]-->
<!-- <script src="assets/plugins/parsley/parsley.min.js"></script> -->


<!--DataTables -->
<script src="assets/plugins/datatables/media/js/jquery.dataTables.js"></script>
<script src="assets/plugins/datatables/media/js/dataTables.bootstrap.js"></script>
<script src="assets/plugins/datatables/extensions/Responsive/js/dataTables.responsive.min.js"></script>


<!--Bootstrap Table -->
<link href="assets/plugins/datatables/media/css/dataTables.bootstrap.css" rel="stylesheet">
<link href="assets/plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet">


<!-- Panel Actions -->
<script src="assets/panelActions.js"></script>
<!--Numeric Input -->
<script src="assets/plugins/numeric/jquery.numeric.min.js"></script>
<script src="assets/plugins/Loading-Spinner/jquery-loader.js"></script>

<script src="assets/plugins/tabbable/jquery.tabbable.js"></script>
<script src="assets/plugins/cleave.js/cleave.min.js"></script>

<script src="assets/plugins/datatables/media/js/dataTables.bootstrap.js"></script>
<script src="assets/plugins/datatables/extensions/Responsive/js/dataTables.responsive.min.js"></script>
<!--Bootstrap Validator -->
<script src="assets/plugins/bootstrap-validator/bootstrapValidator.min.js"></script>
<!--Bootstrap Validator -->
<script src="assets/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="assets/panelActions.js"></script>
<!--Numeric Input -->
<script src="assets/plugins/numeric/jquery.numeric.min.js"></script>
<script src="assets/plugins/mask-input/jquery.mask.js"></script>
<script src="assets/plugins/mask-input/jquery.mask.min.js"></script>
<script src="assets/plugins/alphanum/jquery.alphanum.js"></script>
<script src="assets/plugins/select2/select2.min.js"></script>


<script type="text/javascript">
let op_flag = "N";
let showForm = false;
let showTable = true;
let listOfEmployeeNewState=[];
let listOfEmployeeUpdateState=[];
let listOfEmployeeNom=[];
let listOfCustomer=[];
let global_training_id = 0;
$(document).ready(function() {
	
	$("#emp_name").select2({
		placeholder:"Select",
		width:'100%',
		multiple:false,
		allowClear:true
	});
	
	 $('.showTableDiv').show();
	 $('.showFormDiv').hide();
	 getEmployeeList();
	 loadTableList();
	 
	 validateForm();

	 
	 
	 $('form').on('keyup change paste click', 'input, select, textarea, button, a', function(event){
			var elem = event.target;
			var elValid = false;
			if (!$(elem).valid()) {
				elValid = true;
		    }
		    $('.mandatory').each(function() {
		    	if ($(this).val()=='' || $(this).val()==null) {
					elValid = true;
		        }
		    	
		    });
		    if (elValid || $('.InfoTableBody tr').length<=0) {
		    	$('.submitBtnName').attr('disabled', 'disabled');
		    } else {
		    	$('.submitBtnName').removeAttr('disabled');
		    	
		    }
		});
	 

		
	 
	 
	 
	 
	 /*===============================================End removeItemRow=======================================================================  */ 
	 	/**************************Check if last input of td is empty************************/
	/*  	$('#TrainingForm').on('input', function () {
			
			 let valueCurr = $(this).closest('td').prev('td').find('input,.select2').val();
	 		if(valueCurr==""){  
	 			$(this).addClass('mandatory').prop('required','required');
	 			$(this).closest('td').prev('td').find('input,.select2').focus().addClass('mandatory').prop('required','required');
	 		}
			$(this).closest('tr').nextAll('tr').find('input,.select2,select').removeClass('mandatory').removeAttr('required').removeClass("error").siblings('small').empty(); 
		})
		/**************************Check if last input of tr is empty************************/
	/*	 $('#TrainingForm').on('keydown focus blur selec2:open',"[id^=training_type_row],.select2", function () { 
		var konst;
		for(var i=5;i>=1;i--){
			var m=$(this).closest('tr').prev('tr').find('td:eq('+i+')>input,td:eq('+i+')>.select2').val();
		        if(m==""){
		        	konst=i;
		        }
			}
		
		console.log("dg"+konst);
	$(this).closest('tr').prev('tr').find('td:eq('+konst+')>input,td:eq('+konst+')>.select2').focus().addClass('mandatory').prop('required','required');
		
	}) */
		
		/*========================================= load list modify=====================================================  */	
		 var branchMstId =$("#branchMstId").val();
		 var parameter = "EMP_EDU_HELP ~ AND E.OP_BRANCH_MST_ID = "+branchMstId+" AND EXISTS(SELECT 1 FROM pay_emp_trainig_dtl H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND coalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND coalesce(H.DELETE_FLAG,''N'')=''N'')";
	     	$.ajax({
					url : "${pageContext.request.contextPath}/app/common/getHelpList",
					data : JSON.stringify({
						"param" : parameter
					}),
				method : "post",
				dataType : "json",
				contentType : "application/json",	
				success : function(resp) {
					listOfEmployeeUpdateState = resp.helpList;
				},
			}); 
	    	/*========================================= End load list modify=====================================================  */
		
	    	
	     	/*========================================= load list New=====================================================  */	
	   	 var branchMstId =$("#branchMstId").val();
	   	 var parameter = "EMP_EDU_HELP ~ AND E.OP_BRANCH_MST_ID = "+branchMstId+" AND NOT EXISTS(SELECT 1 FROM pay_emp_trainig_dtl H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND coalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND coalesce(H.DELETE_FLAG,''N'')=''N'')";
	        	$.ajax({
	   				url : "${pageContext.request.contextPath}/app/common/getHelpList",
	   				data : JSON.stringify({
	   					"param" : parameter
	   				}),
	   			method : "post",
	   			dataType : "json",
	   			contentType : "application/json",	
	   			success : function(resp) {
	   				listOfEmployeeNewState = resp.helpList;
	   			},
	   		}); 
	       	/*========================================= End load list New=====================================================  */
	
});
function dosomething(i){
	console.log(i);
	if($('#from_row'+i).val()!="" && $('#to_row'+i).val()!=""){
	$('#total_day_row'+i).val(" " + daydiff(parseDate($('#from_row'+i).val()), parseDate($('#to_row'+i).val())));
	console.log(i+"-"+daydiff(parseDate($('#from_row'+i).val()), parseDate($('#to_row'+i).val())));
	
	
    var fromdate = parseDate($('#from_row'+i).val()); //Year, Month, Date
    var todate = parseDate($('#to_row'+i).val()); //Year, Month, Date
    if (todate >= fromdate) {
    //    alert("Period To Date is Should be greater than Period From Date.");
    } else {
    	$('#from_row'+i).val("");
    	$('#to_row'+i).val("");
    	$('#total_day_row'+i).val("");
        alert("Period From Date is Should not be greater than Period To Date.");
    }
	
	
	
	}
	}

function parseDate(str) {
	var mdy = str.split('/')
	
	return new Date(mdy[2], mdy[1]-1, mdy[0]);

	}

	function daydiff(first, second) {
	return ((second-first)/(1000*60*60*24)+1)            //1 is added for total count
	}
function getEmployeeList(){
	$.ajax({  
	    url:"${pageContext.request.contextPath}/app/common/getCodeList",  
	    data : JSON.stringify({
			"param" : "null",
			"sqlMstId" :7159
		}),
		method : "post",
		dataType : "json",
		contentType : "application/json",
		async: false,
	    success: function(response){
	    let	listofEmployee = JSON.parse(response["codeList"])
	           $("#emp_name").empty();
	    	$("#emp_name").append('<option value="">Select Employee</option>');
	    	$.each(listofEmployee, function(key,value) {
					nKey = parseInt(key)+1;
					$("#emp_name").append('<option value="'+listofEmployee[key].employee_mst_id+'"> '+listofEmployee[key].employee_name+'');
			}); 
	      },
	 }); 
	
}
/*-------------------------------------  Add Rows---------------------*/
 
 function addItemRowButton(){
	 let totalRowCount = $('.InfoTable').find('tbody tr').length;		
     
     addItemRow(1,totalRowCount);
     
 } 
 
 function addItemRow(NoOfRow,Init){
		let totalRowCount = $('.InfoTable').find('tbody tr').length;
		
		let i=1;
		let count=NoOfRow;
		for (var k = 1;k <= count; k++) {  
			i=$("#InfoTableid tbody tr").length+1;
		$('.InfoTable').append('<tr>'+
			
			'<td class="trainingId" id="trainingId'+i+'" style="text-align: center" hidden><label>'+0+'</label></td>'+
			'<td class="rowCount" id="'+(i)+'" style="text-align: center;width: 4%"><label class="rowforDel">'+(i)+'</label>'+
			        '<input type="hidden" class="chkIdForRemoveRow" value="'+i+'">'+
			        '<input type="hidden" class="rowactiveFlag" value="Y">'+
			        '<input type="hidden" class="rowdeleteFlag" value="N"></td>'+
			        
			'<td  style="width:87px;"><select class="form-control input-sm training_palace_row mandatory" style="width:250px"  name="training_palace_row"  data-toggle="tooltip" title="Select Traininng Place"  id="training_palace_row'+i+'" required><option value="">Select</option><option value="I">India</option><option value="A">Abroad</option></select></td>'+
			
			'<td style="text-align:right;"><textarea type="text" class="form-control input-sm Training_Place_name_row mandatory" Style="width:150px;" data-toggle="tooltip" maxlength="50" placeholder="Enter Training Place Name" title="Enter Training Place Name" name="Training_Place_name_row" id="Training_Place_name_row'+i+'" required></textarea></td>'+
			
			'<td style="text-align:right;"><textarea type="text" class="form-control input-sm trainig_place_description_row" maxlength="500" Style="width:150px;" data-toggle="tooltip" placeholder="Enter Training Place Description" title="Enter Training Place Description" name="trainig_place_description_row" id="trainig_place_description_row'+i+'" ></textarea></td>'+
			'<td class="" style="width: 100px;"><Select class="form-control input-sm training_type_row"  name="training_type_row"  data-toggle="tooltip" title="Select Traininng Type"  id="training_type_row'+i+'"><option value="">Select</option><option value="B">Basic</option><option value="I">Intermediate</option><option value="A">Advanced</option></select></td>'+
			'<td class=""  style="width:15%">'+
			'<textarea type="text" class="form-control input-sm training_name_row mandatory" style="width:150px;" data-toggle="tooltip" placeholder="Enter Training Name" maxlength="100" name="training_name_row" id="training_name_row'+i+'"'+ 
	        ' title="Enter Training Name" maxlength="10" style="text-align: center; height: 30px;" required></textarea></td>'+
	        '<td style="width: 13%;text-align:right;"><textarea type="text" style="width: 150px;" class="form-control input-sm Training_institute" data-toggle="tooltip" maxlength="200" placeholder="Enter Institute Name" title="Enter Training Institute Name" name="Training_institute" id="Training_institute'+i+'"></textarea></td>'+
	    	'<td class=""  style="width:15%">'+
		    '<div class="form-group has-feedback">'+													
		    '<input type="text" class="form-control input-sm from_row mandatory" name="from_row" id="from_row'+i+'"  onchange="dosomething('+i+')" style="width: 150px;" placeholder="Select From Date"  onchange="setPeriod(this.value, '+i+')" title="Select From Date "'+ 
         'maxlength="10" style="text-align: center; height: 30px;" required>'+
         '<span class="fa fa-calendar fa-lg form-control-feedback"></span>'+
         '<small style="color: red;"></small>'+
	        '</div></td>'+
	        
	    	'<td class=""  style="width: 15%">'+
    		    '<div class="form-group has-feedback">'+													
    		    '<input type="text" class="form-control input-sm to_row mandatory" name="to_row" id="to_row'+i+'" style="width: 150px;"  onchange="dosomething('+i+')" placeholder="Select To Date" title="Select To Date "'+ 
             'maxlength="10" style="text-align: center; height: 30px;" required>'+
             '<span class="fa fa-calendar fa-lg form-control-feedback"></span>'+
             '<small style="color: red;"></small>'+
    	        '</div></td>'+
    	        '<td style="width: 20%;text-align:left;"><input type="text" class="form-control input-sm total_day_row" data-toggle="tooltip" disabled style="width:100px" placeholder="Total Days" title="Enter Total days" name="total_day_row" id="total_day_row'+i+'"><input type="hidden" class="form-control input-sm period_mm_yyyy" name="period_mm_yyyy" id="period_mm_yyyy'+i+'"  style="width: 150px;"'+
    	         'maxlength="10" style="text-align: center; height: 30px;" ><small style=color: red></small></td>'+
	        '<td style="width: 20%"><textarea class="form-control input-sm Sponsor_Name_row" data-toggle="tooltip" title="Enter Sponsor Name" style="width:150px" maxlength="100" placeholder="Enter Sponsor Name" name="Sponsor_Name_row" id="Sponsor_Name_row'+i+'"  title="Enter Sponsor Name"></textarea><small style=color: red></small></td>'+
			'<td style="width: 20%"><textarea class="form-control input-sm remark_row" data-toggle="tooltip" title="Enter Remarks" style="width:150px"  maxlength="200" placeholder="Enter Remarks" name="remark_row" id="remark_row'+i+'"  title="Enter Remark"></textarea><small style=color: red></small></td>'+
		
			 '<td style="text-align:center;width: 2%">'+
	            '<button type="button" onclick="removeItemRow(this)" class="btn btn-danger btn-sm btn-round rowRemove" >'+
	              '<i class="fa fa-trash" style="padding: 5px;"></i>'+
	            '</button>'+
			'</td>'+ 
			
		'</tr>');
		
		$("#Training_Place_name_row"+i).alpha();
 	   	$("#trainig_place_description_row"+i).alphanum();
 		$("#training_name_row"+i).alpha();
 		$("#Training_institute"+i).alpha();
 	   	$("#Sponsor_Name_row"+i).alpha();
 	    $("#remark_row"+i).alpha();
		
			$('[Id^=from_row]').datepicker({
			placeholder:"Select From Date",
		    changeMonth: true,
		    changeYear: true,
		    dateFormat: "dd/mm/yy",
		 })
			$('[Id^=to_row]').datepicker({                              
				placeholder:"Select To Date",
			    changeMonth: true,
			    changeYear: true,
			    dateFormat: "dd/mm/yy",
			 })
			
			$('#training_palace_row'+i).select2({
				placeholder:"Select",
				multiple:false,
				allowClear:true,
				width:'100%',
			});
			$('#training_type_row'+i).select2({
				placeholder:"Select",
				multiple:false,
				allowClear:true,
				width:'100%',
			});

		     $('.InfoTable tr:last').find('input, button ,textarea').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
		     	 $('.InfoTable tr:last').find('.select2-container').tooltipster({
		     		    functionInit: function(instance, helper){
		     		        var content = $(helper.origin).closest('td').find('select').attr("title");
		     		        instance.content(content);
		     		    },
		     		    delay: 100,
		     		    theme: 'tooltipster-punk',
		     		    side: 'bottom'
		     		});
			
		


	
	$("#from_row"+i).addClass('mandatory').prop('required','required');
	$("#to_row"+i).addClass('mandatory').prop('required','required');
	$("#training_type_row"+i).addClass('mandatory').prop('required','required');

	}
	}
 
 /*  */

 
 
 function saveUpdateDeleteOnFlag(){
	let tbltranlist = 0;
	$("#InfoTableid tbody tr>td>input.form-control").each(function(m){
		   if($(this).val()!=""){
			   tbltranlist++;
		   }	   
		});

	
	tbltranlist = (tbltranlist/4);
	var empName =$("#emp_name").val();
	
	 let emp_tra_dtl_idlist             = [];
	 let trainig_placelist              = [];
	 let trainig_place_namelist         = [];
	 let trainig_place_descriptionlist  = [];
	 let trainig_typelist               = [];
	 let trainig_namelist               = [];
	 let name_of_institutelist          = [];
	 let period_mm_yyyylist             = [];
	 let period_fromlist                = [];
	 let period_tolist                  = [];
	 let total_dayslist                 = [];
	 let sponsor_bylist                 = [];
	 let remarklist                     = [];
	 let active_flaglist                = [];
	 let delete_flaglist                = [];




$("#InfoTableid tbody tr").each(function(index){
	
	//fetch data from table 
	if(($(this).find('.training_type_row').val()!="")){
		emp_tra_dtl_idlist.push($(this).find('.trainingId').text()==""?"":$(this).find('.trainingId').text());
		trainig_placelist.push($(this).find('.training_palace_row').val()==""?"":$(this).find('.training_palace_row').val());
		trainig_place_namelist.push($(this).find('.Training_Place_name_row').val()==""?"":$(this).find('.Training_Place_name_row').val());
		trainig_place_descriptionlist.push($(this).find('.trainig_place_description_row').val()==""?"":$(this).find('.trainig_place_description_row').val());
		trainig_typelist.push($(this).find('.training_type_row').val()==""?"":$(this).find('.training_type_row').val());
		trainig_namelist.push($(this).find('.training_name_row').val()==""?"":$(this).find('.training_name_row').val());
		name_of_institutelist.push($(this).find('.Training_institute').val()==""?"":$(this).find('.Training_institute').val());
		period_mm_yyyylist.push($(this).find('.period_mm_yyyy').val()==""?"":$(this).find('.period_mm_yyyy').val());
		period_fromlist.push($(this).find('.from_row').val()==""?"":$(this).find('.from_row').val());
		period_tolist.push($(this).find('.to_row').val()==""?"":$(this).find('.to_row').val());
		total_dayslist.push($(this).find('.total_day_row').val()==""?"":$(this).find('.total_day_row').val());
		sponsor_bylist.push($(this).find('.Sponsor_Name_row').val()==""?"":$(this).find('.Sponsor_Name_row').val());
		remarklist.push($(this).find('.remark_row').val()==""?"":$(this).find('.remark_row').val());
		active_flaglist.push($(this).find('.rowactiveFlag').val()==""?"":$(this).find('.rowactiveFlag').val());
		delete_flaglist.push($(this).find('.rowdeleteFlag').val()==""?"":$(this).find('.rowdeleteFlag').val());

	}	
});



	 
	 
		 var postParam = {
				empName:empName,
				op_flag:op_flag,
				emp_tra_dtl_idlist    :emp_tra_dtl_idlist, 
				trainig_placelist :trainig_placelist,
				trainig_place_namelist :trainig_place_namelist ,
				trainig_place_descriptionlist :trainig_place_descriptionlist,
				trainig_typelist : trainig_typelist,
				trainig_namelist : trainig_namelist,
				name_of_institutelist : name_of_institutelist,
				period_mm_yyyylist : period_mm_yyyylist,
				period_fromlist : period_fromlist,
				period_tolist : period_tolist,
				total_dayslist : total_dayslist,
				sponsor_bylist : sponsor_bylist,
				remarklist :remarklist,
				active_flaglist :active_flaglist,
				delete_flaglist :delete_flaglist ,

			} 
	

 	$.ajax({
		url : "${pageContext.request.contextPath}/app/payroll/ServiceBook/saveEmployeeTrainingDetails",
		data : JSON.stringify(postParam),
		method : "post",
		dataType : "json",
		contentType : "application/json",
	 	success : function(res) {

	    	if (JSON.parse(res["responseObj"]).status == "success") {
		          toastr.success(JSON.parse(res["responseObj"]).msg,'Success', {
		            closeButton: true,
		            positionClass: 'toast-bottom-right'
		          });
		          
		          $('#submitBtnName').attr('disabled', 'disabled');
		          	  disAbled();
			          resetForm();
			          loadTableList();
			          		        
			        } else {
		             toastr.error(JSON.parse(res["responseObj"]).msg, 'Error', {
		             closeButton: true,
		             positionClass: 'toast-bottom-right'
		          });

		        }
		}, 
	 

		
	});
		 loadTableList(); 
    
}
 
 function resetForm(){
	 $('#emp_name').val("").trigger('change');
	 $('.trainingId').val("") ;                   
	 $('.training_palace_row').val("").trigger('change');           
	 $('.Training_Place_name_row').val("");       
	 $('.trainig_place_description_row').val(""); 
	 $('.training_type_row').val("").trigger('change') ;            
	 $('.training_name_row').val("");             
	 $('.Training_institute').val("") ;           
	 $('.period_mm_yyyy').val("") ;               
	 $('.from_row').val("");                      
	 $('.to_row').val("");                        
	 $('.total_day_row').val("");                 
	 $('.Sponsor_Name_row').val("") ;             
	 $('.remark_row').val("");                    
 }
 
 
 
 /*  */
/*-------------------------------------  end ---------------------*/
function loadTableList(){
	 var branchMstId =$("#branchMstId").val();
	 if ($.fn.dataTable.isDataTable('.detailList')) {
			dtTable.clear().destroy();
		}
	 	$.ajax({
				url : "${pageContext.request.contextPath}/app/common/getHelpList",//getHelpList==branchMstId
				data : JSON.stringify({
					"param" : "EMP_EDU_HELP ~ AND E.OP_BRANCH_MST_ID = "+branchMstId+" AND EXISTS(SELECT 1 FROM pay_emp_trainig_dtl H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND coalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND coalesce(H.DELETE_FLAG,''N'')=''N'')",
				}),
			method : "post",
			dataType : "json",
			contentType : "application/json",	
			success : function(resp) {
			
				listOfCustomer = resp.helpList;
				if(listOfCustomer.length){
					let tbodyData="";
					listOfCustomer.forEach(function(user,i){
						tbodyData = tbodyData+'<tr>'+
						'<td style="text-align: center">'+(i+1)+'</td>'+
						'<td>'+(user.prop3==null ? "" : user.prop3)+'</td>'+
						/* '<td>'+(user.prop4==null ? "" : user.prop4)+'</td>'+
						'<td style="text-align:center">'+(user.prop5==null ? "":user.prop5)+'</td>'+ */
						'<td style="text-align: center;">'+
						'<a href="javascript:;" onclick="toggleTableAndForm(\'M\',\''+user.prop2+'\')" class="btn btn-primary btn-sm btn-round" title="<spring:message code="label.commonEdit"></spring:message>">'+
		                '<i class="fa fa-pencil"style="padding: 5px;"></i>'+
		              '</a>&nbsp;'+
		              '<a href="javascript:;" onclick="toggleTableAndForm(\'D\',\''+user.prop2+'\')" class="btn btn-danger btn-sm btn-round" title="<spring:message code="label.commonDelete"></spring:message>">'+
		                '<i class="fa fa-trash" style="padding: 5px;"></i>'+
		              '</a>'+
						'</td></tr>';
					});
				$('.detailListTableBody').empty().html(tbodyData);
					
					dtTable = $('.detailList').DataTable({});
				}
				
			},
			failure : function() {
				console.log("failed to load list.");
			}
		}); 

	}








function setFormData(employee_id) {
 	var emp_name_selected;
		emp_name_selected =employee_id;
		
		
		var postParameter={
				"param" : emp_name_selected+"~"+$("#branchMstId").val(),
				"sqlMstId":7315
		}
		$.ajax({
			url : "${pageContext.request.contextPath}/app/common/getCodeList",
			data:JSON.stringify(postParameter),
			method:"post",
			dataType:"json",
			contentType:"application/json",
			async:false,
			success:function(response){
				
				listOfEmployeeNom=JSON.parse(response["codeList"]);
				
				$('#InfoTableid tbody').empty();
				
				$.each(listOfEmployeeNom, function(i, resp) {
			    $('#emp_name').val(resp.employee_mst_id).trigger('change');
	           
				$('.InfoTable').append('<tr>'+
						'<td class="trainingId" id="trainingId'+i+'" style="text-align: center" hidden><label>'+resp.emp_tra_dtl_id+'</label></td>'+
						'<td class="rowCount" id="'+(i)+'" style="text-align: center;width: 4%"><label class="rowforDel">'+(i+1)+'</label>'+
						        '<input type="hidden" class="chkIdForRemoveRow" value="'+i+'">'+
						        '<input type="hidden" class="rowactiveFlag" value="Y">'+
						        '<input type="hidden" class="rowdeleteFlag" value="N"></td>'+
						        
						'<td  style="width:250px;"><select class="form-control input-sm training_palace_row mandatory" style="width:250px"  name="training_palace_row"  data-toggle="tooltip" title="Select Traininng Place"  id="training_palace_row'+i+'"><option value="">Select</option><option value="I">India</option><option value="A">Abroad</option></select></td>'+
						
						
						'<td style="text-align:right;"><textarea type="text" class="form-control input-sm Training_Place_name_row mandatory" Style="width:150px;" maxlength="50" data-toggle="tooltip" placeholder="Enter Training Place Name" title="Enter Training Place Name" name="Training_Place_name_row" id="Training_Place_name_row'+i+'"  value="'+resp.trainig_place_name+'" required></textarea></td>'+
						'<td style="text-align:right;"><textarea type="text" class="form-control input-sm trainig_place_description_row" Style="width:150px;" maxlength="500" data-toggle="tooltip" placeholder="Enter Training Place Description" title="Enter Training Place Description" name="trainig_place_description_row" id="trainig_place_description_row'+i+'"  value="'+resp.trainig_place_description+'" ></textarea></td>'+
						'<td class="" style="width: 300px;"><Select class="form-control input-sm training_type_row mandatory"  style="width:250px;" name="training_type_row"  data-toggle="tooltip" title="Select Traininng Type"  id="training_type_row'+i+'" required><option value="">Select</option><option value="B">Basic</option><option value="I">Intermediate</option><option value="A">Advanced</option></select></td>'+
						'<td class=""  style="width:12%">'+
						'<textarea type="text" class="form-control input-sm training_name_row mandatory" style="width:150px;" data-toggle="tooltip" placeholder="Enter Training Name"  maxlength="100" name="training_name_row" id="training_name_row'+i+'"'+  
				        '    value="'+resp.trainig_name+'" title="Enter Training Name" maxlength="10" style="text-align: center; height: 30px;" required></textarea></td>'+
				        '<td style="width: 13%;text-align:right;"><textarea type="text" style="width: 150px;" class="form-control input-sm Training_institute" data-toggle="tooltip" maxlength="200" placeholder="Enter Institute Name" title="Enter Training Institute Name" name="Training_institute" id="Training_institute'+i+'" value="'+resp.name_of_institute+'"></textarea></td>'+
				    	'<td class=""  style="width:12%">'+
					    '<div class="form-group has-feedback">'+													
					    '<input type="text" class="form-control input-sm from_row mandatory" name="from_row" id="from_row'+i+'" onchange="dosomething('+i+')" value="'+resp.period_from+'" style="width: 150px;" placeholder="Select From Date" onchange="setPeriod(this.value,'+i+')" title="Select From Date "'+
			         'maxlength="10" style="text-align: center; height: 30px;" required><input type="hidden" class="form-control input-sm monthyear" name="monthyear" id="monthyear'+i+'"  style="width: 150px;"'+
	    	         'maxlength="10" style="text-align: center; height: 30px;" >'+
			         '<span class="fa fa-calendar fa-lg form-control-feedback"></span>'+
			         '<small style="color: red;"></small>'+
				        '</div></td>'+
				        
				    	'<td class=""  style="width: 15%">'+
			    		    '<div class="form-group has-feedback">'+													
			    		    '<input type="text" class="form-control input-sm to_row mandatory" name="to_row" id="to_row'+i+'" onchange="dosomething('+i+')" value="'+resp.period_to+'" style="width: 150px;" placeholder="Select To Date" title="Select To Date "'+ 
			             'maxlength="10" style="text-align: center; height: 30px;" required>'+
			             '<span class="fa fa-calendar fa-lg form-control-feedback"></span>'+
			             '<small style="color: red;"></small>'+
			    	        '</div></td>'+
			    	        '<td style="width: 20%;text-align:left;"><input type="text" class="form-control input-sm total_day_row" value="'+resp.total_days+'" data-toggle="tooltip" style="width:100px"   placeholder="Total Days" title="Enter Total days" name="total_day_row" id="total_day_row'+i+'" disabled ><small style=color: red></small><input type="hidden" class="form-control input-sm period_mm_yyyy" name="period_mm_yyyy" id="period_mm_yyyy'+i+'"  style="width: 150px;"'+
			    	         'maxlength="10" style="text-align: center; height: 30px;" value="'+resp.period_mm_yyyy+'"></td>'+
				        '<td style="width: 20%"><textarea class="form-control input-sm Sponsor_Name_row" data-toggle="tooltip" title="Enter Sponsor Name" style="width:150px"  value="'+resp.sponsor_by+'"  maxlength="100" placeholder="Enter Sponsor Name" name="Sponsor_Name_row" id="Sponsor_Name_row'+i+'"  title="Enter Sponsor Name"></textarea><small style=color: red></small></td>'+
						'<td style="width: 20%"><textarea class="form-control input-sm remark_row" data-toggle="tooltip" title="Enter Remarks" style="width:150px" value="'+resp.remark+'" maxlength="200"  placeholder="Enter Remarks" name="remark_row" id="remark_row'+i+'"  title="Enter Remark"></textarea><small style=color: red></small></td>'+
					
						 '<td style="text-align:center;width: 2%">'+
				            '<button type="button" onclick="removeItemRow(this)" class="btn btn-danger btn-sm btn-round rowRemove" >'+
				              '<i class="fa fa-trash" style="padding: 5px;"></i>'+
				            '</button>'+
						'</td>'+ 
						
					'</tr>');
	            
				
			 	$("#Training_Place_name_row"+i).alpha();
		 	   	$("#trainig_place_description_row"+i).alphanum();
		 		$("#training_name_row"+i).alpha();
		 		$("#Training_institute"+i).alpha();
		 	   	$("#Sponsor_Name_row"+i).alpha();
		 	    $("#remark_row"+i).alpha();
		 	   $("#emp_name").prop("disabled", true);
				
				$('[Id^=from_row]').datepicker({
					placeholder:"Select From Date",
				    changeMonth: true,
				    changeYear: true,
				    dateFormat: "dd/mm/yy",
				 });
				
					$('[Id^=to_row]').datepicker({
						placeholder:"Select To Date",
					    changeMonth: true,
					    changeYear: true,
					    dateFormat: "dd/mm/yy",
					 });
					
					$('#training_palace_row'+i).select2({
						placeholder:"Select",
						multiple:false,
						allowClear:true,
						width:'100%',
					});
					$('#training_type_row'+i).select2({
						placeholder:"Select",
						multiple:false,
						allowClear:true,
						width:'100%',
					});
	           $('.InfoTable tr:last').find('input, button,textarea').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
	     	 $('.InfoTable tr:last').find('.select2-container').tooltipster({
	     		    functionInit: function(instance, helper){
	     		        var content = $(helper.origin).closest('td').find('select').attr("title");
	     		        instance.content(content);
	     		    },
	     		    delay: 100,
	     		    theme: 'tooltipster-punk',
	     		    side: 'bottom'
	     		});
	            
	           $('#Sponsor_Name_row'+i).val(resp.sponsor_by);
	           $('#training_name_row'+i).val(resp.trainig_name);
	           $('#Training_Place_name_row'+i).val(resp.trainig_place_name);
	           $('#Training_institute'+i).val(resp.name_of_institute);
	           $('#remark_row'+i).val(resp.remark);
	           $('#training_palace_row'+i).val(resp.trainig_place).trigger('change');
	           $('#training_type_row'+i).val(resp.trainig_type).trigger('change');
	           $('#trainig_place_description_row'+i).val(resp.trainig_place_description).trigger('change');
	           
	           
	           $("#from_row"+i).addClass('mandatory').prop('required','required');
	        	$("#to_row"+i).addClass('mandatory').prop('required','required');
	        	$("#training_type_row"+i).addClass('mandatory').prop('required','required');
	           
	           
	        	});
			}
		
		});

 	}

//--------------------------toggling------------
function toggleTableAndForm(flag, employee_id) {
	
	  //console.log("tooggle"+flag+"--"+Deduction_Id);
	if (showForm) {
		showForm = false;
		showTable = true;
		$('.showTableDiv').show();
		$('.showFormDiv').hide();
		$('.panel-title').text("Employee Training List");
     	$('.addNewBtnOnForm').empty().html('<i class="fa fa-plus"></i> Add New Training');
		
	} else {
		if (flag == 'M') {
			
			$('.panel-title').html("Update Employee Training");
			$('.submitBtnName').text("Update Employee Training");
			$('.addBtn').attr("disabled",false);
			$('#Reset').hide();
			op_flag = "M";
			inAbled();
		//	loadEmployeeSelect2List(training_Id);
			global_training_id=employee_id;
			setFormData(employee_id);
			
		}
		if (flag == 'N') {
			
			global_training_id =0;
			$('.panel-title').text("New Employee Training");
			$('.submitBtnName').text("Save Employee Training");
			$('.addBtn').attr("disabled",false);
			$('#emp_name').prop("disabled", false);
		   inAbled();
			resetForm();
			$('#Reset').show();
			op_flag = "N";
			//loadEmployeeSelect2List(Deduction_Id);
			$('#InfoTableid tbody').empty();
			addItemRow(5,1)
		    
		}
		if (flag == 'D') {
			
			$('.panel-title').html("Delete Employee Training");
			$('.submitBtnName').text("Delete Employee Training");
			$('#Reset').hide();
			$('.addBtn').attr("disabled","disabled");
			op_flag = "D";
		//	loadEmployeeSelect2List(Deduction_Id);
			global_training_id=employee_id;
			setFormData(employee_id);
			disAbled();
		}
		showForm = true;
		showTable = false;
		$('.showTableDiv').hide();
		$('.showFormDiv').show();
		$('.addNewBtnOnForm').empty().html('<b><i class="fa fa-angle-left" style="font-weight: 900;"></i></b> Back To List');
	}
}

function removeItemRow(trObj){
	if(op_flag =="M"){
		$.confirm({
	        title: 'Are you sure want to Remove ?',
	        content: '',
	        type: 'blue',
	        buttons: {
	            Remove: {
	            	 action: function () {
	            		 if(parseInt($(trObj).closest('tr').find('.chkIdForRemoveRow').val())==0){
	            			 let rowCount = 0;
	            				let removedRow=$(trObj).closest('tr').index();
	            				$(trObj).closest('tr').remove();
	            				 $('.InfoTable tbody tr').each(function(){
	            					$(this).find('.rowforDel').text($(this).index()+1);
	            				});
	            				
	            		 }else {
	            		 	let rowCount = 0;
	            			let removedRow=$(trObj).closest('tr').index();
	            			$(trObj).closest('tr').hide();
	            			$(trObj).closest('tr').find(".rowactiveFlag").val("N");
           				    $(trObj).closest('tr').find(".rowdeleteFlag").val("Y");
	            			let count=1;
           					$('.InfoTable tbody tr').each(function(i){
           						if($(this).is(":visible")){
           							$(this).find('.rowforDel').text(count);
           							count++;
           						}
           					}); 
           				
           				
           					
           					 
	            		 }	 
	            	 }
	            },
	             Cancel: {
	                keys: ['N'],
	                action: function () {
	                	
	                }
	            }, 
	        }  
		});		
	 }else{
		let rowCount = 0;
		let removedRow=$(trObj).closest('tr').index();
		//$(trObj).closest('tr').remove();
		
		 $('.InfoTable tbody tr').each(function(){
			$(this).find('.rowCount').text($(this).index()+1);
		});	 
		 
		$('.InfoTable tbody tr:eq('+removedRow+')').remove();
		
		$('.InfoTable tbody tr').each(function(){
			$(this).find('.rowCount').text($(this).index()+1);
		});
	 }  
	
	//headerTotal();
	//getTotalOFTaxInHedr();
}



function setPeriod(fromdate, row){

	var dt = new Date(fromdate.split("/").reverse().join("/"));
    month = dt.getMonth()+1,              
    year =  dt.getFullYear();
	console.log(month,year);
	$("#period_mm_yyyy"+row).val(month+"/"+year);
	
}


function disAbled(){
	
	$('.trainingId').attr("disabled",true) ;                   
	 $('.training_palace_row').attr("disabled",true);           
	 $('.Training_Place_name_row').attr("disabled",true);       
	 $('.trainig_place_description_row').attr("disabled",true); 
	 $('.training_type_row').attr("disabled",true) ;           
	 $('.training_name_row').attr("disabled",true);             
	 $('.Training_institute').attr("disabled",true);           
	 $('.period_mm_yyyy').attr("disabled",true);               
	 $('.from_row').attr("disabled",true);                      
	 $('.to_row').attr("disabled",true);                        
	 $('.total_day_row').attr("disabled",true);                 
	 $('.Sponsor_Name_row').attr("disabled",true);             
	 $('.remark_row').attr("disabled",true);  
	
}

function inAbled(){
	$('.trainingId').attr("disabled",false) ;                   
	 $('.training_palace_row').attr("disabled",false);           
	 $('.Training_Place_name_row').attr("disabled",false);       
	 $('.trainig_place_description_row').attr("disabled",false); 
	 $('.training_type_row').attr("disabled",false) ;           
	 $('.training_name_row').attr("disabled",false);             
	 $('.Training_institute').attr("disabled",false);           
	 $('.period_mm_yyyy').attr("disabled",false);               
	 $('.from_row').attr("disabled",false);                      
	 $('.to_row').attr("disabled",false);                        
	 $('.total_day_row').attr("disabled",false);                 
	 $('.Sponsor_Name_row').attr("disabled",false);             
	 $('.remark_row').attr("disabled",false);   
	
}
function validateForm(){
	formValidator = $("#TrainingForm").validate({
        rules: {
        		"emp_name":{required:true}
        	},
        messages: {
        			"emp_name": {required: " Please Select Employee Type",}
        		  },
        highlight: function (element, errorClass, validClass) {
        	if($(element).hasClass('mandatory')){
        		var elem = $(element);
                elem.addClass(errorClass);
                elem.siblings('.select2-container').addClass(errorClass); 
        	}
            
        },    
        unhighlight: function (element, errorClass, validClass) {
        	//console.log('unhighlight $(element)',$(element));
              var elem = $(element);
              elem.removeClass(errorClass);
              elem.siblings('.select2-container').removeClass(errorClass);
              elem.siblings('small').empty();
        },
        errorPlacement: function(error, element) {
            $(element).siblings('small').empty().html(error);
         },
        submitHandler: function (form) {
        	e.preventDefault(e);
            return false; 
        }
    });
}


</script>
<style type="text/css">
#InfoTableid {
	border-collapse: collapse;
	overflow-x: scroll;
	display: block;
}
#InfoTableid tfoot {
	overflow-y: hidden;
	overflow-x: scroll;
}


.btnClear{
    display: inline-block;
    vertical-align: top;
}

</style>
</head>
<body>

<%@page import="com.vgipl.erp.login.model.User"%>
<%	
		User userObject =(User) request.getSession().getAttribute("currentUser");
		String userName = userObject.getUsername().toString();
		String branchName = userObject.getBranchName().toString();
		String stateName = userObject.getStateName()==null?"null":userObject.getStateName().toString();
		String stateId = userObject.getStateId()==null?"null":userObject.getStateId().toString();
		String branchMstId = userObject.getBranchMstId();
		String userId = userObject.getUserId();
		String DeptId=userObject.getDeptId();
		String workingDate = userObject.getWorkingDate().toString();
		String flag ="N";// request.getAttribute("flag").toString();
	    String rights ="Y~Y~Y~Y~Y~Y";//request.getAttribute("rights").toString();
	    String rightsArr[] = rights.split("~");
%>
<input type="hidden" id="finYrId" value="<%=userObject.getLoggedInFinYrId()%>">
<input type="hidden" id="branchMstId" value="<%=branchMstId%>">
<div class="col-lg-12">
				<div class="panel newPanel">
					<div class="panel-heading">
						<div class="panel-control">
						<!-- 	<button class="btn btn-default" data-click="panel-expand">
								<i class="fa fa-expand"></i>
							</button>
							<button class="btn btn-default" data-click="panel-reload">
								<i class="fa fa-refresh"></i>
							</button>
							<button class="btn btn-default" data-click="panel-collapse">
								<i class="fa fa-chevron-down"></i>
							</button> -->
							<button class="btn btn-default closeFormBtn" data-dismiss="panel" onclick="closeActiveForm()"><i class="fa fa-times"></i></button>
							<button onclick="toggleTableAndForm('N',null)"
								class="btn btn-info addNewBtnOnForm">
								<i class="fa fa-plus"></i>&nbsp;Add Employee Training
							</button>
						</div>
						<h3 class="panel-title">Employee Training List</h3>
					 </div>
					
					
					
		<div class="panel-body">
		    <div class="row showTableDiv">
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover detailList" >
						<thead>
							<tr>
							<th style="text-align: center;"><spring:message code="label.Sr_No"></spring:message></th>
                             <th style="text-align: center;" ><spring:message code="label.training.Employee_Name"></spring:message></th>
                            <th style="text-align: center;" ><spring:message code="label.training.Action"></spring:message> </th>
							</tr>
						</thead>
						<tbody class="detailListTableBody">
						</tbody>
					</table>
				</div>
			   </div>
			   
			     <div class="row showFormDiv">
				<form id="TrainingForm">
				<div class="row">
				  <div class="col-md-4">
					  <div class="form-group">
						<label class=" control-label"><spring:message code="label.training.Employee_Name"></spring:message><small style="color: red;">*</small></label>	
						   <select  id="emp_name" name="emp_name" class="form-control input-sm mandatory emp_name" data-toggle="tooltip" title="Select Employee Name"
						    title="Select Employee Name" ">	
					   	</select><small style="color: red;"></small>
					  </div>
				   </div>
				   </div>
				   
				    <div class="">
						<button type="button" class="pull-right btn btn-primary addBtn" onclick="addItemRowButton()" style="margin: 10px;"><i class="fa fa-plus"></i> <spring:message code="label.training.Add_New"></spring:message> </button>
					  </div>
					  
					    <div class="table-responsive">
                    	<table class="table table-striped table-hover table-vcenter table-condensed table-bordered InfoTable" id="InfoTableid">
                    		<thead>
                               <tr>
                               
                                <th style="text-align: center;width: 4%;"><spring:message code="label.Sr_No"></spring:message></th>
                                 <th style="text-align: center;width:200px;"><spring:message code="label.training.Training_Place"></spring:message> </th>           
                                  <th style="text-align: center;width:130px" ><spring:message code="label.training.Training_Place_Name"></spring:message>  </th>
                                 <th style="text-align: center;width:130px" ><spring:message code="label.training.Training_Place_Description"></spring:message>  </th>
                                  <th style="text-align: center;width:170px;"><spring:message code="label.training.Training_Type"></spring:message> </th>
                                 <th style="text-align: center;width:130px" ><spring:message code="label.training.Training_Name"></spring:message> </th>
                               <th style="text-align: center;width:130px" ><spring:message code="label.training.Name_Of_Institute"></spring:message></th>
                                <th style="text-align: center;width:75px"  ><spring:message code="label.training.From_Date"></spring:message>   </th>
                               <th style="text-align: center;width:75px"  ><spring:message code="label.training.To_Date"></spring:message>  </th>
                               <th style="text-align: center;width:75px"  ><spring:message code="label.training.Total_Days"></spring:message> </th>
                               <th style="text-align: center;width:130px" ><spring:message code="label.training.Sponsor_By"></spring:message> </th>
                                <th style="text-align: center;width:130px" ><spring:message code="label.training.Remark"></spring:message>  </th>
                              <th style="text-align: center;width:100px" ><spring:message code="label.training.Remove"></spring:message> </th>

                                
                               </tr>
                           </thead>
                           <tbody class="InfoTableBody">
                           
                           </tbody>
                           <tfoot></tfoot>
                    	</table>
                     </div>
				   	<div class="visibleSubmitIfHaveRight" style="margin-top: 2%;">
				   	
                        <button type="button" class="btn btn-danger pull-right " id="Reset"  onclick="resetForm()" style="margin-left:10px;">Reset</button>
                           <button  class="btn btn-primary  submitBtnName pull-right"  type="button" id="submitBtnName"
						 onclick="saveUpdateDeleteOnFlag()"></button>
				   	
				</div>
				</form>
			   </div>
			   </div>
			   </div>
			   </div>
</body>
</html>