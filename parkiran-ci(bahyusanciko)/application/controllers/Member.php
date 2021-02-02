<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Member extends CI_Controller {
	function __construct(){
	parent::__construct();
		$this->load->helper('tglindo_helper');
		$this->getsecurity();
		date_default_timezone_set("Asia/Jakarta");
	}
	public function index(){
		$data['title'] = 'List Member';
		$data['member'] = $this->db->query("SELECT * FROM tbl_member,tbl_kendaraan WHERE tbl_kendaraan.kd_kendaraan = tbl_member.kd_kendaraan")->result_array();
		// die(print_r($data));
		$this->load->view('member', $data, FALSE);
	}
	function getsecurity($value=''){
		$username = $this->session->userdata('username_admin');
		if (empty($username)) {
			$this->session->sess_destroy();
			redirect('login');
		}
	}
	function get_kod(){
            $q = $this->db->query("SELECT MAX(RIGHT(kd_member,3)) AS kd_max FROM tbl_member");
            $kd = "";
            if($q->num_rows()>0){
                foreach($q->result() as $k){
                    $tmp = ((int)$k->kd_max)+1;
                    $kd = sprintf("%08s", $tmp);
                }
            }else{
                $kd = "001";
            }
            return "MBR".$kd;
        }
	public function tambahmember(){
		$this->load->library('form_validation');
		$this->form_validation->set_rules('nama','Nama', 'required');
		$this->form_validation->set_rules('plat','Plat', 'required|is_unique[tbl_member.plat_member]');
		if ($this->form_validation->run() == false) {
			// print_r($_POST);
			$data['title'] ='Tambah Member';
			$data['jenis'] = $this->db->query("SELECT * FROM tbl_kendaraan WHERE jenis_kendaraan = '2'")->result_array();
			$this->load->view('tambahmember', $data);
		}else{
						// print_r($_POST);
// 			$data = array(
// 				'kd_member' => $this->get_kod(),
// 				'kd_kendaraan' => $this->input->post('tipe'),
// 				'nama_member' => $this->input->post('nama'),
// 				'plat_member' => strtoupper($this->input->post('plat')),
// 				'no_rangka_member' => $this->input->post('no_rak'),
// 				'no_mesin_member' => $this->input->post('no_mes'),
// 				'create_member' => $this->session->userdata('nama_admin')
// 			);
            $cekMember = $this->db->query("SELECT * FROM tbl_member WHERE kd_member = '" . $this->input->post('nim') ."'")->result_array();
            if(empty($cekMember)){
                if(!empty($this->input->post('password'))){
                    
                    $data = array(
                        'kd_member'=> $this->input->post('nim'),
                        'password'=> $this->input->post('password'),
                        'nama_member'=> $this->input->post('nama'),
                        'kd_kendaraan'=>$this->input->post('jenis_kendaraan'),
                        'jurusan'=>$this->input->post('fakultas'),
                        'plat_member'=>$this->input->post('plat'),
                    );
                }else{
                    
                    $data = array(
                        'kd_member'=> $this->input->post('nim'),
                        'nama_member'=> $this->input->post('nama'),
                        'kd_kendaraan'=>$this->input->post('jenis_kendaraan'),
                        'jurusan'=>$this->input->post('fakultas'),
                        'plat_member'=>$this->input->post('plat'),
                    );
                }
    // 			print_r($data);
    			// die();
    			$this->db->insert('tbl_member', $data);
    			$this->session->set_flashdata('message', 'swal("Berhasil", "Berhasil Tambah Member", "success");');
        		redirect('member');
                
            }else{
    			$this->session->set_flashdata('message', 'swal("Gagal", "Member sudah ada", "gagal");');
        		redirect('member');
            }
                
		}
	}
	public function view($id=''){
		$sqlcek = $this->db->query("SELECT * FROM tbl_member,tbl_kendaraan WHERE kd_member = '".$id."' AND tbl_kendaraan.kd_kendaraan = tbl_member.kd_kendaraan ")->row_array();
		$data['jenis'] = $this->db->query("SELECT * FROM tbl_kendaraan WHERE jenis_kendaraan = '2'")->result_array();
		if ($sqlcek) {
			$data['title'] = 'View Member';
			$data['member'] = $sqlcek;
// 			die(print_r($data));
			$this->load->view('viewmember', $data, FALSE);
		}else{
			$this->session->set_flashdata('message', 'swal("Gagal", "Member Tidak Ada", "error");');
    		redirect('member');
		}
	}

	public function editmember(){
		// print_r($_POST);
// 		$data = array(
// 			'kd_member' => $this->input->post('kode'),
// 			'kd_kendaraan' => $this->input->post('jenis'),
// 			'nama_member' => $this->input->post('nama'),
// 			'plat_member' => strtoupper($this->input->post('plat')),
// 			'no_rangka_member' => $this->input->post('no_rak'),
// 			'no_mesin_member' => $this->input->post('no_mes'),
// 			'create_member' => $this->session->userdata('nama_admin')
// 		);

        $data = array(
            'kd_member'=> $this->input->post('nim'),
            'password'=> $this->input->post('password'),
            'nama_member'=> $this->input->post('nama'),
            'kd_kendaraan'=>$this->input->post('jenis_kendaraan'),
            'jurusan'=>$this->input->post('fakultas'),
            'plat_member'=>$this->input->post('plat'),
        );
		// print_r($data);
		// die();
		$this->db->where('kd_member', $this->input->post('nim'));
		$this->db->update('tbl_member', $data);
		// $this->db->insert('tbl_member', $data);
		$this->session->set_flashdata('message', 'swal("Berhasil", "Berhasil Edit Member", "success");');
		redirect('member');


	}
	public function getjenis($params){
		// $params = $_GET['address_mac'];
      $itemArray = array();
      $resultSN = $this->db->query("SELECT * FROM  tbl_kendaraan WHERE kd_kendaraan = '".$params."' ");
      $rrSn = $resultSN->row_array();
      if ($resultSN->num_rows() > 0) {
        $itemArray['kd_kendaraan'] = $rrSn['harga_kendaraan'];
      } else {
        $this->session->set_flashdata('message', 'swal("Ngapa YA", "Ngapain LUH", "error");');
    	redirect('member');
      }
      // die(print_r($itemArray));
      $this->output
        ->set_status_header(200)
        ->set_content_type('application/javascript')
        ->set_output(json_encode($itemArray))
        ->_display();
      exit;
	}

	public function delete($kodemember){
		// print_r($kodemember);
		$this->db->query("DELETE FROM tbl_member WHERE kd_member = '" . $kodemember . "'");

		
		// $this->load->view('member', $data, FALSE);
		redirect('member');
	}
}

/* End of file Member.php */
/* Location: ./application/controllers/Member.php */