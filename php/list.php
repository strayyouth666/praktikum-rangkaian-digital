<?php
    $connection = new mysqli("localhost","root","","rdig");
        $data       = mysqli_query($connection, "select * from user");
        $data       = mysqli_fetch_all($data, MYSQLI_ASSOC);

        echo json_encode($data);