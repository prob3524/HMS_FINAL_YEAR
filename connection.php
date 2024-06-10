<?php
    $connection= new mysqli("localhost","root","","sh_project");
    $appUrl = "http://localhost/hospital";
    if ($connection->connect_error){
        die("Connection failed:  ".$connection->connect_error);
    }
?>