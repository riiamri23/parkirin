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
              <h1>Edit Member</h1>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="<?php echo base_url('member') ?>">List Member</a></li>
                <li class="breadcrumb-item active">Edit Member</li>
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
              <div class="col-md-12">
                <!-- general form elements -->
                <div class="card card-default">
                  <div class="card-header">
                    <h3 class="card-title">Kode Member</h3>
                  </div>
                  <!-- /.card-header -->
                  <!-- form start -->
                  <form action="<?php echo base_url('member/editmember') ?>" method="post">
                    <div class="card-body">
                        <div class="row">
                        <div class="col-8">
                          <div class="form-group">
                            <label for="nim">Username / nim</label>
                            <input type="text" class="form-control" id="" placeholder="NIM Member" required="" name="nim" value="<?=$member['kd_member']?>">
                          </div>
                          <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="" placeholder="Password Member" name="password" >
                          </div>
                          <div class="form-group">
                            <label for="nama">Nama Member</label>
                            <input type="text" class="form-control" id="" placeholder="Nama Member" required="" name="nama" value="<?=$member['nama_member']?>">
                          </div>
                          <div class="form-group">
                            <label for="jenis_kendaraan">Jenis Kendaraan</label>
                            <select class="form-control" name="jenis_kendaraan" required="" id="jenis_kendaraan">
                                <option value="" disabled>Pilih Jenis Kendaraan</option>
                            <?php foreach ($jenis as $row) { ?>
                            <option value="<?php echo $row['kd_kendaraan'] ?>" <?=$member['kd_kendaraan'] == $row['kd_kendaraan'] ? 'selected': ''?>><?php echo $row['nama_kendaraan'] ?></option>
                            <?php } ?>
                            </select>
                          </div>
                          <div class="form-group">
                            <label for="fakultas">Fakultas</label>
                              <select class="form-control" name="fakultas" required="" id="fakultas">
                                <option value="" disabled="">Pilih Fakultas</option>
                                <option value="Fakultas Teknik" <?=$member['jurusan'] == 'Fakultas Teknik' ? 'selected' : ''?>>Fakultas Teknik</option>
                                <option value="Fakultas Pendidikan" <?=$member['jurusan'] == 'Fakultas Pendidikan' ? 'selected' : ''?>>Fakultas Pendidikan</option>
                                <option value="Fakultas Psikologi" <?=$member['jurusan'] == 'Fakultas Psikologi' ? 'selected' : ''?>>Fakultas Psikologi</option>
                                <option value="Fakultas Ilmu Bahasa" <?=$member['jurusan'] == 'Fakultas Ilmu Bahasa' ? 'selected' : ''?>>Fakultas Ilmu Bahasa</option>
                              </select>
                          </div>
                          <div class="form-group">
                            <label for="nama">Plat Member</label>
                            <input type="text" class="form-control" id="" placeholder="Plat Kendaraan" required="" name="plat" value="<?=$member['plat_member']?>">
                          </div>
                          </div>
                        </div>
                    </div>
                    <!-- /.card-body -->
                    <div class="card-footer">
                      <a href="<?php echo base_url('member') ?>" class="btn btn-default">Kembali</a>
                      <input type="submit" class="btn btn-primary pull-right" value="Edit Member">
                    </div>
                  </form>
                </div>
                <!-- /.card -->
              </div>
            </div>
          </section>
          <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <!-- footer -->
        <?php $this->load->view('include/base_footer'); ?>
      </div>
      <!-- ./wrapper -->
      <!-- script -->
      <?php $this->load->view('include/base_js'); ?>
      <!-- InputMask -->
      <script src="<?php echo base_url('assets') ?>/plugins/input-mask/jquery.inputmask.js"></script>
      <script src="<?php echo base_url('assets') ?>/plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
      <script src="<?php echo base_url('assets') ?>/plugins/input-mask/jquery.inputmask.extensions.js"></script>
      <script src="<?php echo base_url('assets/dist/') ?>jquery.mask.min.js"></script>
    </body>
  </html>