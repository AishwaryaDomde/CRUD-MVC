<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css"
    href="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.css" />
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
  <script type="text/javascript"
    src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.10.20/af-2.3.4/b-1.6.1/b-html5-1.6.1/b-print-1.6.1/fc-3.3.0/kt-2.5.1/r-2.2.3/rr-1.2.6/sc-2.0.1/sl-1.3.1/datatables.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <style>
    .View_middle {
      min-height: 100%;
      /* Fallback for browsers do NOT support vh unit */
      min-height: 100vh;
      /* These two lines are counted as one :-)       */
      display: flex;
      align-items: center;
    }
  </style>
  <script>
    $(document).ready(function () {
     var m=JSON.parse($("#Person_data").text());
		 $("#id").val(m["id"]);
         $("#fname").val(m["fname"]);
         $("#lname").val(m["lname"]);
         $("#email").val(m["email"]);
         $("#contact").val(m["contact"]);
         $("#gender").val(m["gender"]);
         $("#pswd").val(m["pswd"]);
           
//       });
   
    });
  </script>
</head>

<body>
  <div id=Person_data hidden>${User}</div>
  
      <div class="card bg-light text-dark">
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/addPerson" class="needs-validation" novalidate modelAttribute="PersonModel">
            <div class="row">
              <div class="col-sm-6">
                <div class="form-group">
                  <input type="text" name="id" value="" id="id" hidden>
                  <label for="uname">FirstName:</label>
                  <input type="text" class="form-control" id="fname" placeholder="Enter username" name="fname" required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="uname">Last Name:</label>
                  <input type="text" class="form-control" id="lname" placeholder="Enter username" name="lname" required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="uname">Email:</label>
                  <input type="text" class="form-control" id="email" placeholder="Enter username" name="email" required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="uname">Gender:</label>
                  <input type="text" class="form-control" id="gender" placeholder="Enter username" name="gender"
                    required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="uname">Contact No:</label>
                  <input type="text" class="form-control" id="contact" placeholder="Enter username" name="contact"
                    required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="pwd">Password:</label>
                  <input type="password" class="form-control" id="pswd" placeholder="Enter password" name="pswd"
                    required>
                  <div class="valid-feedback">Valid.</div>
                  <div class="invalid-feedback">Please fill out this field.</div>
                </div>
              </div>
              <div class="col-sm-6">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
            </div>
          </form>
        </div>
      </div>

    
  <script>
    // Disable form submissions if there are invalid fields
    (function () {
      'use strict';
      window.addEventListener('load', function () {
        // Get the forms we want to add validation styles to
        var forms = document.getElementsByClassName('needs-validation');
        // Loop over them and prevent submission
        var validation = Array.prototype.filter.call(forms, function (form) {
          form.addEventListener('submit', function (event) {
            if (form.checkValidity() === false) {
              event.preventDefault();
              event.stopPropagation();
            }
            form.classList.add('was-validated');
          }, false);
        });
      }, false);
    })();
  </script>

</body>

</html>