<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Cửa Hàng Thời Trang</title>


<!-- Thêm tệp CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">

<!-- Thêm tệp JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<%-- <link rel="stylesheet"
	href='<c:url value="/templates/admin/css/nhapHang.css"/>'> --%>

</head>

<body>
	<div class="container">
		<h1 style="text-align: center;">Phiếu Nhập Hàng</h1>
		<div style="font-size: 30px;">
			<label for="supplier">Nhà Cung Cấp: </label> <select
				class="form-select" id="supplier" name="supplier">
				<c:forEach var="ncc" items="${dsNCC}">
					<option value="${ncc.getMancc()}">${ncc.getTenncc()}</option>
				</c:forEach>
			</select>
		</div>
		<section class="card">
			<table id="invoiceTable"
				class="table table-striped table-bordered table-hover">
				<thead style="background-color: lightgray;">
					<tr>
						<th>Số Thứ Tự</th>
						<th>Tên Sản Phẩm</th>
						<th>Size</th>
						<th>Số Lượng</th>
						<th>Giá Nhập</th>
						<th>Xóa</th>
					</tr>
				</thead>
				<tbody>
					<!-- Dữ liệu sẽ được thêm vào đây sau khi tạo phiếu -->
				</tbody>
			</table>
		</section>
		<div class="fixed-buttons">
			<!-- Nút để mở dialog -->
			<button type="button" id="openModalBtn" class="btn btn-primary">
				Thêm Sản Phẩm</button>

			<!-- Nút để mở dialog -->
			<button type="button" id="btnThemPN" class="btn btn-success">
				Thêm phiếu nhập</button>
		</div>



		<!-- Modal thêm chi tiết sản phẩm vào phiếu nhập -->
		<div class="modal fade" id="productModal" tabindex="-1" role="dialog"
			aria-labelledby="productDialogLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header bg-success text-white">
						<h5 class="modal-title" id="productDialogLabel">Thêm Sản Phẩm</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="productName">Tên Sản Phẩm:</label>
							<div class="d-flex">
								<select id="productName" name="productName"
									class="form-control selectpicker" data-live-search="true"
									required>
									<c:forEach var="sp" items="${dsMatHang}">
										<option value="${sp.getMamh()}">Mã SP:
											${sp.getMamh()} _ ${sp.getTenmh()}</option>
									</c:forEach>
								</select> <span class="ml-2">
									<button type="button" class="btn btn-primary"
										id="openAddProductModal">
										<i class="fa fa-plus-square"></i>
									</button>
								</span>
							</div>
						</div>

						<div class="form-group">
							<label for="productSize">Size:</label>
							<div class="d-flex">
								<select id="productSize" name="productSize" class="form-control"
									required>
									<c:forEach var="size" items="${dsSize}">
										<option value="${size.getMasize()}">${size.getTensize()}</option>
									</c:forEach>
								</select> <span class="ml-2">
									<button type="button" class="btn btn-primary"
										id="openAddSizeModal">
										<i class="fa fa-plus-square"></i>
									</button>
								</span>
							</div>
						</div>
						<div class="form-group">
							<label for="productGiaNhap">Giá Nhập:</label> <input
								type="number" class="form-control" id="productGiaNhap"
								name="productGiaNhap" required min="1" value="" />

							<div id="giaNhapError" class="text-danger"></div>
						</div>
						<div class="form-group">
							<label for="productQuantity">Số Lượng:</label> <input
								type="number" class="form-control" id="productQuantity"
								name="productQuantity" required min="1" />
							<div id="quantityError" class="text-danger"></div>
						</div>

					</div>
					<div class="modal-footer">

						<button type="button" class="btn btn-success" id="addProductBtn">
							Thêm Vào Phiếu</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Đóng</button>
					</div>
				</div>
			</div>
		</div>


		<!-- Modal thêm sp mới  -->
		<div class="modal fade" id="addProductModal" tabindex="-1"
			role="dialog" aria-labelledby="addProductModalLabel"
			aria-hidden="true">
			<div class="modal-dialog" role="dialog">
				<div class="modal-content">
					<div class="modal-header bg-success text-white">
						<h5 class="modal-title" id="addProductModalLabel">Thêm Sản
							Phẩm Mới</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="/admin/them-sp-moi" method="post" id="formThemSPMoi">
						<div class="modal-body">
							<!-- Nội dung modal nhập sản phẩm mới -->
							<div class="form-group">
								<label for="tenSPMoi">Tên Sản phẩm mới: </label> <input
									type="text" class="form-control" id="tenSPMoi" name="tenSPMoi"
									required />
							</div>
							<div class="form-group">
								<label for="loaiSP">Loại Sản phẩm:</label> <select id="loaiSP"
									name="loaiSP" class="form-control" required>
									<c:forEach var="lsp" items="${dsLoaiSP}">
										<option value="${lsp.getMaloaimh()}">${lsp.getTenloaimh()}</option>
									</c:forEach>
								</select>
							</div>

							<div class="form-group">
								<label for="nhanHieu">Nhãn hiệu: </label> <select id="nhanHieu"
									name="nhanHieu" class="form-control" required>
									<c:forEach var="nh" items="${dsNhanHieu}">
										<option value="${nh.getManh()}">${nh.getTennh()}</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label for="chatLieu">Chất liệu:</label> <select id="chatLieu"
									name="chatLieu" class="form-control" required>
									<c:forEach var="cl" items="${dsChatLieu}">
										<option value="${cl.getMacl()}">${cl.getTenvai()}</option>
									</c:forEach>
								</select>
							</div>
							
							<div class="form-group">
								<label for="cachLam">Cách làm: </label> <select id="cachLam"
									name="cachLam" class="form-control" required>					
										<option value="Machine Made">Machine Made</option>
										<option value="Handmade">Handmade</option> 
								</select>

							</div>
							
							<div class="form-group">
								<label for="moTa">Mô tả: </label> <input type="text"
									class="form-control" id="moTa" name="moTa" required />
							</div>
							<div class="form-group">
								<label for="themAnh">Hình ảnh: </label> <input type="file"
									class="form-control" id="themAnh" name="themAnh" required
									multiple accept=".jpg, .png" />
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success" id="saveProductBtn">Lưu</button>
							<button class="btn btn-secondary" data-dismiss="modal">Đóng</button>
						</div>
					</form>
				</div>
			</div>
		</div>


		<!-- Modal thêm size mới  -->
		<div class="modal fade" id="addSizeModal" tabindex="-1" role="dialog"
			aria-labelledby="addSizeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header bg-success text-white">
						<h5 class="modal-title" id="addSizeModalLabel">Thêm Size Mới</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<form action="" id="formThemSizeMoi">
						<div class="modal-body">
							<!-- Nội dung modal nhập size mới -->
							<div class="form-group">
								<label for="sizeMoi">Tên size mới: </label> <input type="text"
									class="form-control" id="sizeMoi" name="sizeMoi" required />
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-success" id="saveSizeBtn">Lưu</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Đóng</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"
		type="text/javascript"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
		type="text/javascript"></script>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<script src="<c:url value='/templates/admin/js/nhapHang.js'/>"
		type="text/javascript"></script>


</body>
</html>
