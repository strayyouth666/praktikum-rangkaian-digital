//<?php
//    include 'DatabaseConfig.php';
//    $con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName) or die('cannot connect');
//
//    $username = $_POST['username'];
//    $password = $_POST['password'];
//    $fullname = $_POST['fullname'];
//
//     if (empty($username) || empty ($password)) {
//        echoData('Fill all fields');
//       } else {
//        checkUserExit())
//
//     // Check User is New Or Already Registered
//    function checkUserExit()
//        global $db;
//        global $username;
//
//        $userQuery "SELECT * FROM userData WHERE username ='$username'";
//        $sendingQuery = mysqli_query($db, $userQuery);
//        $checkQuery = mysqli_num_rows($sendingQuery);
//
//         if ($checkQuery 1) {
//            //if Username is already registered
//            tryLogin();
//         } else {
//            if (empty ($fullname)) {
//                echoData('Type Full Name');
//            } else {
//                trySignup();
//            }
//         }
//
//         function trySignup()
//             global $db;
//             global $username;
//             global $password;
//             global $fullname;
//
//             $hashPwd= password_hash($password PASSWORD_DEFAULT);
//
//             $insert = "INSERT INTO userData (fullname, username, password)VALUES('$fullname','$username', '$hashPwd')";
//             $query = = mysqli_query ($db, $insert);
//
//             if ($query) {
//                 echoData("Account Created");
//              } else {
//                 echoData("Getting Error");
//              }
//          }
//
//          function echoData($result)
//          {
//             echo json_encode($result);
//          }
//
////          #crud
////          $action = $_POST["action"];
////
////          #connection
////          $conn = new mysqli($servername, $username, $password, $dbname);
////
////          #check connection
////            if($conn->connect_error){
////                die("Connection Failed: " . conn->connect_error);
////                return;
////            }
////
////            // If connections OK
////
////            // If the app sends an action to create the table..
////            if("CREATE_TABLE" == $action){
////                $sql  = "CREATE TABLE IF NOT EXISTS $table (
////                    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
////                    first_name VARCHAR(30) NOT NULL,
////                    last_name VARCHAR(30) NOT NULL
////                    )";
////
////            if($conn->query($sql) == TRUE) {
////                // send back success message
////                echo "success";
////            } else {
////                echo "error";
////            }
////            $conn->close();
////            return;
////        }
////
////        //GET ALL
////        if("GET_ALL" == $action){
////            $db_data = array();
////            $sql = "SELECT id, first_name, last_name from $stable ORDER BY id DESC";
////            $result = $conn->query($sql);
////            if($result->num_rows > 0){
////                while($row = $result->fetch_assoc()){
////                    $db_data[] = $row;
////                }
////                //send back the complete records as a json
////                echo json_encode(@db_data);
////            } else{
////                echo "error";
////            }
////            $conn->close();
////            return;
////        }
////
////        //Add an user
////        if("ADD_USER" == $action){
////             //App will be posting these values to this server
////            $first_name = $_POST["first_name"];
////            $last_name = $_POST["last_name"];
////            $sql = "INSERT INTO $table (first_name, last_name) VALUES ('$first_name', '$last_name')";
////            $result = $conn->query($sql);
////            echo "success";
////            $conn->close();
////            return;
////        }
////
////        // Update an user
////        if("UPDATE_USER" == $action){
////            //App will be posting these values to this server
////            $user_id = $_POST['$user_id'];
////            $first_name = $_POST["first_name"];
////            $last_name = $_POST["last_name"];
////            $sql = "UPDATE $table SET first_name = '$first_name', last_name = '$last_name' WHERE id = '$user' ";
////            if($conn->query($sql) === TRUE){
////                echo "success";
////            } else {
////                echo "error";
////            }
////            $conn->close();
////            return;
////        }
////
////        //DELETE
////        if('DELETE_USER') == $action){
////            $user_id = $_POST['$user_id'];
////            $sql = "DELETE FROM $table WHERE id = $user_id"; //
////            if($conn->query($sql) === TRUE) {
////                echo "success";
////            } else {
////                echo "error";
////            }
////            $conn->close();
////            return;
////        }
//
//
//?>