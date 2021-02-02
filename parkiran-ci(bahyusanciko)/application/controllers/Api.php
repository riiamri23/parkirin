<?php
defined('BASEPATH') OR exit('No direct script access allowed');

use chriskacerguis\RestServer\RestController;

require APPPATH . 'libraries/RestController.php';

class Api extends RestController {

    public function __construct()
    {
            date_default_timezone_set('Asia/Jakarta');
            parent::__construct();
            $this->load->helper(array('form', 'url'));
    }


    public function index_get(){
        // testing response
    }

    public function login_post(){
		// die(print_r($_POST['kd_member']));
        //validation login
        $result = $this->db->query("SELECT a.*, b.tgl_masuk, b.status_masuk FROM tbl_member a LEFT JOIN tbl_masuk b ON a.kd_member = b.kd_member WHERE a.kd_member = '". $this->input->post('kd_member') ."' AND a.password = MD5('".$this->input->post('password')."') ORDER BY tgl_masuk DESC LIMIT 1")->result_array();
        if(!empty($result)){
            // $result['status_parkir'] = $result['status_masuk'] == 1 ? '' : '';
                
            $response['status']=200;
            $response['error']=false;
            $response['data']= $result;
        }else{
            $response['status']=401;
            $response['error']=true;
            $response['data']= 'kode member/password salah';
        }

        // testing response

        // tampilkan response12345
        $this->response($response);
    }

    public function registrasi_post(){
        $result = $this->db->query("SELECT * FROM tbl_member WHERE tbl_member.kd_member = '" . $this->input->post('kd_member') ."'")->result_array();

        if(empty($result)){
            if(!empty($this->input->post('kd_member'))){
                
                $config['upload_path']          = './assets/foto/';
                $config['allowed_types']        = 'gif|jpg|png';
                $config['max_size']             = 1000;
                $config['file_name']            = $this->input->post('kd_member') .'.jpg';
                // $config['max_width']            = 1024;
                // $config['max_height']           = 768;
                
                $this->load->library('upload', $config);

                if($this->upload->do_upload('fotoprofil')){

                    $result2 = $this->db->query("INSERT INTO tbl_member(kd_member, password, kd_kendaraan, nama_member, jurusan, plat_member, create_member) VALUES('{$this->input->post('kd_member')}', MD5('{$this->input->post('password')}'), '{$this->input->post('kd_kendaraan')}', '{$this->input->post('nama_member')}', '{$this->input->post('jurusan')}', '{$this->input->post('plat_member')}', '{$this->input->post('create_member')}');");
    
                    
                    $result3 = $this->db->query("SELECT * FROM tbl_member WHERE tbl_member.kd_member = '". $this->input->post('kd_member') ."' AND tbl_member.password = MD5('".$this->input->post('password')."')")->result_array();
    
                    $response['status'] = 200;
                    $response['error']=false;
                    $response['data']= $result3;
                }else{
                    $error = array('error' => $this->upload->display_errors());
                    $response['status'] = 401;
                    $response['error']=true;
                    $response['data']= $error;

                }
            }else{
                $response['status'] = 401;
                $response['error']=true;
                $response['data']= 'User tidak terisi dengan baik';
            }
        }else{
            $response['status'] = 401;
            $response['error']=true;
            $response['data']= 'User sudah terdaftar';
        }

        
        $this->response($response);
    }

    public function getuser_post(){
        $kd_member = $this->input->post('kd_member');
        // $memberCek = $this->db->query("SELECT a.*, b.kode, b.tanggal FROM `tbl_member` a 
        // LEFT JOIN (select 'Kendaraan masuk' as kode, a.tgl_masuk as tanggal, a.kd_member as kd_member, b.nama_member from tbl_masuk a left join tbl_member b on a.kd_member = b.kd_member
        //         UNION
        //         SELECT 'Kendaraan keluar' as kode, a.tgl_jam_keluar as tanggal, a.kd_member as kd_member, b.nama_member FROM tbl_keluar a left join tbl_member b on a.kd_member = b.kd_member order by tanggal desc) as b ON a.kd_member = b.kd_member 
        // WHERE a.kd_member = '".$kd_member."' ORDER BY tanggal DESC LIMIT 1")->result_array();
        $memberCek = $this->db->query("SELECT a.*, b.tgl_masuk, b.status_masuk FROM tbl_member a LEFT JOIN tbl_masuk b ON a.kd_member = b.kd_member WHERE a.kd_member = '". $kd_member ."' ORDER BY tgl_masuk DESC LIMIT 1")->result_array();

        if(!empty($memberCek)){
            $response['status'] = 200;
            $response['error'] = false;
            $response['data'] = $memberCek;
        }else{
            $response['status'] = 401;
            $response['error'] = true;
            $response['data'] = 'tidak ada member';
        }
        $this->response($response);
    }

    public function parkirmasuk_post(){
        $member = $this->input->post('member');

        $memberCek = $this->db->query("SELECT * FROM `tbl_member` where kd_member = '".$member."'")->result_array();

        if(!empty($memberCek)){
            $memberMasuk = $this->db->query("INSERT INTO tbl_masuk(kd_masuk, kd_member, kd_kendaraan, plat_masuk, tgl_masuk, status_masuk, create_masuk) VALUES('".$this->get_kodMasuk()."', '".$member."', '".$memberCek[0]['kd_kendaraan']."', '".$memberCek[0]['plat_member']."', '". date("Y-m-d H:i:s") ."', 1, 'admin');");

            $response['status'] = 200;
            $response['error']=false;
            $response['data']= $memberCek;

        }else{
            $response['status'] = 401;
            $response['error']=true;
            $response['data']= 'Tidak Terdaftar Dalam Member';

        }

        $this->response($response);
    }

    public function parkirkeluar_post(){
        $member = $this->input->post('member');
        // $kd_masuk = $this->input->post('kd_masuk');

        $memberCek = $this->db->query("SELECT * FROM `tbl_member` where kd_member = '".$member."'")->result_array();

        if(!empty($memberCek)){
            $masukCek = $this->db->query("SELECT *, CONCAT(TIMESTAMPDIFF(hour, tgl_masuk, '".date("Y-m-d H:i:s")."'), ' jam ', TIMESTAMPDIFF(minute, tgl_masuk, '".date("Y-m-d H:i:s")."'),' menit') as lama_parkir FROM `tbl_masuk` ORDER BY kd_masuk DESC LIMIT 1")->result_array();

            if(!empty($masukCek)){
                if($masukCek[0]['status_masuk'] == '1'){
                    $where = array('kd_masuk' => $masukCek[0]['kd_masuk']);
                    $update = array('status_masuk' => 2 );
                    $this->db->update('tbl_masuk', $update, $where);

                    $memberKeluar = $this->db->query("INSERT INTO `tbl_keluar`(`kd_keluar`, `kd_masuk`, `kd_member`, `tgl_jam_masuk`, `tgl_jam_keluar`, `lama_parkir_keluar`, `tarif_keluar`, `total_keluar`, `status_keluar`, `create_keluar`) VALUES ('".$this->get_kodKeluar()."', '".$masukCek[0]['kd_masuk']."', '".$member."', '".$masukCek[0]['tgl_masuk']."', '".date("Y-m-d H:i:s")."', '".$masukCek[0]['lama_parkir']."', 0, 0, 1, 'admin')");

                    $response['status'] = 200;
                    $response['error']=false;
                    $response['data']= $memberCek;
                }else{
                    $response['status'] = 401;
                    $response['error'] = true;
                    $response['data'] = 'Kendaraan belum memasuki parkiran';

                }
            }else{
                $response['status'] = 401;
                $response['error'] = true;
                $response['data'] = 'Tidak terdaftar member';
            }

        }else{
            $response['status'] = 401;
            $response['error']=true;
            $response['data']= 'Tidak Terdaftar Dalam Member';

        }
        $this->response($response);

    }

    public function parkiranlist_get(){
        $data = $this->db->query("SELECT * FROM tbl_masuk RIGHT JOIN tbl_kendaraan ON tbl_masuk.kd_kendaraan = tbl_kendaraan.kd_kendaraan WHERE status_masuk = '1'")->result_array();

        if($data){

            $response['status'] = 200;
            $response['error']=false;
            $response['data']= $data;
    
        }else{
            $response['status'] = 401;
            $response['error']=false;
            $response['data']= 'tidak ada data yang bisa didapatkan';

        }
        $this->response($response);

    }

    public function historyparkir_get(){
        $data = $this->db->query("select * from (select 'Kendaraan masuk' as kode, a.tgl_masuk as tanggal, a.kd_member as kd_member, b.nama_member from tbl_masuk a left join tbl_member b on a.kd_member = b.kd_member
        UNION
        SELECT 'Kendaraan keluar' as kode, a.tgl_jam_keluar as tanggal, a.kd_member as kd_member, b.nama_member FROM tbl_keluar a left join tbl_member b on a.kd_member = b.kd_member) as history
        order by tanggal desc")->result_array();

        if($data){
            $response['status'] = 200;
            $response['error']= false;
            $response['data']=$data;
        }else{
            $response['status'] = 401;
            $response['error'] = false;
            $response['data'] = 'tidak ada data yang bisa didapatkan';
        }

        $this->response($response);
    }
    
	function get_kodMasuk(){
        $q = $this->db->query("SELECT MAX(RIGHT(kd_masuk,3)) AS kd_max FROM tbl_masuk");
        $kd = "";
        if($q->num_rows()>0){
            foreach($q->result() as $k){
                $tmp = ((int)$k->kd_max)+1;
                $kd = sprintf("%08s", $tmp);
            }
        }else{
            $kd = "001";
        }
        return "M".$kd;
    }
	function get_kodKeluar(){
        $q = $this->db->query("SELECT MAX(RIGHT(kd_keluar,3)) AS kd_max FROM tbl_keluar");
        $kd = "";
        if($q->num_rows()>0){
            foreach($q->result() as $k){
                $tmp = ((int)$k->kd_max)+1;
                $kd = sprintf("%08s", $tmp);
            }
        }else{
            $kd = "001";
        }
        return "K".$kd;
    }
}