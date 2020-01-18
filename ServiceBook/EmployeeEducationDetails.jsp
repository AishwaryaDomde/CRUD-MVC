<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--Chosen -->
<link href="assets/plugins/chosen/chosen.min.css" rel="stylesheet">
<link href="assets/plugins/select2/select2.min.css" rel="stylesheet">
<!--Bootstrap Table -->
<link href="assets/plugins/datatables/media/css/dataTables.bootstrap.css" rel="stylesheet">
<link href="assets/plugins/datatables/extensions/Responsive/css/dataTables.responsive.css" rel="stylesheet">
<!--Chosen -->
<script src="assets/plugins/chosen/chosen.jquery.min.js"></script>
<!--DataTables -->
<script src="assets/plugins/datatables/media/js/jquery.dataTables.js"></script>
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

<script src="assets/plugins/select2/select2.min.js"></script>

	<!-- <script src="assets/js/demo/form-component.js"></script> -->
<title>Employee Education Details</title>
<script type="text/javascript">
let listofEmployeeEducation=[];
let listofyear=[];
let op_flag="N";
let yearList1 = null;
let showForm = false;
let showTable = true;
let listofEmployee=[];
$(document).ready(function(){

	$('.showTableDiv').show();
	$('.showFormDiv').hide();
	
	validateForm();
loadEmployeeEducation();
$('#rowYear').numeric({decimalPlaces: 0 ,negative: false});
$('#rowMarks').numeric({decimalPlaces: 0 ,negative: false});





$("#Employee").select2({
	width:'100%',
	placeholder:"Select Employee",
	allowClear:true,
	multiple:false,
	
}).on("change", function (e) {
	$("#Join").val($(this).find(':selected').data('joindate'));
	$("#Designation").val($(this).find(':selected').data('desig_name'));
	$("#DOB").val($(this).find(':selected').data('dob'));
});
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
    if (elValid || $('.othersTableBody tr').length<=0) {
    	$('.submitBtnName').attr('disabled', 'disabled');
    } else {
    	$('.submitBtnName').removeAttr('disabled');
    	
    }
});

$('form').find('input,textarea,option,button').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
$('.select2-container').tooltipster({
     functionInit: function(instance, helper){
       var content = $(helper.origin).closest('.form-group').find('select').attr("title");
        instance.content(content);
    }, 
    delay: 100,
    theme: 'tooltipster-punk',
    side: 'bottom'
});

getyear();
});
 

function getyear(){
	  $('[Id^=rowYear]').select2({
			placeholder:"Select Year",
			multiple:false,
			allowClear:true,
			width:'100%',
		   });
	
	let postParameters = {
			"param" : null,
			"sqlMstId" :7049
		};
	$.ajax({
		url : "${pageContext.request.contextPath}/app/common/getCodeList",
		data : JSON.stringify(postParameters),
		method : "post",
		dataType : "json",
		contentType : "application/json",
		async : false,
		success : function(res) {
			
			let yearList  = null;
			yearList = JSON.parse(res["codeList"]);
			yearList1 = '<optgroup class="def-cursor" label="Year" >';
			var optGrpEnd = '</optgroup>';
			var options = '';
			yearList.forEach(function(year, i) {
							
						options = options + '<option  value="'+year.finyr_id+'">'
								+ year.yr_code + '</option>';
					});
			yearList1 = yearList1	+ options + optGrpEnd ;
			console.log(yearList1+"yearList1");
			$(".rowYear").append(yearList1);
			
		},
		failure : function() {
		}
		 
	});
	
}





function validateForm(){
	formValidator = $("#EmployeeEducationForm").validate({
		ignore: [], 
        rules: {"Employee": {required: true},
        		"roweducation":{required: true},
        		"rowYear":{required: true},
        		"rowMarks":{required: true},
        		"Remarks":{required: true},
        		"rowBoard":{required: true},
        		"rowGrade":{required: true},
        		"rowqualification":{required: true},
        		},
        messages: {"Employee": {required: "This is require",},
        			"roweducation": {required: "This is require",},
        			"rowYear": {required: "This is require",},
        			"rowMarks": {required: "This is require",},
        			"Remarks": {required: "This is require",},
        			"rowBoard": {required: "This is require",},
        			"rowGrade": {required: "This is require",},
        			"rowqualification":{required: "This is require"},
        			
        		  },
        highlight: function (element, errorClass, validClass) {
            var elem = $(element);
            elem.addClass(errorClass);
            elem.siblings('.select2-container').addClass(errorClass); 
        },    
        unhighlight: function (element, errorClass, validClass) {
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
function getPercent(id){
	console.log(id);
	var per=$('#'+id).val();
	
	if(per<0){
		//alert("Percentage is not less than 0 !!!!!");
		$('#'+id).val("");
		setTimeout(function() {	($('#'+id)).focus(),10 });
	   }
	
	if(per>100){
		alert("Percentage is not greter than 100 !!!!!");
		$('#'+id).val("");
		setTimeout(function() {	($('#'+id)).focus(),10 });
	}
	if(isNaN(per)){
		$('#'+id).val("");
   alert("Please enter Digit only");
    
		}
	
}




function saveUpdateDelete(){
	 if (!$('.panel').hasClass("panel-loading")) {
			$('.panel').addClass("panel-loading");
			$('.panel').find(".panel-body").prepend('<div class="panel-loader"><span class="spinner-small"></span></div>');
		}
		
	  let  Jointdate  ;                                 
      let  Dob  ;                     
      let  Desgin_Name  ;             
      let  Employee_Name ;           
      let  Employee_id;             
      let  rowEducation = [];            
      let  rowPass_year   = [];            
      let  rowPercentage_mark= [];      
      let  rowGrade  = [];                
      let  rowBoard_University = [];     
      let  rowRemark = [];  
      let  rowSrno = [];    
      let  rowtableid = [];  
      let  rowdelete_flag=[];
      let  rowactive=[];
      let rowqualification=[];
      let rowChecked=[];
     
		$('.othersTable tbody tr').each(function() {
				if($(this).find('.rowflag').is(':checked')){
					rowChecked.push("Y");
				}
				else{
					rowChecked.push("N");
				   }
			});
		
					
				 if($('.othersTable tbody tr').length > 0){
					 $('.othersTable tbody tr').each(function(){
						 if($('#Employee').find(':selected').data('employee_name')!=null){
								 rowEducation.push($(this).find('.roweducation').val()==null || $(this).find('.roweducation').val()=="" ? null :$(this).find('.roweducation').val());
								 rowPass_year.push($(this).find('.rowYear').val()==null || $(this).find('.rowYear').val()=="" ? null :$(this).find('.rowYear').val() );
								 rowPercentage_mark.push($(this).find('.rowMarks').val()==null || $(this).find('.rowMarks').val()=="" ? null :$(this).find('.rowMarks').val());
								 rowGrade.push($(this).find('.rowGrade').val()==null || $(this).find('.rowGrade').val()==""? null :$(this).find('.rowGrade').val());
								 rowBoard_University.push($(this).find('.rowBoard').val()==null || $(this).find('.rowBoard').val()=="" ? null :$(this).find('.rowBoard').val());
								 rowRemark.push($(this).find('.Remarks').val()==null || $(this).find('.Remarks').val()=="" ? null :$(this).find('.Remarks').val());
								 rowSrno.push($(this).find('.rowLineNo').val()==null || $(this).find('.rowLineNo').val()==""?null:$(this).find('.rowLineNo').val());
								 rowtableid.push($(this).find('.rowidNo').val()==null || $(this).find('.rowidNo').val()==""?null:$(this).find('.rowidNo').val()); 
								 rowactive.push($(this).find('.rowactive').val()==null || $(this).find('.rowactive').val()==""?null:$(this).find('.rowactive').val());
								 rowdelete_flag.push($(this).find('.rowdelete_flag').val()==null || $(this).find('.rowdelete_flag').val()==""?null:$(this).find('.rowdelete_flag').val());
								 rowqualification.push($(this).find('.rowqualification').val()==null||$(this).find('.rowqualification').val()==""?null:$(this).find('.rowqualification').val());
								
						 }
					 });
					
				 }
				 
				let postParameters={
					     Jointdate           :     $('.Join').val(),                               
		                 Dob                 :     $('.DOB').val(),                         
		                 Desgin_name         :     $('.Designation').val(),       
		                 Employee_name       :     $('#Employee').find(':selected').data('employee_name') ,  
		                 Employee_id         :     $('#Employee').val(),          
		                 rowEducation        :     rowEducation,      
		                 rowPass_year        :     rowPass_year,      
		                 rowPercentage_mark  :     rowPercentage_mark ,
		                 rowGrade            :     rowGrade,         
		                 rowBoard_University :     rowBoard_University,
		                 rowRemark           :     rowRemark , 
		                 rowSrno             :   rowSrno,
		                 rowtableid          :   rowtableid,
		                 rowdelete_flag      :    rowdelete_flag,
		                 rowactive           :     rowactive,
		                 rowqualification    :   rowqualification,
		                 rowChecked          : rowChecked,
		                 op_flag             :   $('#opflag').val()
				 };
				
				$.ajax({
					url : "${pageContext.request.contextPath}/app/payroll/ServiceBook/EmployeeEducationDetails/saveUpdateDelete1",
					data : JSON.stringify(postParameters),
					method : "post",
					dataType : "json",
					contentType : "application/json",
					success : function(res) {
						setTimeout(function() {
							$('.panel').removeClass("panel-loading");
							$('.panel').find(".panel-loader").remove();
						}, 1000);
					 	if (JSON.parse(res["responseObj"]).status == "success") {
				          toastr.success(JSON.parse(res["responseObj"]).msg,'Success', {
				            closeButton: true,
				            positionClass: 'toast-bottom-right'
				          });
				          loadEmployeeEducation();
				         // disableFields();
				          $('.submitBtnName').attr('disabled', 'disabled');
				        } else {
				          toastr.error(JSON.parse(res["responseObj"]).msg, 'Error', {
				            closeButton: true,
				            positionClass: 'toast-bottom-right'
				          });
				          
				        }
					}
					
				});
				 
}



function loadEmployeeEducation(){
	
	 var branchMstId =$("#branchMstId").val();
	 if ($.fn.dataTable.isDataTable('.EmployeeMasterTable')) {
			dtTable.clear().destroy();
		}
	 	$.ajax({
				url : "${pageContext.request.contextPath}/app/common/getHelpList",//getHelpList==branchMstId
				data : JSON.stringify({
					"param" :"EMP_EDU_HELP~AND  EXISTS(SELECT 1 FROM PAY_EMP_EDU_DETAIL H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND cOalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND cOalesce(H.DELETE_FLAG,''N'')=''N'')"
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
						'<td style="text-align: right">'+(i+1)+'</td>'+
						'<td>'+(user.prop3==null ? "" : user.prop3)+'</td>'+
						'<td>'+(user.prop4==null ? "" : user.prop4)+'</td>'+
						'<td style="text-align:center">'+(user.prop5==null ? "":user.prop5)+'</td>'+
						'<td style="text-align: center;">'+
						'<a href="javascript:;" onclick="toggleTableAndForm(\'M\',\''+user.prop2+'\')" class="btn btn-primary btn-sm btn-round" title="<spring:message code="label.commonEdit"></spring:message>">'+
		                '<i class="fa fa-pencil"style="padding: 5px;"></i>'+
		              '</a>&nbsp;'+
		              '<a href="javascript:;" onclick="toggleTableAndForm(\'D\',\''+user.prop2+'\')" class="btn btn-danger btn-sm btn-round" title="<spring:message code="label.commonDelete"></spring:message>">'+
		                '<i class="fa fa-trash" style="padding: 5px;"></i>'+
		              '</a>'+
						'</td></tr>';
					});
				$('.EmployeeMasterTable1').empty().html(tbodyData);
					
					dtTable = $('.EmployeeMasterTable').DataTable({});
				}
				
			},
			failure : function() {
				console.log("failed to load list.");
			}
		}); 

	}





/* function loadEmployeeEducation() {
	let postParameters = {
		"param" : "null",
		"sqlMstId" :266
	};

	$.ajax({
		url : "${pageContext.request.contextPath}/app/common/getCodeList",
		data : JSON.stringify(postParameters),
		method : "post",
		dataType : "json",
		contentType : "application/json",
		async: false,
		success : function(resp) {
			if ($.fn.dataTable.isDataTable('.EmployeeMasterTable')) {
				dtTable.clear().destroy();
			}
			
			listofEmployeeEducation = JSON.parse(resp["codeList"]);
	
			if(listofEmployeeEducation.length){
				let tbodyData="";
				listofEmployeeEducation.forEach(function(Employee,i){
					
					tbodyData = tbodyData+'<tr>'+
					'<td width="30px" style="text-align:center">'+(i+1)+'</td>'+
					'<td style="text-align:left">'+(((Employee.employee_name)==null || (Employee.employee_name)=="") ? "" : Employee.employee_name)+'</td>'+
					'<td style="text-align:left">'+(((Employee.education)==null || (Employee.education)=="") ? "" : Employee.education)+'</td>'+
					'<td width="100px" style="text-align:right">'+(((Employee.pass_year)==null || (Employee.pass_year)=="") ? "" : Employee.pass_year) +'</td>'+
					'<td width="140px" style="text-align:right">'+(((Employee.percentage_mark)==null || (Employee.percentage_mark)=="") ? "" : Employee.percentage_mark)+'</td>'+
					'<td width="100px" style="text-align:left">'+(((Employee.grade)==null || (Employee.grade)=="") ? "" : Employee.grade)+'</td>'+
					'<td  style="text-align:left">'+(((Employee.board_university)==null || (Employee.board_university)=="") ? "" : Employee.board_university)+'</td>'+
					//'<td>'+(godown.remark=="Y" ? "<div class='label label-table label-info'>Active</div>" : "<div class='label label-table label-danger'>InActive</div>")+'</td>'+
					'<td  style="text-align:left">'+(((Employee.remark)==null || (Employee.remark)=="") ? "" : Employee.remark)+'</td>'+
					'<td width="100px" style="text-align: center;">'+
						  '<a href="javascript:;" onclick="toggleTableAndForm(\'M\',\''+Employee.employee_mst_id+'\')" class=" globEditBtn btn btn-primary btn-sm btn-round" title="Edit">'+
			                '<i class="fa fa-pencil"style="padding: 5px;"></i>'+
			             '</a>&nbsp;'+
			        
					'</td></tr>';
				});
				
				$('.EmployeeMasterTable1').empty().html(tbodyData);
				dtTable = $('.EmployeeMasterTable').DataTable({});
				//checkForUserRights(op_flag);
				
			}
		},
		failure : function() {
			console.log("failed to load list.");
		}
	});
}
 */

function getEmployee(op_flag) {
	var helpVal="";
	if(op_flag=="N"){
	 helpVal = "EMP_EDU_HELP~AND NOT EXISTS(SELECT 1 FROM PAY_EMP_EDU_DETAIL H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND cOalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND cOalesce(H.DELETE_FLAG,''N'')=''N'')";
	}
	else{
		 helpVal = "EMP_EDU_HELP~AND  EXISTS(SELECT 1 FROM PAY_EMP_EDU_DETAIL H WHERE H.EMPLOYEE_MST_ID = E.EMPLOYEE_MST_ID AND cOalesce(H.ACTIVE_FLAG,''Y'')=''Y'' AND cOalesce(H.DELETE_FLAG,''N'')=''N'')";
		}
	$.ajax({
				url : "${pageContext.request.contextPath}/app/common/getHelpListAsItIs",//getHelpList
				data : JSON.stringify({
					"param" : helpVal
				}),
				method : "post",
				dataType : "json",
				contentType : "application/json",
				async : false,
				success : function(res) {
					listOfEmployee = JSON.parse(res["helpList"]);
					$("#Employee").empty();
					$("#Employee").append('<option value="">');
					listOfEmployee.forEach(function(Employee) {
						$("#Employee").append(
								'<option value="'+Employee.employee_mst_id+'" data-employee_name="'+Employee.employee_name+'"  data-dob="'+Employee.dob+'" data-joindate="'+Employee.joindate+'" data-desig_name="'+Employee.desig_name+'"> '
										+ Employee.employee_name);
					});
					
				},
				failure : function() {
					console.log("failed to load list.");
				}
			});

}


function removeRow(trObj){
	
	if($("#opflag").val() =="M"){
		
		$.confirm({
	        title: 'Are you sure want to Remove ?',
	        content: '',
	        type: 'blue',
	        buttons: {
	            Remove: {
	            	 action: function () {
	            		 if(parseInt($(trObj).closest('tr').find('.pi_enquiry_trn_no').val())==1){
	            			 	let rowCount = 0;	            			 
	            				$(trObj).closest('tr').remove();
	            				$('.othersTableBody tr').each(function(){
	            				$(this).find('.rowCount').text($(this).index()+1);
	            				});	
	            				
	            		 }else {
	            		 	let rowCount = 0;
	            			$(trObj).closest('tr').hide();
	            			$(trObj).closest('tr').find(".rowactive").val("N");
           					$(trObj).closest('tr').find(".rowdelete_flag").val("Y");
           					
	            			let count=1;
           					$('.othersTableBody tr').each(function(i){
           						if($(this).is(":visible")){
           							$(this).find('.rowCount').text(count);
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
		
		 $.confirm({
		        title: 'Are you sure want to Remove ?',
		        content: '',
		        type: 'blue',
		        buttons: {
		            Remove: {
		            	 action: function () {
		            		 if(parseInt($(trObj).closest('tr').find('.pi_enquiry_trn_no').val())==1){
		            			 let rowCount = 0;
			            			//$(trObj).closest('tr').hide();
			            			$(trObj).closest('tr').remove();
			            			//$(trObj).closest('tr').find(".rowactive").val("N");
		           					//$(trObj).closest('tr').find(".rowdelete_flag").val("Y");
		           					
			            			let count=1;
		           					$('.othersTableBody tr').each(function(i){
		           						
		           						if($(this).is(":visible")){
		           							
		           							$(this).find('.rowCount').text(count);
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
	 }
}



function resetForm() {
	$(".error").removeClass("error");
	
	op_flag = "N";
	$('.DOB').val("");
	$('.Designation').val("");
	$('.Join').val("");
	$('.Employee').val("").trigger('change');
	$('.othersTableBody').empty();
	
	//formValidator.resetForm();
	
}
function toggleTableAndForm(flag,id){


if (showForm) {
	
	showForm = false;
	showTable = true;
	$('.showTableDiv').show();
	$('.showFormDiv').hide();
	$("#opflag").val(op_flag);
	getEmployee(flag);
	//ngOnInit();
}
else {
	if (flag == 'M') {
		//$('.formTitle').html("Update HSN Rate");
		//$('.submitBtnName').text("Update HSN Rate");
		op_flag = "M";
		
		$("#opflag").val(op_flag);
		$("id").val(id).tr
		getEmployee(op_flag);
		getlist(id);
		
		//inAbled();
	 //  setFormData(task_id);
	}
	if (flag == 'N') {
		
		$("#opflag").val(flag);
		getlist(id);
		getEmployee(flag);
		//inAbled();
	resetForm();
	}
	if (flag == 'D') {
		getlist(id);
		$('#Employee').val(id).trigger('change');
	}

	showForm = true;
	showTable = false;
	$('.showTableDiv').hide();
	$('.showFormDiv').show();
}
	}

function checkNum(id){
	$('#'+id).bind('keypress', function (event) {
	    var s = event.keyCode || event.which;
		    var regex = new RegExp("^[0-9]+$");
		    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		    if (!regex.test(key) && s != "8" && s != "9") {
		    	
		       event.preventDefault();
		       return false;
		    }else if(s == "8" || s == "9"){
		    	
		    	return true;
	 	}
		  
		})
	}



function getCheck(id){
	var val=$('#'+id).val();
	//alert(+val);
	$('#'+id).on('change', function(e) {
        if(this.value.length != 4) {
           //alert("Passing Year Cannot be less than 4 digits !!!")
           	$('#'+id).val("");
           setTimeout(function() { $('#'+id).focus(); }, 10);	
        } 
    });
}



function checkAlpha(id){
	
	
	$('#'+id).bind('keypress', function (event) {
		var s = event.keyCode || event.which;
		    var regex = new RegExp("^[a-zA-Z ]+$");
		  //  var regex = new RegExp("^[a-zA-Z]+$");
		    var key = String.fromCharCode(!event.charCode ? event.which : event.charCode);
		    
		    if (!regex.test(key) && s != "8" && s != "9") {
		       event.preventDefault();
		       return false;
		    }else if(key == "8" || s == "9"){
		    	return true;
	 	}
		  

	  })
	}


function getlist(id){

	$('.othersTableBody').empty();
let Employeid=$("#"+id).val();
console.log(Employeid+"Employeid");
	let postParameters = {
			"param" : id,
			"sqlMstId" :266
		};

		$.ajax({
			url : "${pageContext.request.contextPath}/app/common/getCodeList",
			data : JSON.stringify(postParameters),
			method : "post",
			dataType : "json",
			contentType : "application/json",
			async: false,
			success : function(resp) {
				
				listofEmployeeEducation = JSON.parse(resp["codeList"]);
				
				$.each(listofEmployeeEducation, function(i, resp) {
	 			    $('#Employee').val(resp.employee_mst_id).trigger('change');
	 				$("#Designation").val(resp.desig_name);
	 	            $("#DOB").val(resp.dob);
	 	            $("#Join").val(resp.joindate);
				
				});
				
			//	console.log("listOfGodown", listOfGodown);
				if(listofEmployeeEducation.length){
					let tbodyData="";
					listofEmployeeEducation.forEach(function(Employee,i){
						console.log(Employee.qualification,"Employee.qualification");
						$('.othersTableBody').append('<tr>'+
						'<td style="text-align:center">'+(i+1)+'</td>'+
						'<td  style="display:none">'+(i+1)+'<input type="hidden" class="rowLineNo RowCount" value="'+(i+1)+'"><input type="hidden" class="pi_enquiry_trn_no" value="0"><input type="hidden" class="rowidNo" value="'+Employee.emp_edu_det_id+'"></td>'+
						'<td style="width:150px"><select  class="form-control  input-sm mandatory rowqualification"  id="rowqualification'+i+'" style=" width: 150px;" name="rowqualification"   data-toggle="tooltip" title="<spring:message code="tooltips.Qualification"></spring:message>"><option value="">-Select-</option><option value="UG">Under-Graduate</option><option value="GA">Graduate</option><option value="PG">Post-Graduate</option><option value="Ph">Ph.D</option><option value="ot">Other</option></select></td>'+
						'<td style="width:60px;text-align:center;"><input type="checkbox"   class="rowflag" id="rowflag'+i+'"   title="<spring:message code="tooltips.Education_Before_Join"></spring:message>"></td>'+
						'<td style="text-align:right;width:150px"><input type="text" class="form-control input-sm mandatory roweducation" name="roweducation" maxlength="10"   data-toggle="tooltip" title="<spring:message code="tooltip.education.roweducation"></spring:message>" style="width: 150px; text-align:right" required value="'+ Employee.education+'"></td>'+
						'<td width="80px" ><select class="form-control input-sm mandatory rowYear" name="rowYear"  id="rowYear'+i+'" style="width:100px" data-toggle="tooltip" title="<spring:message code="tooltip.education.rowYear"></spring:message>" value="'+Employee.pass_year+'">'+yearList1+'</select></td>'+
						'<td width="80px" style="text-align:right"><input type="text" class="form-control input-sm mandatory rowMarks" name="rowMarks"  id="rowMarks'+i+'" onchange="getPercent(this.id)"   style="width: 80px; text-align:right"  data-toggle="tooltip" title="<spring:message code="tooltip.education.rowMarks"></spring:message>" value="'+Employee.percentage_mark +'"></td>'+
						'<td width="80px" style="text-align:center"><input type="text" class="form-control input-sm mandatory rowGrade" maxlength="2" name="rowGrade"  id="rowGrade'+i+'" onblur="checkAlpha(id)" style="width: 80px; text-align:right;text-transform:uppercase" data-toggle="tooltip" title="<spring:message code="tooltip.education.rowGrade"></spring:message>" value="'+ Employee.grade+'"></td>'+
						'<td width="200px"  style="text-align:center"><input type="text" class="form-control input-sm mandatory rowBoard" name="rowBoard"   style="width: 200px; text-align:right"  data-toggle="tooltip" title="<spring:message code="tooltip.education.rowBoard"></spring:message>" value="'+Employee.board_university+'" ></td>'+
						'<td width="200px" style="text-align:center"><input type="text" class="form-control input-sm mandatory Remarks" name="Remarks" style="width: 200px; text-align:right" data-toggle="tooltip" title="<spring:message code="tooltip.education.Remarks"></spring:message>" value="'+Employee.remark+'" ><input type="hidden" class="rowactive" value="Y"><input type="hidden" class="rowdelete_flag" value="N"></td>'+
						'<td style="text-align: center;">'+
			            '<button type="button" onclick="removeRow(this)" class="btn btn-danger btn-sm btn-round rowRemove" title="<spring:message code="label.commonDelete"></spring:message>">'+
			              '<i class="fa fa-trash" style="padding: 5px;"></i>'+
			            '</button>'+
					'</td>'+
						'</td></tr>');
						
						
				        $(".roweducation").alpha();
				 		$(".rowBoard").alpha();
				 		$(".Remarks").alpha();
				 		$(".rowGrade").alpha();
				 		$('.rowMarks').numeric({decimalPlaces: 0 ,negative: false});
				 	   
						$("#rowqualification"+i).val(Employee.qualification).trigger('change');
						$('.othersTableBody  tr:last').find('.rowYear').val(Employee.pass_year).trigger('change');
						$("#rowYear"+i).select2({
								width:'100%',
								placeholder:"Select",
								multiple:false,
								allowClear:true
							}); 
						$("#rowqualification"+i).select2({
							width:'100%',
							placeholder:"Select Qualification",
							allowClear:true,
							multiple:false,
							
						});
						$('.othersTable tbody tr').each(function() {
							if(Employee.before_join_flag=="Y"){
								$('#rowflag'+i).prop('checked', true);
							}
							else{
								$('#rowflag'+i).prop('checked', false);
							   }
						});
						
						
					});
					
					
					 $('.othersTableBody tr').find('input, button').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
					 $('.othersTableBody tr').find('.select2-container').tooltipster({
						    functionInit: function(instance, helper){
						        var content = $(helper.origin).closest('td').find('select').attr("title");
						        instance.content(content);
						    },
						    delay: 100,
						    theme: 'tooltipster-punk',
						    side: 'bottom'
						});
					//dtTable = $('.EmployeeMasterTable').DataTable({});
					//checkForUserRights(op_flag);
					
				}
			},
			failure : function() {
				console.log("failed to load list.");
			}
		});
}

function decimalOnly(id){
	
	$('#'+id).bind('blur', function (event) {
		  var value = $(this).val();
		  //alert(value);
		  if(value !="" || value.length!=0){
				if($('#'+id).val() != ''){
					//alert(value);
					$(this).val(parseFloat($('#'+id).val()).toFixed(2))
					
		 		}
		  }
	});
	
	}

function addItemRow(){

	
	//let totalRowCount = $('.othersTableBody').find('tbody tr').length;
	if($('.Employee').val()!="" && $('.Employee').val()!=null){
	
	var i= $('.othersTableBody tr:visible').length+1;
	
	$('.othersTableBody').append('<tr>'+
		'<td  style="text-align:center" class="rowCount" id="'+(i)+'" style="text-align: center">'+(i)+'<input type="hidden" class="rowidNo" value="0"></td>'+
		'<td  style="display:none"><input type="hidden" class="rowLineNo RowCount" value="'+(i)+'"><input type="hidden" class="pi_enquiry_trn_no" value="1"></td>'+
		
		'<td style="width:150px"><select  class="form-control input-sm mandatory rowqualification" style="width: 150px;" id="rowqualification'+i+'" name="rowqualification"   data-toggle="tooltip" title="<spring:message code="tooltips.Qualification"></spring:message>"><option value="">-Select-</option><option value="UG">Under-Graduate</option><option value="GA">Graduate</option><option value="PG">Post-Graduate</option><option value="Ph">Ph.D</option> <option value="oh">Other</option></select></td>'+
		'<td  style="width:60px;text-align:center;"><input type="checkbox" class="rowflag" id="rowflag'+i+'" title="<spring:message code="tooltips.Education_Before_Join"></spring:message>"></td>'+
		'<td style="width:150px"><input type="text" class="form-control input-sm mandatory roweducation"  name="roweducation"  id="roweducation'+i+'" maxlength="10" style="width: 150px; text-align:right" data-toggle="tooltip" title="<spring:message code="tooltip.education.roweducation"></spring:message>"></td>'+
		'<td width="100px" ><select class="form-control input-sm mandatory rowYear" name="rowYear" maxlength="4"  id="rowYear'+i+'"  style="width:100px" data-toggle="tooltip" title="<spring:message code="tooltip.education.rowYear"></spring:message>" >'+yearList1+'</select></td>'+
		'<td style="width:80px"><input type="text" class="form-control input-sm mandatory rowMarks" id="rowMarks'+i+'" onchange="getPercent(this.id)"   maxlength="11" name="rowMarks"  style="width:80px; text-align:right" data-toggle="tooltip" title="<spring:message code="tooltip.education.rowMarks"></spring:message>"></td>'+
		'<td style="width:80px"><input type="text" class="form-control input-sm mandatory rowGrade" maxlength="2" name="rowGrade"   id="rowGrade'+i+'" onblur="checkAlpha(id)"   style="width: 80px; text-align:right;text-transform:uppercase"  data-toggle="tooltip" title="<spring:message code="tooltip.education.rowGrade"></spring:message>"></td>'+
		'<td style="width:200px"><input type="text" class="form-control input-sm mandatory rowBoard" name="rowBoard" id="rowBoard'+i+'"  style="width: 200px; text-align:right" required data-toggle="tooltip" title="<spring:message code="tooltip.education.rowBoard"></spring:message>"></td>'+
		'<td style="width:200px"><input type="text" class="form-control input-sm mandatory Remarks" name="Remarks"   id="Remarks'+i+'"  style="width: 200px; text-align:right" required data-toggle="tooltip" title="<spring:message code="tooltip.education.Remarks"></spring:message>"><input type="hidden" class="rowactive" value="Y"><input type="hidden" class="rowdelete_flag" value="N"></td>'+
		//'<td><div style="display: flex;" class="pull-right"><i class="fa fa-inr" style="padding-top: 7px;"></i>&nbsp;<input type="text" class="form-control input-sm rowDiscAmt" onkeyup="calculateDiscPer(this)" style="width: 80px;text-align:right"></div></td>'+
		//'<td class="font-weight-bold" style="text-align:right"><i class="fa fa-inr" style="padding: 2px;"></i><span class="rowMaterial font-weight-bold">0.00</span></td>'+
		'<td style="text-align: center;">'+
            '<button type="button" onclick="removeRow(this)" class="btn btn-danger btn-sm btn-round rowRemove" title="<spring:message code="label.commonDelete"></spring:message>">'+
              '<i class="fa fa-trash" style="padding: 5px;"></i>'+
            '</button>'+
		'</td>'+
	'</tr>');
	//getyear();
	
	                     $(".roweducation").alpha();
				 		$(".rowBoard").alpha();
				 		$(".Remarks").alpha();
				 		$(".rowGrade").alpha();
				 		$('.rowMarks').numeric({decimalPlaces: 0 ,negative: false});
	
				 		$('.othersTableBody').find("#rowqualification"+i).select2({
							width:'100%',
							placeholder:"Select Qualification",
							allowClear:true,
							multiple:false,
							
						});
	$('.othersTableBody').find("#rowYear"+i).select2({
								width:'100%',
								placeholder:"Select",
								multiple:false,
								allowClear:true
							}).val(null).trigger('change');

	/* .select2({
		width : 'resolve',
		placeholder : "Select Model",
		allowClear : false,
		maximumSelectionSize : 1
	}).val(null).trigger('change'); */

	
	 $('.othersTableBody tr:last').find('input, button').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
	 $('.othersTableBody tr:last').find('.select2-container').tooltipster({
		    functionInit: function(instance, helper){
		        var content = $(helper.origin).closest('td').find('select').attr("title");
		        instance.content(content);
		    },
		    delay: 100,
		    theme: 'tooltipster-punk',
		    side: 'bottom'
		}); 
	}else{

		toastr.error("Please Select Employee Name first", 'Alert', {
            closeButton: true,
            positionClass: 'toast-bottom-right'
          });
		}
}

</script>

</head>
<body>
<input type="hidden" id="opflag" value="">
<div class="row showTableDiv">
		<div class="col-lg-12">
			<div class="panel newPanel">
				<div class="panel-heading">
					<div class="panel-control">
						<!-- <button class="btn btn-default" data-click="panel-expand">
							<i class="fa fa-expand"></i>
						</button>
						<button class="btn btn-default" data-click="panel-reload">
							<i class="fa fa-refresh"></i>
						</button> -->
						<button class="btn btn-default" data-click="panel-collapse">
							<i class="fa fa-chevron-down"></i>
						</button>
						<button class="btn btn-default closeFormBtn" data-dismiss="panel" onclick="closeActiveForm()"><i class="fa fa-times"></i></button>
						<button onclick="toggleTableAndForm('N',null)"
							class="btn btn-info addNewBtnOnForm">
							<i class="fa fa-plus"></i>  <spring:message code="label.Add_Education_Details"></spring:message>  
						</button>
					</div>
					<h3 class="panel-title"><spring:message code="label.Employee_Education_Details"></spring:message> </h3>
				</div>
				<div class="panel-body">
				<table class="table table-striped table-bordered table-hover table-responsive EmployeeMasterTable table-responsive" width="100%">
							<thead>
								<tr>
								<th style="text-align:center"> <spring:message code="label.Sr_No"></spring:message></th>
								   <th style="text-align:center"><spring:message code="label.Employee_Name"></spring:message></th>
									<th style="text-align:center">Designation</th>
									<th style="text-align:center">Date of Birth</th>
									<%-- <th style="text-align:center"><spring:message code="label.Marks(%)"></spring:message></th>
									<th style="text-align:center"> <spring:message code="label.Grade"></spring:message></th>
									<th style="text-align:center"> <spring:message code="label.Board/University"></spring:message></th>
									<th style="text-align:center"> <spring:message code="label.Remarks"></spring:message></th> --%>
							<th style="text-align:center"><spring:message code="label.Action"></spring:message></th>
								</tr>
							</thead>
							<tbody class="EmployeeMasterTable1">
								
							</tbody>
						</table>
				
				
				</div>
			</div>
		</div>
	</div>
		<div class="row showFormDiv">
		<div class="col-lg-12">
			<form id="EmployeeEducationForm">
				<div class="panel newPanel">
					<div class="panel-heading">
						<div class="panel-control">
						<!-- 	<button class="btn btn-default" data-click="panel-expand">
								<i class="fa fa-expand"></i>
							</button>
							<button class="btn btn-default" data-click="panel-reload">
								<i class="fa fa-refresh"></i>
							</button> -->
							<!-- <button class="btn btn-default" data-click="panel-collapse">
								<i class="fa fa-chevron-down"></i>
							</button> -->
							<button class="btn btn-default closeFormBtn" data-dismiss="panel" onclick="closeActiveForm()"><i class="fa fa-times"></i></button>
							<button onclick="toggleTableAndForm('N',null);" type="button"
								class="btn btn-success"><spring:message code="label.commonBackToList"></spring:message></button>
						</div>
						<h3 class="panel-title formTitle"><spring:message code="label.Employee_Education_Details"></spring:message></h3>
					</div>
					<div class="panel-body">
					<div class="row">
						<div class="col-md-3">
												<div class="form-group">
					                     			<label class="control-label"><spring:message code="label.Employee_Name"></spring:message><span style="color: red;"> *</span></label>		
			<!-- onchange="getlist(this.id)" -->		                       			<select  id="Employee"  name ="Employee" class="form-control Employee "  style="width: 100%; height: 30px" required data-toggle="tooltip" title="<spring:message code="tooltip.education.Employee"></spring:message>">									
					                       				<option value=""></option>
					                       			</select>
					                       			<small style="color: red;"></small>
					                      		</div>
											</div>
						
								<div class="col-md-3">
												<div class="form-group">
					                     			<label class="control-label"><spring:message code="label.Designation"></spring:message></label>		
					                       			<input type="text"  id="Designation" name ="Designation" class="form-control Designation" disabled>									
					                       				
					                       			</select>
					                       			
					                      		</div>
									</div>
										<div class="col-md-3">
												<div class="form-group">
					                     			<label class="control-label"> <spring:message code="label.DOB"></spring:message></label>		
					                       			<input type="text"  id="DOB" name ="DOB" class="form-control DOB" disabled>		
					                      		</div>
									</div>
										<div class="col-md-3">
												<div class="form-group">
					                     			<label class="control-label"> <spring:message code="label.Join_Date"></spring:message></label>		
					                       			<input type="text"  id="Join" name ="Join" class="form-control Join" disabled>		
					                      		</div>
									</div>
							</div>
							
							   <div class="">
							  
									<button type="button" class="pull-right btn btn-primary addBtn" onclick="addItemRow()" style="margin: 10px;"><i class="fa fa-plus"></i><spring:message code="label.add_row"></spring:message></button>
								</div>
							       	<div class="table-responsive">
							       	 <h5 style="color:red"> <spring:message code="label.Note_Please_add_Qualification_in_Ascending_Order"></spring:message></h5>
				                    	<table class="table table-striped table-hover table-vcenter table-bordered othersTable" width="100%">
				                    		<thead>
				                               <tr>
				                                <th style="text-align:center"> <spring:message code="label.Sr_No"></spring:message></th>
								  <th style="text-align:center"><spring:message code="label.Qualification"></spring:message></th> 
									<th style="text-align:center"><spring:message code="label.Education_Before_Join"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Education"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Passing_Year"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Marks(%)"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Grade"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Board/University"></spring:message></th>
									<th style="text-align:center"><spring:message code="label.Remarks"></spring:message></th>
				                     <th style="text-align:center"><spring:message code="label.Remove"></spring:message></th>
				                               </tr>
				                           </thead>
				                           <tbody class="othersTableBody">
				                           
				                           </tbody>
				                    	</table>
				                    </div>
							 <div class="row">
		             	<div class="visibleSubmitIfHaveRight">
		                    <button  class="btn btn-primary pull-right submitBtnName formSaveButton" type="button" onclick="saveUpdateDelete()" ><i class="fa fa-save"></i>&nbsp;<spring:message code="label.commonSave"></spring:message></button>
		                </div>
		            </div>
					</div>
					</div>
					</form>
					</div>
					</div>
					
