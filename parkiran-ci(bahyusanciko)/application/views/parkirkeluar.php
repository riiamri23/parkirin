<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title ?></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- css -->
    <?php $this->load->view('include/base_css'); ?>
    <link rel="stylesheet" href="<?php echo base_url('assets') ?>/plugins/datatables/dataTables.bootstrap4.min.css">
  </head>
  <body class="hold-transition sidebar-mini">
    <!-- navbar -->
    <?php $this->load->view('include/base_nav'); ?>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1>Parkir Keluar</h1>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="<?php echo base_url('Keluar') ?>">Parkir Keluar</a></li>
              </ol>
            </div>
          </div>
          </div><!-- /.container-fluid -->
        </section>
        <!-- Main content -->
        <section class="content">
          <div class="container-fluid">
            <div class="row">
              <!-- left column -->
              <div class="col-md-3">
                <!-- general form elements -->
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Input Kendaraan Keluar</h3>
                  </div>
                  <!-- /.card-header -->
                  <!-- form start -->
                  <form action="<?php echo base_url('keluar/kendaraankeluar') ?>" method="post">
                    <div class="card-body">
                      <div class="form-group hidden">
                        <label for="">Kode Karcis</label>
                        <div class="input-group">
                          <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-barcode"></i></span>
                            <input type="text" class="form-control" id="" placeholder="Kode Karcis" name="karcis">
                          </div>
                        </div>
                        <?php echo $this->session->flashdata('pesan') ?>
                      </div>
                     <!-- <div class="form-group">-->
                     <!--   <label for="exampleInputEmail1">Member Keluar ? </label>-->
                     <!--   <div class="row">-->
                     <!--     <div class="col">-->
                     <!--     <input type="radio" class="tampil" name="yes"> Yes-->
                     <!--   </div>-->
                     <!--   <div class="col">-->
                     <!--     <input type="radio" class="sembunyi" name="yes">No-->
                     <!--   </div>-->
                     <!-- </div>-->
                     <!--</div>-->
                     <div class="form-group member">
                        <label for="">Kode Member</label>
                        <div class="input-group">
                          <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fa fa-barcode"></i></span>
                            <input type="text" class="form-control autocomplete" placeholder="Kode Member" name="member">
                          </div>
                        </div>
                    </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                      <button type="submit" class="btn btn-primary pull-right">Cek Karcis</button>
                    </div>
                  </form>
                </div>
                <!-- /.card -->
              </div>
              <div class="col-md-9">
                <!-- general form elements -->
                <div class="card card-default">
                  <div class="card-header">
                    <h3 class="card-title">Data Kendaraan Keluar Hari <?php echo hari_indo(date('N',strtotime(date('Y-m-d')))).', '.tanggal_indo(date('Y-m-d',strtotime(''.date('Y-m-d').''))) ?></h3>
                  </div>
                  <!-- /.card-header -->
                  <table id="example1" class="table table-bordered table-striped">
                    <thead>
                      <tr>
                        <th>Kode Karcis</th>
                        <th>Plat Nomor</th>
                        <th>Jam Masuk</th>
                        <th>Jam Keluar</th>
                        <th>Lama Parkir</th>
                        <!--<th>Total Bayar</th>-->
                        <th>Penjaga</th>
                        <th>Aksi</th>
                      </tr>
                    </thead>
                    <tbody> 
                    <?php foreach ($keluar as $row) { ?>
                      <tr>
                        <td><?php echo $row['kd_masuk'] ?></td>
                        <td><?php echo $row['plat_masuk'] ?></td>
                        <td><?php echo date('H:i:s',strtotime($row['tgl_jam_masuk'])) ?></td>
                        <td><?php echo date('H:i:s',strtotime($row['tgl_jam_keluar'])) ?></td>
                        <td><?php echo $row['lama_parkir_keluar']; ?></td>
                        <!--<td>Rp <?php echo $row['total_keluar'] ?></td>-->
                        <td><?php echo $row['create_keluar'] ?></td>
                        <td><a href="<?php echo base_url('keluar/cetakstruk/'.$row['kd_keluar']) ?>"><i class="fa fa-barcode"></i></a></td>
                      </tr>
                    <?php } ?>
                    </tfoot>
                    </table>
                  </div>
                  <!-- /.card -->
                </div>
              </div>
            </div>
          </section>
          <!-- /.content -->
        </div>
                      </div>
        <!-- /.content-wrapper -->
        <!-- footer -->
        <?php $this->load->view('include/base_footer'); ?>
      </div>
      <!-- ./wrapper -->
      <!-- script -->
      <?php $this->load->view('include/base_js'); ?>
      <script src="<?php echo base_url('assets') ?>/plugins/datatables/jquery.dataTables.min.js"></script>
      <script src="<?php echo base_url('assets') ?>/plugins/datatables/dataTables.bootstrap4.min.js"></script>
      <!-- page script -->
      <script>
        $(function () {
          $("#example1").DataTable();
          $('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false
          });
        });
      </script>
      <script type="text/javascript">
        //Pertama sembunyikan elemen class gambar
        $('.member').hide();        
        //Ketika elemen class tampil di klik maka elemen class gambar tampil
        $('.tampil').click(function(){
            $('.member').show();
            $('.hidden').hide()
        });
        //Ketika elemen class sembunyi di klik maka elemen class gambar sembunyi
        $('.sembunyi').click(function(){
        //Sembunyikan elemen class gambar
        $('.member').hide();
        $('.hidden').show()        
        });
      </script>
    </body>
  </html>