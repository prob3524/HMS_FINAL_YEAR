<?php
session_start();
include "../connection.php";

// Check if the user is authenticated
if (!isset($_SESSION['user'])) {
    $_SESSION['success'] = false;
    $_SESSION['message'] = "Authentication failed";
    header("location: $appUrl/login.php");
    exit;
} else if (isset($_SESSION["role"]) && $_SESSION["role"] != "doctors") {
    setcookie('user', '', time() - 3600, '/');
    $_SESSION['success'] = false;
    $_SESSION['message'] = "You are not authorized to access the doctor site.";
    header("location: $appUrl/login.php");
    exit;
}

$pageTitle = "View Appointment";
require_once "../components/header.php";

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    // Fetch receptionist details from the database based on $id
    $sql = "SELECT appointments.*, CONCAT(patients.first_name, ' ', patients.last_name) AS patient_namee, diagnosis.diagnosis_name
    FROM appointments
    LEFT JOIN patients ON appointments.patient_id = patients.id LEFT JOIN diagnosis ON appointments.diagnosis = diagnosis.id
    WHERE appointments.id = $id;";


    $result = mysqli_query($connection, $sql);
    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $appointment_id = $row['id'];
        $patientName = $row['patient_namee'];
        $diagnosis = $row['diagnosis_name'];
        $opdDate = $row['opd_date'];
        $description = $row['description'];
        $created_at = $row['created_at'];
        $status = $row['status'];
    } else {
        echo "Appointment not found.";
    }
    $prescriptionQuery = "SELECT * FROM prescriptions WHERE appointment_id = $appointment_id";
    $prescriptionResult = mysqli_query($connection, $prescriptionQuery);

    if ($prescriptionResult && $prescriptionResult->num_rows > 0) {
        $prescriptionRow = $prescriptionResult->fetch_assoc();
        $prescriptionDetails = trim($prescriptionRow['prescription_details']);
    } else {
        $prescriptionDetails = "No prescription available.";
    }
} else {
    echo "Invalid ID.";
}

?>

<div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed">
    <!-- Sidebar Start -->
    <aside class="left-sidebar">
        <div>
            <div class="brand-logo d-flex align-items-center justify-content-between">
                <a href="<?php echo $appUrl; ?>" class="navbar-brand" style="font-size:30px">
                    Hospital
                </a>
                <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
                    <i class="fa fa-times"></i>
                </div>
            </div>
            <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
                <div class="sidebar">
                    <ul id="sideNav">
                    </ul>
                </div>
            </nav>
        </div>
    </aside>
    <!--  Sidebar End -->
    <!--  Main wrapper -->
    <div class="body-wrapper">
        <!--  Header Start -->
        <?php require_once "../components/profileHeader.php" ?>

        <div>
            <div class="p-5">
                <?php
                if (isset($_SESSION['message']) && isset($_SESSION['success'])) {
                    $message = $_SESSION['message'];
                    $success = $_SESSION['success'];
                    $toastType = $success ? 'success' : 'error';
                    echo "<script>
          toastr.options = {
            positionClass: 'toast-top-right',
            timeOut: 2000,
            progressBar: true,
          }; toastr.$toastType('$message');</script>";
                    unset($_SESSION['message']);
                    unset($_SESSION['success']);
                }
                ?>
                <div class="d-flex justify-content-between">
                    <h3>View Appointment</h3>
                    <a class="btn btn-outline-secondary" href="./appointments.php">Back</a>
                </div>
                <div class="container-fluid" style="padding-top:0">
                    <div class="card mt-3">
                        <div class="pt-0 card-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <td class="py-4 fw-bold">Patient Name:</td>
                                            <td class="py-4"><?php echo $patientName; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="py-4 fw-bold">Diagnosis:</td>
                                            <td class="py-4"><?php echo $diagnosis; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="py-4 fw-bold">OPD Date:</td>
                                            <td class="py-4"><?php echo $opdDate; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="py-4 fw-bold">Description:</td>
                                            <td class="py-4"><?php echo $description; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="py-4 fw-bold">Created At:</td>
                                            <td class="py-4"><?php echo $created_at; ?></td>
                                        </tr>
                                        <tr>
                                            <td class="py-4 fw-bold">Status:</td>
                                            <td class="py-4"><?php echo $status; ?></td>
                                        </tr>
                                        <!-- Prescription details -->
                                        <tr>
                                            <td class="py-4 fw-bold">Prescription:</td>
                                            <td class="py-4"><?php echo $prescriptionDetails; ?></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <?php if ($prescriptionDetails === "No prescription available.") : ?>
                                <!-- If no prescription exists, show "Add Prescription" button -->
                                <a class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#prescriptionModal" href="#">Add Prescription</a>
                            <?php else : ?>
                                <!-- If prescription exists, show "Edit Prescription" button -->
                                <a class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#prescriptionModal" href="#">Edit Prescription</a>
                            <?php endif; ?>
                            <a class="btn btn-outline-secondary" href="#">Add Medicines</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid py-0">
    <div class="modal fade" id="prescriptionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">
                        <?php echo ($prescriptionDetails === "No prescription available.") ? "Add Prescription" : "Edit Prescription"; ?>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="../queries.php" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="appointment_id" value="<?php echo $appointment_id ?>">
                        <div class="form-group">
                            <label for="prescriptionDetails">Prescription Details: </label>
                            <textarea class="form-control" id="prescriptionDetails" name="prescriptionDetails" rows="4">
                                     <?php echo ($prescriptionDetails === "No prescription available.") ? "" : trim($prescriptionDetails); ?>
                            </textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" name="save" class="btn btn-outline-secondary">
                            <?php echo ($prescriptionDetails === "No prescription available.") ? "Save" : "Update"; ?>
                        </button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Add this script at the end of your HTML file -->
<script>
    $(document).ready(function () {
        // Add an event listener for the modal's show.bs.modal event
        $('#prescriptionModal').on('show.bs.modal', function (event) {
            // Trim the value of the textarea when the modal is about to be shown
            var prescriptionDetailsValue = $('#prescriptionDetails').val();
            $('#prescriptionDetails').val(prescriptionDetailsValue.trim());
        });
    });
</script>


<script src="./doctor.js"></script>
<?php
require_once("../components/footer.php");
?>