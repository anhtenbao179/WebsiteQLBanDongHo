CREATE DATABASE WebsiteQLBanDongHo
go
USE WebsiteQLBanDongHo
go

--- Tạo bảng loại sản phẩm
CREATE TABLE LOAISANPHAM
(
	MALOAISP CHAR(7) NOT NULL PRIMARY KEY,
	TENLOAISP NVARCHAR(50),
)

--- Tạo bảng thương hiệu
CREATE TABLE THUONGHIEU
(
	MATH INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	TENTH NVARCHAR(50),
	HINHTH VARCHAR(50)
)

--- Tạo bảng sản phẩm
CREATE TABLE SANPHAM
(
	MASP INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	TENSP NVARCHAR(50),
	HINHLON VARCHAR(50),
	HINHNHO VARCHAR(50),
	MOTA NTEXT,
	MATH INT,
	DANHGIA NTEXT,
	SOLUONG INT,
	MALOAISP CHAR(7),
	DONGIA FLOAT
)

--- Bảng màu sắc
CREATE TABLE MAUSAC
(
	MAMAU CHAR(7) NOT NULL PRIMARY KEY,
	TENMAU NVARCHAR(30)
)

--- Bảng kích cỡ
CREATE TABLE SIZE
(
	MASIZE CHAR(7) NOT NULL PRIMARY KEY,
	TENSIZE NVARCHAR(30)
)

--- Bảng chi tiết sản phẩm
CREATE TABLE CHITIETSANPHAM
(
	MASP INT NOT NULL,
	MALOAISP CHAR(7) NOT NULL,
	MAMAU CHAR(7) NOT NULL,
	MASIZE CHAR(7) NOT NULL,
	SOLUONG INT,
	PRIMARY KEY(MASP, MALOAISP, MAMAU, MASIZE)
)

--- Tạo bảng loại tài khoản
CREATE TABLE LOAITK
(
	MALOAITK CHAR(7) NOT NULL PRIMARY KEY,
	TENLOAITK NVARCHAR(20)
)

--- Tạo bảng tài khoản
CREATE TABLE TAIKHOAN
(
	MATK INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	TENDN VARCHAR(20),
	MATKHAU VARCHAR(32),
	NGAYDANGKY DATETIME,
	TRANGTHAI BIT,
	MALOAITK CHAR(7)
)

--- Tạo bảng khách hàng
CREATE TABLE KHACHHANG
(
	MAKH INT NOT NULL PRIMARY KEY IDENTITY(1, 1),
	MATK INT,
	TENKH NVARCHAR(50),
	EMAIL VARCHAR(50),
	SDT VARCHAR(12),
	GIOITINH NVARCHAR(3),
	DIACHI NTEXT,
)

--- Tạo bảng đơn đặt hàng
CREATE TABLE DONHANG
(
	MADH INT NOT NULL PRIMARY KEY,
	MAKH INT,
	TRANGTHAI NVARCHAR(20),
	DIACHIGIAO NTEXT,
	SDT VARCHAR(12),
	NGAYDAT DATETIME,
	NGAYGIAO DATETIME,
	MOTA NTEXT,
	TONGTIEN FLOAT
)

--- Tạo bảng chi tiết đơn đặt hàng
CREATE TABLE CHITIETDONHANG
(
	MADH INT NOT NULL,
	MASP INT NOT NULL,
	SOLUONG INT,
	PRIMARY KEY(MADH, MASP)
)

--- Tạo bảng khuyến mãi
CREATE TABLE KHUYENMAI
(
	MAKM CHAR(7) NOT NULL PRIMARY KEY,
	TENKM NVARCHAR(50),
	NGAYBD DATETIME,
	NGAYKT DATETIME
)

---Tạo bảng chi tiết khuyến mãi
CREATE TABLE CHITIETKM
(
	MAKM CHAR(7) NOT NULL,
	MASP INT NOT NULL,
	PHANTRAMKM INT,
	PRIMARY KEY(MAKM, MASP)
)

--- Tạo bảng bình luận
CREATE TABLE BINHLUAN
(
	MABL CHAR(7) NOT NULL PRIMARY KEY,
	MATK CHAR(7),
	MASP CHAR(7),
	NOIDUNG NTEXT,
	NGAYBINHLUAN DATETIME
)

--- Tạo bảng đánh giá
CREATE TABLE DANHGIA
(
	MADG CHAR(7) NOT NULL PRIMARY KEY,
	MASP CHAR(7),
	MATK CHAR(7),
	NOIDUNG NTEXT,
	SOSAO VARCHAR(1)
)

--- Tạo khóa ngoại cho bảng  chi tiết sản phẩm
ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_LSP FOREIGN KEY(MALOAISP) REFERENCES LOAISANPHAM(MALOAISP)
ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_MAU FOREIGN KEY(MAMAU) REFERENCES MAUSAC(MAMAU)
ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_SIZE FOREIGN KEY(MASIZE) REFERENCES SIZE(MASIZE)
ALTER TABLE CHITIETSANPHAM ADD CONSTRAINT FK_CTSP_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

--- Tạo khóa ngoại cho bảng sản phẩm
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_TH FOREIGN KEY(MATH) REFERENCES THUONGHIEU(MATH)
ALTER TABLE SANPHAM ADD CONSTRAINT FK_SP_LSP FOREIGN KEY(MALOAISP) REFERENCES LOAISANPHAM(MALOAISP)

--- Tạo khóa ngoại cho bảng đơn hàng
ALTER TABLE DONHANG ADD CONSTRAINT FK_DH_KH FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH)

--- Tạo khóa ngoại cho bảng chi tiết đơn hàng
ALTER TABLE CHITIETDONHANG ADD CONSTRAINT FK_CTDH_DH FOREIGN KEY(MADH) REFERENCES DONHANG(MADH)
ALTER TABLE CHITIETDONHANG ADD CONSTRAINT FK_CTDH_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

--- Tạo khóa ngoại cho bảng chi tiết khuyến mãi
ALTER TABLE CHITIETKM ADD CONSTRAINT FK_CTKM_KM FOREIGN KEY(MAKM) REFERENCES KHUYENMAI(MAKM)
ALTER TABLE CHITIETKM ADD CONSTRAINT FK_CTKM_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

--- Tạo khóa ngoại cho bảng khách hàng
ALTER TABLE KHACHHANG ADD CONSTRAINT FK_KH_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)

--- Tạo khóa ngoại cho bảng tài khoản
ALTER TABLE TAIKHOAN ADD CONSTRAINT FK_TK_LTK FOREIGN KEY(MALOAITK) REFERENCES LOAITK(MALOAITK)

DROP TABLE BINHLUAN
CREATE TABLE BINHLUAN
(
    MABL CHAR(7) NOT NULL PRIMARY KEY,
    MATK INT,
    MASP INT,
    NOIDUNG NTEXT,
    NGAYBINHLUAN DATETIME
)

--- Tạo khóa ngoại cho bảng bình luận
ALTER TABLE BINHLUAN ADD CONSTRAINT FK_BL_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)
ALTER TABLE BINHLUAN ADD CONSTRAINT FK_BL_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)

DROP TABLE DANHGIA
CREATE TABLE DANHGIA
(
    MADG INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    MASP INT,
    MATK INT,
    NOIDUNG NTEXT,
    SOSAO INT
)

--- Tạo khóa ngoại cho bảng đánh giá
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_SP FOREIGN KEY(MASP) REFERENCES SANPHAM(MASP)
ALTER TABLE DANHGIA ADD CONSTRAINT FK_DG_TK FOREIGN KEY(MATK) REFERENCES TAIKHOAN(MATK)

INSERT INTO LOAITK VALUES ('LK00001', N'Admin')
INSERT INTO LOAITK VALUES ('LK00002', N'User')

INSERT INTO TAIKHOAN VALUES ('user', 'd95c2712448b912279457601ae231a42', '2018-05-16 12:54:33.240', 1, 'LK00002')
INSERT INTO TAIKHOAN VALUES ('admin', 'e10adc3949ba59abbe56e057f20f883e', '2018-05-16 12:54:33.240', 1, 'LK00001')

INSERT INTO THUONGHIEU VALUES (N'Tissot', N'TH00001.jpg')
INSERT INTO THUONGHIEU VALUES (N'Frederique Constant', N'TH00002.jpg')
INSERT INTO THUONGHIEU VALUES (N'Calvin Klein', N'TH00003.jpg')

INSERT INTO LOAISANPHAM VALUES ('LP00001', N'Đồng hồ nam')
INSERT INTO LOAISANPHAM VALUES ('LP00002', N'Đồng hồ nữ')

INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T106.417.16.031.00', N'SP00001.jpg', N'SP00001', N'Đồng hồ Tissot T106.417.16.031.00 là mẫu T-Sport V8 Quartz Chronograph (42.5mm) Thụy Sĩ, có vỏ thép không gỉ 316L, sử dụng bộ máy Quartz (Pin) chính xác, trang bị kính Sapphire chống trầy, chức năng bấm giờ thể thao (Chronograph), hiển thị ngày, dây đeo bằng da và có khả năng chống nước 100m.', 1, N'Đây là lựa chọn rất tốt trong phân khúc, được đánh giá cao nhờ chất lượng Thụy Sĩ bền bỉ, độ chính xác của bộ máy Quartz, tính năng Chronograph tiện dụng và đặc biệt là việc trang bị kính Sapphire cao cấp, mang lại vẻ ngoài thể thao, nam tính và giá trị vượt trội so với mức giá.', 3, 'LP00001', 11000000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T085.410.22.013.00', N'SP00002.jpg', N'SP00002', N'Đồng hồ Tissot T085.410.22.013.00 thuộc dòng T-Classic Carson Quartz Thụy Sĩ, có vỏ thép không gỉ 40mm được mạ PVD hai tông màu (Vàng/Bạc), sử dụng bộ máy Quartz chính xác, trang bị kính Sapphire, mặt số trắng với cọc số La Mã và hiển thị ngày, dây đeo kim loại demi và khả năng chống nước 30m.', 1, N'Đây là mẫu Dress Watch (đồng hồ công sở/lịch sự) rất thanh lịch và sang trọng, được đánh giá cao nhờ thiết kế cổ điển vượt thời gian, kích thước 40mm lý tưởng dễ đeo, chất liệu kính Sapphire cao cấp và sự nổi bật từ chi tiết mạ PVD Demi, mặc dù độ chống nước 30m chỉ đủ cho các hoạt động thông thường.', 4, 'LP00001', 11730000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T063.617.36.037.00', N'SP00003.jpg', N'SP00003', N'Đồng hồ Tissot T063.617.36.037.00 thuộc dòng Tradition Chronograph Quartz Thụy Sĩ, có thiết kế cổ điển pha lẫn thể thao với vỏ thép không gỉ 42mm mạ PVD Vàng Hồng sang trọng, mặt số trắng có 3 mặt phụ Chronograph (60s, 30m, 1/10s) và hiển thị ngày, sử dụng kính Sapphire chống trầy và dây da vân cá sấu màu nâu lịch lãm.', 1, N'Mẫu đồng hồ này là sự kết hợp tinh tế giữa phong cách cổ điển (Tradition) và tính năng thể thao (Chronograph), với lớp mạ PVD Vàng Hồng nổi bật và dây da nâu sang trọng. Thiết kế 6 kim cân đối, sử dụng máy Quartz Thụy Sĩ chính xác, và mặt kính Sapphire cao cấp, rất phù hợp cho những quý ông muốn một chiếc đồng hồ đa năng, lịch lãm nhưng vẫn có nét cá tính.', 6, 'LP00001', 14700000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-282AS5B4', N'SP00004.jpg', N'SP00004', N'Đồng hồ Frederique Constant FC-282AS5B4 là mẫu Horological Smartwatch Thụy Sĩ, kết hợp bộ máy Quartz (FC-282) với công nghệ thông minh Motion X. Đồng hồ có vỏ thép 42mm mạ PVD Vàng Hồng (Rose Gold), mặt số trắng/bạc cổ điển có cọc số Index & Ả Rập, trang bị kính Sapphire cong chống trầy và dây da bê (Calfskin) màu nâu, với độ chịu nước 50m (5 ATM).', 2, N'Đây là lựa chọn lý tưởng cho người yêu thích vẻ đẹp cổ điển, sang trọng của Dress Watch Thụy Sĩ nhưng vẫn muốn sở hữu tính năng thông minh một cách kín đáo, không cần màn hình điện tử. Theo dõi sức khỏe: Đếm bước chân, theo dõi giấc ngủ (Sleep Monitoring). Thông báo: Báo thức theo chu kỳ ngủ (Sleep Cycle Alarms), nhắc nhở vận động (Get-Active Alerts). Kết nối: Tự động đồng bộ thời gian (Automatic Time Update), múi giờ thứ hai (GMT), sao lưu dữ liệu đám mây (Cloud Backup). Thiết kế thanh lịch vượt thời gian với lớp mạ Vàng Hồng. Kính Sapphire cong cao cấp. Sự kết hợp độc đáo giữa đồng hồ kim truyền thống và Smartwatch. Pin Quartz tuổi thọ cao (khoảng 48 tháng) thay vì cần sạc hàng ngày.', 2, 'LP00001', 27040000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T006.408.22.037.00', N'SP00005.jpg', N'SP00005', N'Đồng hồ nam, Automatic, Trắng Bạc, Thiết kế truyền thống, máy ETA 2824 Modified, Dây da thanh lịch kết hợp vỏ thép không gỉ mạ PVD vàng hồng.', 1, N'XWatch Luxury là địa chỉ đầu tiên tại Việt Nam thực hiện chiến dịch Tẩy chay Đồng hồ Fake - Bảo vệ lợi ích người tiêu dùng. XWatch Luxury được ủy quyền trực tiếp từ các thương hiệu danh tiếng.', 4, 'LP00001', 36020000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T063.907.36.068.00', N'SP00006.jpg', N'SP00006', N'Đồng hồ nam Tissot Tradition Powermatic 80 Open Heart, Automatic, Vỏ Thép không gỉ mạ PVD vàng hồng, Kính sapphire, Dây da đen, Chống nước 3ATM. Thiết kế lộ máy (Open Heart) tinh tế.', 1, N'Thiết kế classic, cỗ máy Powermatic 80 với khả năng trữ cót 80 giờ ấn tượng. Một lựa chọn hoàn hảo cho người yêu thích đồng hồ cơ.', 7, 'LP00001', 21940000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ CK (Calvin Klein) K6L2M116', N'SP00007.jpg', N'SP00007', N'Đồng hồ nữ CK Light Medium, Quartz, Dây đeo thép không gỉ mạ PVD vàng hồng, Mặt số tối giản, Kính cứng, Chống nước 30m.', 3, N'Thiết kế vòng tay (bangle) độc đáo, thời trang và nữ tính. Phù hợp với phong cách công sở và dạo phố.', 1, 'LP00002', 6820000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ CK (Calvin Klein) K5U2M141', N'SP00008.jpg', N'SP00008', N'Đồng hồ nữ CK Round, Quartz Thụy Sĩ, Vỏ thép không gỉ, Dây đeo da, Mặt số đen, Kính khoáng chịu lực. Thiết kế tối giản, thanh lịch.', 3, N'Mẫu đồng hồ nữ cổ điển, dễ phối đồ. Thiết kế mặt tròn đơn giản mang tính ứng dụng cao.', 3, 'LP00002', 7650000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T086.407.22.051.00', N'SP00009.jpg', N'SP00009', N'Đồng hồ nam Tissot Luxury Automatic, Bộ máy Powermatic 80 trữ cót 80 giờ, Thép không gỉ/Mạ PVD Vàng, Kính Sapphire chống lóa, Lịch ngày.', 1, N'Cỗ máy Automatic Thụy Sĩ mạnh mẽ với 80 giờ trữ cót. Thiết kế sang trọng, lịch lãm, phù hợp với doanh nhân.', 2, 'LP00001', 27900000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-200V5S35', N'SP00010.jpg', N'SP00010', N'Đồng hồ nam FC Slimline, Quartz Calibre FC-200, Vỏ thép mạ PVD vàng, Dây da cá sấu nâu, Kính sapphire, Độ mỏng ấn tượng.', 2, N'Thiết kế siêu mỏng và thanh lịch theo phong cách Dress Watch. Thương hiệu Thụy Sĩ cao cấp với mức giá phải chăng.', 2, 'LP00001', 14630000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T060.407.22.051.00', N'SP00011.jpg', N'SP00011', N'Đồng hồ nam Tissot T-Tempo Automatic, Thép không gỉ mạ PVD, Kính sapphire, Lịch ngày. Thiết kế 3 kim đơn giản, thanh lịch.', 1, N'Sự kết hợp hoàn hảo giữa công nghệ Automatic Thụy Sĩ và phong cách cổ điển, trường tồn với thời gian.', 3, 'LP00001', 23130000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T101.452.11.031.00', N'SP00012.jpg', N'SP00012', N'Đồng hồ nam Tissot PR100 Dual Time, Quartz ETA F06.811, Chức năng Dual Time (2 múi giờ), Thép không gỉ, Kính sapphire, Chống nước 100m.', 1, N'Dòng PR100 nổi tiếng về độ bền và chính xác. Chức năng Dual Time hữu ích cho người thường xuyên di chuyển.', 3, 'LP00001', 10260000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ CK (Calvin Klein) K0K21107', N'SP00013.jpg', N'SP00013', N'Đồng hồ nam, Thép không gỉ 316L/Mạ PVD, Vỏ Thép không gỉ 316L/Mạ PVD, Kính cứng', 3, N'Chỉ có Xwatch Luxury mới giúp được bạn: - Bảo hành 5 năm cả lỗi người dùng theo tiêu chuẩn Thụy Sĩ - Đội ngũ kĩ thuật chuyên nghiệp được đào tạo bài bản từ chuyên gia Thụy Sĩ - Đổi trả trong 15 ngày - Hậu mãi: thay pin trọn đời, lau dầu miễn phí trong 5 năm', 5, 'LP00001', 7360000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-312G4S4', N'SP00014.jpg', N'SP00014', N'Đồng hồ nam FC Slimline Automatic, Bộ máy Heart Beat FC-312, Vỏ thép mạ vàng hồng, Dây da cá sấu nâu, Mặt số đen, Kính sapphire chống phản quang.', 2, N'Tuyệt tác Dress Watch thanh lịch, với tính năng Heart Beat lộ máy độc quyền của Frederique Constant.', 4, 'LP00001', 54300000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-393RM5B4', N'SP00015.jpg', N'SP00015', N'Đồng hồ nam FC Runabout Chronograph, Automatic Calibre FC-393, Phiên bản giới hạn, Chức năng bấm giờ thể thao, Dây da cá sấu xanh, Kính sapphire.', 2, N'“Du thuyền” sang trọng trên cổ tay. Sở hữu ngay tác phẩm độc đáo từ Frederique Constant. Phiên bản giới hạn, cực kỳ giá trị cho nhà sưu tầm.', 4, 'LP00001', 87050000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-303RMC6B4', N'SP00016.jpg', N'SP00016', N'Đồng hồ nam FC Runabout Automatic, Limited Edition, Bộ máy FC-303 (dựa trên Sellita SW200-1), 26 chân kính, tần số 28800 alt/h, Vỏ thép mạ PVD vàng hồng, Dây da nâu, Kính sapphire.', 2, N'Gam trầm trên chiếc đồng hồ vừa cổ điển vừa mới lạ. Thiết kế đơn giản nhưng bộc lộ sự nam tính rõ rệt, cỗ máy automatic Thụy Sĩ đỉnh cao. Giới hạn 2888 chiếc.', 1, 'LP00001', 46090000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Frederique Constant FC-330MC4P5', N'SP00017.jpg', N'SP00017', N'Đồng hồ nam FC Classics Moonphase, Automatic Calibre FC-330, Chức năng lịch tuần trăng và lịch ngày kim, Vỏ thép mạ PVD vàng, Dây da cá sấu nâu, Kính sapphire.', 2, N'Mẫu đồng hồ phức tạp (Complication) được săn đón nhất: Chức năng Moonphase lãng mạn kết hợp thiết kế cổ điển (Classic).', 2, 'LP00001', 44240000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ CK (Calvin Klein) K5U2S146', N'SP00018.jpg', N'SP00018', N'Đồng hồ nữ CK Round, Quartz, Vỏ và dây thép không gỉ, Mặt số bạc, Kính cứng. Thiết kế dạng vòng tay (Bangle) thanh mảnh.', 3, N'Thiết kế trang sức độc đáo, làm nổi bật cổ tay người phụ nữ hiện đại.', 1, 'LP00002', 9720000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ CK (Calvin Klein) K6L2SB16', N'SP00019.jpg', N'SP00019', N'Đồng hồ nữ CK Light, Quartz ETA 802.002, Vỏ thép mạ PVD vàng hồng, Dây thép không gỉ dạng vòng (Bangle), Kính cứng.', 3, N'Đồng hồ kiêm trang sức, phù hợp với mọi sự kiện. Kích thước nhỏ gọn, mặt số tối giản.', 2, 'LP00002', 7790000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T035.207.36.061.00', N'SP00020.jpg', N'SP00020', N'Đồng hồ nữ Tissot Couturier Automatic, Bộ máy Powermatic 80, Vỏ thép mạ PVD vàng hồng, Dây da đen, Kính sapphire. Thiết kế nắp lưng lộ máy (Skeleton Case Back).', 1, N'Cỗ máy Automatic nữ Powermatic 80 mạnh mẽ. Thiết kế sang trọng, vượt thời gian, nắp lưng lộ máy đẹp mắt.', 2, 'LP00002', 22410000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T109.210.33.031.00', N'SP00021.jpg', N'SP00021', N'Đồng hồ nữ Tissot Everytime, Quartz, Vỏ thép mạ PVD vàng hồng, Dây thép không gỉ, Kính sapphire. Thiết kế tối giản, classic.', 1, N'Tên gọi "Everytime" nói lên tất cả - Mẫu đồng hồ cơ bản, dễ đeo, phù hợp với mọi dịp.', 1, 'LP00002', 6750000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T103.310.36.111.00', N'SP00022.jpg', N'SP00022', N'Đồng hồ nữ Tissot Bella Ora, Quartz ETA 980.153, Vỏ thép hình Oval mạ PVD vàng hồng, Dây da kem, Mặt số khảm trai (Mother of Pearl) và kim giây nhỏ (Small Second).', 1, N'Thiết kế thanh lịch kiểu dáng Oval độc đáo, mặt số khảm trai quý phái, là một món phụ kiện trang sức tinh tế.', 3, 'LP00002', 11680000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T101.210.22.031.00', N'SP00023.jpg', N'SP00023', N'Đồng hồ nữ Tissot PR100, Quartz, Vỏ thép/Dây thép không gỉ mạ PVD vàng, Kính sapphire, Chống nước 100m. Thiết kế demi sang trọng.', 1, N'Mẫu đồng hồ thanh lịch, bền bỉ của Tissot, phù hợp cho sử dụng hàng ngày và môi trường công sở.', 2, 'LP00002', 10730000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T094.210.26.111.01', N'SP00024.jpg', N'SP00024', N'Đồng hồ nữ Tissot Flamingo, Quartz ETA F03.111, Dây da dập vân, Vỏ thép mạ PVD vàng hồng, Mặt số khảm trai, Lịch ngày, Kính sapphire.', 1, N'Thiết kế lấy cảm hứng từ chim Hồng Hạc, duyên dáng và nữ tính, mặt số khảm trai lấp lánh.', 2, 'LP00002', 9790000)
INSERT INTO SANPHAM VALUES (N'Đồng hồ Tissot T058.009.33.031.01', N'SP00025.jpg', N'SP00025', N'Đồng hồ nữ Tissot Lovely, Quartz, Vỏ thép/Dây thép không gỉ mạ PVD vàng, Kính sapphire. Kích thước siêu nhỏ (20mm) như một món trang sức.', 1, N'Đúng như tên gọi, chiếc đồng hồ nhỏ xinh như một món trang sức, được đánh giá cao về sự thanh lịch và dễ đọc.', 2, 'LP00002', 11210000)

INSERT INTO KHACHHANG VALUES (1, N'Nguyễn Văn A', 'user@gmail.com', '0901234567', N'Nam', N'123 Lê Lợi, Hà Nội')
INSERT INTO KHACHHANG VALUES (1, N'Trần Thị B', 'tranthib@example.com', '0912345678', N'Nữ', N'456 Hai Bà Trưng, Đà Nẵng')
INSERT INTO KHACHHANG VALUES (1, N'Lê Văn C', 'levanc@example.com', '0987654321', N'Nam', N'789 Nguyễn Huệ, TP.HCM')
INSERT INTO KHACHHANG VALUES (2, N'Phạm Văn Dũng', 'dungpv@example.com', '0933445566', N'Nam', N'101 Trần Phú, Hải Phòng')
INSERT INTO KHACHHANG VALUES (2, N'Hoàng Thị E', 'ehoang@example.com', '0944556677', N'Nữ', N'202 Võ Văn Tần, Cần Thơ')

INSERT INTO DONHANG VALUES (1, 1, N'Đã giao', N'123 Lê Lợi, Hà Nội', '0901234567', '2025-01-10', '2025-01-12', N'Mua Tissot T106', 11000000)
INSERT INTO DONHANG VALUES (2, 2, N'Đang giao', N'456 Hai Bà Trưng, Đà Nẵng', '0912345678', '2025-02-05', '2025-02-08', N'Mua Frederique Constant Smartwatch', 27040000)
INSERT INTO DONHANG VALUES (3, 3, N'Đã hủy', N'789 Nguyễn Huệ, TP.HCM', '0987654321', '2025-02-15', NULL, N'Đồng hồ Tissot Chronograph', 14700000)
INSERT INTO DONHANG VALUES (4, 4, N'Đã giao', N'101 Trần Phú, Hải Phòng', '0933445566', '2025-03-01', '2025-03-04', N'Đồng hồ Carson Demi', 11730000)
INSERT INTO DONHANG VALUES (5, 5, N'Đã giao', N'202 Võ Văn Tần, Cần Thơ', '0944556677', '2025-03-10', '2025-03-13', N'Đồng hồ CK nữ', 6820000)

INSERT INTO CHITIETDONHANG VALUES (1, 1, 1)
INSERT INTO CHITIETDONHANG VALUES (2, 4, 1)
INSERT INTO CHITIETDONHANG VALUES (3, 3, 1)
INSERT INTO CHITIETDONHANG VALUES (4, 2, 1)
INSERT INTO CHITIETDONHANG VALUES (5, 5, 1)

INSERT INTO KHUYENMAI VALUES ('KM00001', N'Giảm giá Tết', '2025-01-01', '2025-01-31')
INSERT INTO KHUYENMAI VALUES ('KM00002', N'Giảm giá Black Friday', '2025-11-20', '2025-11-30')
INSERT INTO KHUYENMAI VALUES ('KM00003', N'Ưu đãi Khai xuân', '2025-02-10', '2025-02-20')
INSERT INTO KHUYENMAI VALUES ('KM00004', N'Mừng Quốc khánh', '2025-09-01', '2025-09-05')
INSERT INTO KHUYENMAI VALUES ('KM00005', N'Tri ân Khách hàng VIP', '2025-10-20', '2025-10-31')

INSERT INTO CHITIETKM VALUES ('KM00001', 1, 10)
INSERT INTO CHITIETKM VALUES ('KM00002', 4, 15)
INSERT INTO CHITIETKM VALUES ('KM00003', 2, 5)
INSERT INTO CHITIETKM VALUES ('KM00004', 5, 12)
INSERT INTO CHITIETKM VALUES ('KM00005', 3, 20)

INSERT INTO BINHLUAN VALUES ('BL00001', 1, 1, N'Đồng hồ rất đẹp và sang trọng!', GETDATE())
INSERT INTO BINHLUAN VALUES ('BL00002', 1, 4, N'Thiết kế đẹp, tính năng thông minh hoạt động rất tốt!', DATEADD(day, 1, GETDATE()))
INSERT INTO BINHLUAN VALUES ('BL00003', 1, 3, N'Màu vàng hồng rất sang trọng, chờ nhận hàng!', DATEADD(day, 2, GETDATE()))
INSERT INTO BINHLUAN VALUES ('BL00004', 2, 2, N'Thiết kế Demi rất đẹp và lịch sự. Kính Sapphire chống trầy xước tốt.', DATEADD(day, 3, GETDATE()))
INSERT INTO BINHLUAN VALUES ('BL00005', 2, 5, N'Chiếc đồng hồ CK nữ này rất thời trang, đeo đi tiệc rất hợp.', DATEADD(day, 4, GETDATE()))

INSERT INTO DANHGIA VALUES (1, 1, N'Chất lượng tuyệt vời!', 5)
INSERT INTO DANHGIA VALUES (4, 1, N'Rất hài lòng với tính năng Smartwatch kín đáo.', 5)
INSERT INTO DANHGIA VALUES (2, 1, N'Đồng hồ phù hợp cho môi trường công sở, rất ưng ý!', 5)
INSERT INTO DANHGIA VALUES (3, 2, N'Thiết kế quá đẹp, xứng đáng với giá tiền.', 5)
INSERT INTO DANHGIA VALUES (5, 2, N'Nhỏ xinh, dễ thương, đúng như mong đợi.', 4)