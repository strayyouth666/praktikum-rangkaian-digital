<?php

    $connection = new mysqli("localhost", "root", "", "rdig");

    $id = $_POST['id'];

    $result = mysqli_query($connection, "delete from rdig where id=".$id);

    if($result){
        echo json_encode([
            'message' => 'Data delete successfully'
        ]);
    }else{
        echo json_encode([
            'message' => 'Data Failed to delete'
        ]);
    }
?>