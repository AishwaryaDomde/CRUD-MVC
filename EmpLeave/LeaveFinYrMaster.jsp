<!--=====================================================================
------------This JSP Page Generated By System---
Original Author - SANKER EPS -Aishwarya Domde      
Creation Date	- Apr 22, 2019 10:57:17 AM  3:00:31 PM 
Project Name	- MLWB 
Module Name		- Payroll
Page			- 
Description		- Employee Financial Leave Year Master
Link			-
	 Modify Author	  -    Modify Date    -    
1)		
2)
3)
=====================================================================-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Leave Financial Year Master Master</title>
<!--Chosen -->
<link href="assets/plugins/chosen/chosen.min.css" rel="stylesheet">
<script src="assets/plugins/numeric/jquery.numeric.min.js"></script>
<link href="assets/plugins/select2/select2.min.css" rel="stylesheet">
<!--For Datepicker -->
<link href="assets/plugins/jqueryUI-DatepickerCSS/datepicker.css" rel="stylesheet">
<script src="assets/plugins/jquery-ui/jquery-ui.min.js"></script>
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
<script src="assets/plugins/alphanum/jquery.alphanum.js"></script>
<script src="assets/plugins/select2/select2.min.js"></script>
<style type="text/css">
.control-label:after{
	content:"*";
	color:red;
}
th.sorting {
    text-align: center;
}
</style>
<script type="text/javascript">
let global_LeavMstId = 0;
let op_flag = "N";
let showForm = false;
let showTable = true;
let CourtPanelList;
$(document).ready(function(){
	$('.showTableDiv').show();
	$('.showFormDiv').hide();
	LoadListTbl();
	validateForm();
	$("select").select2({
		placeholder:"Select",
		width:'100%',
		multiple:false,
		allowClear:true,		
	});
	$("#finYearStartDate").datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: "dd/mm/yy",
	 }); 
	$("#finYearEndDate").datepicker({
	    changeMonth: true,
	    changeYear: true,
	    dateFormat: "dd/mm/yy",
	 }); 
	/*********************************************************************/
	$('form').find('input').tooltipster({delay: 100,theme: 'tooltipster-punk',side: 'bottom'});
	$('.select2-container').tooltipster({
	    functionInit: function(instance, helper){
	        let content = $(helper.origin).closest('.form-group').find('select').attr("title");
	        instance.content(content);
	    },
	    delay: 100,
	    theme: 'tooltipster-punk',
	    side: 'bottom'
	});
	/*********************************************************************/
	$('form').on('keyup change paste blur select2:close', 'input, select, textarea, button, a', function(event){
		let elem = event.target;
		let elValid = false;
		if (!$(elem).valid()) {
			elValid = true;
	    }
	    $('.mandatory').each(function() {
	    	if ($(this).val()=='' || $(this).val()==null) {
				elValid = true;
	        }
	    });
	    if (elValid) {
	    	$('.submitBtnName').attr('disabled', 'disabled');
	    } else {
	    	$('.submitBtnName').removeAttr('disabled');
	    	
	    }
	});
	 /********************************************************/
	 $("#SaveLeaveFinYrMaster").on("click",function(){
		if($("#LeaveFinYrMaster").valid()){
			let postParameters = {
					opFlag	   			: op_flag,
					userId				: $("#userId").val(),
					branchMstId			: $("#branchMstId").val(),
					global_LeavMstId  	: global_LeavMstId,
                    finYearStartDate  	: $("#finYearStartDate").val(),
                    finYearEndDate	  	: $("#finYearEndDate").val(),
                    currentFinYearFlag	: $("#currentFinYearFlag").val(),
                    finYearMstId	  	: $("#finYearMstId").val()
			}	
			if(op_flag=="D"){
				$.confirm({
	                title: 'Are you sure want to delete ?',
	                content: '',
	                type: 'blue',
	                buttons: {
			            Delete: {			              
			                action: function () {
			                   deleteRecord(postParameters);
			                }
			            },
			            Cancel: {
			                keys: ['N'],
			                action: function () {
			                	$('.showFormDiv').hide();
			                    $('.showTableDiv').show();
			                }
			            },
			        }
	            }); 
			}else if(op_flag=="M" || op_flag=="N"){
				$.ajax({
					url : "${pageContext.request.contextPath}/app/payroll/EmpLeave/LeaveDetails/SaveLeaveFinYr",
					data : JSON.stringify(postParameters),
					method : "post",
					dataType : "json",
					contentType : "application/json",
					success : function(res) {
					 	if (JSON.parse(res["responseObj"]).status == "success") {
				         	toastr.success(JSON.parse(res["responseObj"]).msg,'Success', {
				            closeButton: true,
				            positionClass: 'toast-bottom-right'
				          });
				          showForm = true;
				          EnableInputs();
				          LoadListTbl();
				          resetForm();
				        } else {
				          	toastr.error(JSON.parse(res["responseObj"]).msg, 'Error', {
				            closeButton: true,
				            positionClass: 'toast-top-right'
				          });
				        }
					}
				});
			}
		}
	});
});
/********************************************************/
function toggleTableAndForm(flag, FinLeavMstId) {
	if (showForm) {
		showForm = false;
		showTable = true;
		$('.showTableDiv').show();
		$('.showFormDiv').hide();
	} else {
		if (flag == 'M') {
			$("#ResetLeaveFinYrMaster").show();
			$('.formTitle').html('Update Leave Financial Year Master Master');
			$('.submitBtnName').html('<i class="fa fa-save"></i> Update Leave Financial Year Master');
			op_flag = "M";			
			DisableInputs();
			setFormData(FinLeavMstId);
		}
		if (flag == 'N') {		
			$("#ResetLeaveFinYrMaster").show();
			$('.formTitle').html('Create New Leave Financial Year Master');
			$('.submitBtnName').html('<i class="fa fa-save"></i> Save Leave Financial Year Master');
			$('.submitBtnName').attr('disabled', 'disabled');
			DisableInputs();
			resetForm();
			$('.showTableDiv').show();	
		}
		if (flag == 'D') {
			$("#ResetLeaveFinYrMaster").hide();
			$('.formTitle').html('Delete Leave Financial Year Master Master');
			$('.submitBtnName').html('<i class="fa fa-save"></i>  Delete Leave Financial Year Master');
			EnableInputs();
			op_flag = "D";	
			setFormData(FinLeavMstId);
		}
		showForm = true;
		showTable = false;
		$('.showTableDiv').hide();
		$('.showFormDiv').show();
	}	
}
/******************************************************/
function resetForm(){
	$("#finYearStartDate").val("");
	$("#finYearEndDate").val("");
	$("#currentFinYearFlag").val("").trigger('change');
	$("#finYearMstId").val("").trigger('change');
	op_flag="N";
	global_LeavMstId=0;
	$('input,.select2').removeClass('error'); 
	formValidator.resetForm();
	DisableInputs();
}
/******************************************************/
function EnableInputs(){
	$("#finYearStartDate").attr('disabled', 'disabled');
	$("#finYearEndDate").attr('disabled', 'disabled');
	$("#currentFinYearFlag").attr('disabled', 'disabled');
	$("#finYearMstId").attr('disabled', 'disabled');
}
/******************************************************/
function DisableInputs(){
	$("#finYearStartDate").removeAttr('disabled');
	$("#finYearEndDate").removeAttr('disabled');
	$("#currentFinYearFlag").removeAttr('disabled');
	$("#finYearMstId").removeAttr('disabled');
}
/***************************************************/
function LoadListTbl(){
	$.ajax({
		url: "${pageContext.request.contextPath}/app/common/getCodeList",
		data : JSON.stringify({
			"param" :$("#userId").val()+"~null",
			"sqlMstId" : 7094
		}),
		method : "post",
		dataType : "json",
		contentType : "application/json",
		async: false,
        success: function (resp) {
       	 	if ($.fn.DataTable.isDataTable('#detailList')) {
                $('#detailList').DataTable().destroy();
            }
            $("#detailList tbody").empty();
        	CourtPanelList = JSON.parse(resp["codeList"]);
        	let datacourt=[];
        	let keyVal=0;
        	 $.each(CourtPanelList, function (key,i) {
        		keyVal=keyVal+1;
     			datacourt.push([keyVal,CourtPanelList[key]['fin_year_start_date'],CourtPanelList[key]['fin_year_end_date'],CourtPanelList[key]['fin_code'],
   				'<a href="javascript:;" onclick="toggleTableAndForm(\'M\',\''+CourtPanelList[key]['fin_year_mst_id']+'\')" class="btn btn-primary btn-sm btn-round" title="Edit">'+
                '<i class="fa fa-pencil"style="padding: 5px;"></i>'+
	            '</a>&nbsp;'+
	            '<a href="javascript:;" onclick="toggleTableAndForm(\'D\',\''+CourtPanelList[key]['fin_year_mst_id']+'\')" class="btn btn-danger btn-sm btn-round" title="Delete">'+
	            '<i class="fa fa-trash" style="padding: 5px;"></i>'+
	            '</a>']);        		
        	 });
        	 $('#detailList').DataTable({
                 data: datacourt,
                 "autoWidth": false,
                 deferRender: true,
                 pageLength: 10,
                 "bLengthChange": false,
                 info: false,
                 scrollCollapse: true,
                 responsive: true,
                 "columnDefs": [
                     {
                         "className": "text-center ",
                         "targets": [0,1,2,4]
                     } , {
                         "className": "text-right ",
                         "targets": [3]
                     } 
                    ]
             });
		},
		failure : function() {
			console.log("failed to load list.");
		}		
	});
}
/**********************Setting for Modify**************/
function setFormData(FinLeavMstId){
	$.each(CourtPanelList, function (key,i) {
		if(CourtPanelList[key]['fin_year_mst_id']==FinLeavMstId){
			global_LeavMstId=FinLeavMstId;
			$("#finYearStartDate").val(CourtPanelList[key]['fin_year_start_date']);
			$("#finYearEndDate").val(CourtPanelList[key]['fin_year_end_date']);
			$("#currentFinYearFlag").val(CourtPanelList[key]['current_fin_year_flag']).trigger('change');
			$("#finYearMstId").val(CourtPanelList[key]['fin_code']).trigger('change')
		}
	});
}
/******************************************************************/
 function deleteRecord(postParameters){
	$.ajax({
		url : "${pageContext.request.contextPath}/app/CourtCase/Save_CSecrtPanel",
		data : JSON.stringify(postParameters),
		method : "post",
		dataType : "json",
		contentType : "application/json",
		success : function(res) {
		 	if (JSON.parse(res["responseObj"]).status == "success") {
	          toastr.success(JSON.parse(res["responseObj"]).msg,'Success', {
	            closeButton: true,
	            positionClass: 'toast-bottom-right'
	          });
	          resetForm();
	          LoadListTbl();
	        } else {
	          toastr.error(JSON.parse(res["responseObj"]).msg, 'Error', {
	            closeButton: true,
	            positionClass: 'toast-bottom-right'
	          });
	        }
		}
	});
}
/********************************************************/
function validateForm(){
	formValidator = $("#LeaveFinYrMaster").validate({
		ignore: [], 
        rules: {
            "finYearStartDate": {
                required: true,
            },
            "finYearEndDate": {
                required: true,
            },
            "currentFinYearFlag" : {
            	required: true,
            },
            "finYearMstId" :{
            	required: true,
            }
        },
        messages: {
            "finYearStartDate": {
                required: "Please enter Sart Date",
            },
            "finYearEndDate": {
                required: "Please enter End Date",
            },
            "currentFinYearFlag" : {
            	required: "Please enter Year Flag",
            },
            "finYearMstId" :{
            	required: "Please enter Year",
            }
        },
        highlight: function (element, errorClass, validClass) {
            let elem = $(element);
            elem.addClass(errorClass);
            elem.siblings('.select2-container').addClass(errorClass); 
        },    
        unhighlight: function (element, errorClass, validClass) {
              let elem = $(element);
              elem.removeClass(errorClass);
              elem.siblings('small').empty();
              elem.siblings('.select2-container').removeClass(errorClass); 
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
</head>
<body>
<%@page import="com.vgipl.erp.login.model.User"%>
<%	
		User userObject =(User) request.getSession().getAttribute("currentUser");
		String userName = userObject.getUsername().toString();
		String branchName = userObject.getBranchName().toString();
		String branchMstId = userObject.getBranchMstId();
		String userId = userObject.getUserId();
		String DeptId=userObject.getDeptId();
		String workingDate = userObject.getWorkingDate().toString();
		System.out.print("www"+workingDate);
	    String flag ="N";// request.getAttribute("flag").toString();
	    String rights ="Y~Y~Y~Y~Y~Y";//request.getAttribute("rights").toString();
	    String rightsArr[] = rights.split("~");
%>
<input type="hidden" id="addRight" value="<%=rightsArr[0]%>">
<input type="hidden" id="modRight" value="<%=rightsArr[1]%>">
<input type="hidden" id="delRight" value="<%=rightsArr[2]%>">
<input type="hidden" id="viewRight" value="<%=rightsArr[3]%>">
<input type="hidden" id="printRight" value="<%=rightsArr[4]%>">
<input type="hidden" id="speRight" value="<%=rightsArr[5]%>">
<input type="hidden" id="branchMstId" value="<%=branchMstId%>">
<input type="hidden" id="userId" value="<%=userId%>">
<input type="hidden" id="finYrId" value="<%=userObject.getLoggedInFinYrId()%>">
<input type="hidden" id="flag" value="<%=flag%>">
<input type="hidden" id="workingDate" value="<%=workingDate%>">
<div class="row showTableDiv">
	<div class="col-lg-12">
		<div class="panel newPanel">
			<div class="panel-heading">
				<div class="panel-control">
					<button class="btn btn-default" data-click="panel-expand">
						<i class="fa fa-expand"></i>
					</button>
					<button class="btn btn-default" data-click="panel-reload" onclick="loadListOfLocation();">
						<i class="fa fa-refresh"></i>
					</button>
					<button class="btn btn-default" data-click="panel-collapse">
						<i class="fa fa-chevron-down"></i>
					</button>
					 <button class="btn btn-default closeFormBtn" data-dismiss="panel" onclick="closeActiveForm()"><i class="fa fa-times"></i></button>
					<button onclick="toggleTableAndForm('N',null)" class="btn btn-info">
						<i class="fa fa-plus"></i> Add New
					</button>
				</div>
				<h3 class="panel-title">Leave Financial Year Master Master</h3>
			</div>
			<div class="panel-body">				
				<table class="table table-striped table-bordered table-hover locationMasterTable table-responsive" id="detailList">
					<thead>
						<tr>
							<th>Sr. No.</th>
							<th>Year Start Name</th>
							<th>Year End Name</th>
							<th>Code</th>
							<th>Action</th>						
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>				
			</div>
		</div>
	</div>
</div>
<!------------------------------------------------------------>
<div class="row showFormDiv">
	<div class="col-lg-12">
		<form id="LeaveFinYrMaster">
			<div class="panel newPanel">
				<div class="panel-heading">
					<div class="panel-control">
						<button class="btn btn-default" data-click="panel-expand">
							<i class="fa fa-expand"></i>
						</button>
						<button class="btn btn-default" data-click="panel-reload">
							<i class="fa fa-refresh"></i>
						</button>
						<button class="btn btn-default" data-click="panel-collapse">
							<i class="fa fa-chevron-down"></i>
						</button>
						<button class="btn btn-default closeFormBtn" data-dismiss="panel" onclick="closeActiveForm()">
							<i class="fa fa-times"></i>
						</button>
						<button onclick="toggleTableAndForm('N',null);" type="button" class="btn btn-success">
						<i class="fa fa-chevron-left"></i>&nbsp; Back to List </button>
					</div>
					<h3 class="panel-title formTitle">Create New Leave Financial Year Master </h3>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								<label for="finYearMstId " class="control-label">
									<spring:message code="label.finYearMstId"></spring:message></label>
								<input type=text  name="finYearMstId " class="form-control mandatory" data-toggle="tooltip"  required
								  title="Select <spring:message code="label.finYearMstId"></spring:message>"  id="finYearMstId">
								<small style="color: red"></small>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
							
							<div class="form-group has-feedback">	
									<label for="finYearStartDate" class="control-label">
										<spring:message code="label.finYearStartDate"></spring:message></label>
									<input name="finYearStartDate" type="text" class="form-control mandatory" data-toggle="tooltip" id="finYearStartDate" required
									 placeholder="dd/mm/yy" maxlength="10" style="text-align: center;"  title="Enter <spring:message code="label.finYearStartDate"></spring:message>">
									<span class="fa fa-calendar fa-lg form-control-feedback"></span>
								</div>
							<small style="color: red"></small>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-3">
							<div class="form-group">
								  <div class="form-group has-feedback">	
									<label for="finYearEndDate" class="control-label">
										<spring:message code="label.finYearEndDate"></spring:message></label>
									<input name="finYearEndDate" type="text" class="form-control mandatory" data-toggle="tooltip" id="finYearEndDate" required
									 placeholder="dd/mm/yy" maxlength="10" style="text-align: center;"  title="Enter <spring:message code="label.finYearEndDate"></spring:message>">
									<span class="fa fa-calendar fa-lg form-control-feedback"></span>
								</div>
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label for="currentFinYearFlag " class="control-label">
									<spring:message code="label.currentFinYearFlag"></spring:message></label>
								<select name="currentFinYearFlag " class="form-control mandatory" data-toggle="tooltip"   required
								  title="Select <spring:message code="label.currentFinYearFlag"></spring:message>"  id="currentFinYearFlag">
								  	<option value="Y">Yes</option>
									<option value="N">No</option>
								</select><small style="color: red"></small>
							</div>
						</div>
					</div>
					<hr>
					<button  class="btn btn-primary submitBtnName" type="button" id="SaveLeaveFinYrMaster">
					<i class="fa fa-save"></i> Save Leave Financial Year Master
					</button>
					&nbsp;
					<button type="button" class="btn resetBtnName btn-danger" id="ResetLeaveFinYrMaster" onclick="resetForm()">
					Reset
					</button>					
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>