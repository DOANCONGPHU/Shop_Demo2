// Màu sắc và dữ liệu cho 6 vùng kinh tế Việt Nam
class VietnamRegion {
  final String name;
  final String color;        // màu nền vùng
  final String borderColor;  // màu viền
  final List<String> provinces;
  final String description;
  final int population;      // triệu người (xấp xỉ)
  final double gdpShare;     // % đóng góp GDP

  const VietnamRegion({
    required this.name,
    required this.color,
    required this.borderColor,
    required this.provinces,
    required this.description,
    required this.population,
    required this.gdpShare,
  });
}

const List<VietnamRegion> vietnamRegions = [
  VietnamRegion(
    name: 'Trung du và miền núi phía Bắc',
    color: '#6B8CBA',
    borderColor: '#3A5A8A',
    provinces: [
      'Hà Giang', 'Cao Bằng', 'Bắc Kạn', 'Tuyên Quang',
      'Lào Cai', 'Yên Bái', 'Thái Nguyên', 'Lạng Sơn',
      'Bắc Giang', 'Phú Thọ', 'Điện Biên', 'Lai Châu',
      'Sơn La', 'Hòa Bình',
    ],
    description: '14 tỉnh, diện tích lớn nhất cả nước',
    population: 13,
    gdpShare: 9.5,
  ),
  VietnamRegion(
    name: 'Đồng bằng sông Hồng',
    color: '#E8A838',
    borderColor: '#B07820',
    provinces: [
      'Hà Nội', 'Hải Phòng', 'Quảng Ninh', 'Vĩnh Phúc',
      'Bắc Ninh', 'Hải Dương', 'Hưng Yên', 'Thái Bình',
      'Hà Nam', 'Nam Định', 'Ninh Bình',
    ],
    description: '11 tỉnh/thành, trung tâm chính trị',
    population: 23,
    gdpShare: 28.5,
  ),
  VietnamRegion(
    name: 'Bắc Trung Bộ và Duyên hải miền Trung',
    color: '#7DC87D',
    borderColor: '#3A8A3A',
    provinces: [
      'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình',
      'Quảng Trị', 'Thừa Thiên Huế', 'Đà Nẵng', 'Quảng Nam',
      'Quảng Ngãi', 'Bình Định', 'Phú Yên', 'Khánh Hòa',
      'Ninh Thuận', 'Bình Thuận',
    ],
    description: '14 tỉnh/thành, dải đất miền Trung',
    population: 20,
    gdpShare: 13.0,
  ),
  VietnamRegion(
    name: 'Tây Nguyên',
    color: '#C47A3C',
    borderColor: '#8A4A10',
    provinces: [
      'Kon Tum', 'Gia Lai', 'Đắk Lắk', 'Đắk Nông', 'Lâm Đồng',
    ],
    description: '5 tỉnh, cao nguyên trung tâm',
    population: 6,
    gdpShare: 4.0,
  ),
  VietnamRegion(
    name: 'Đông Nam Bộ',
    color: '#C45A5A',
    borderColor: '#8A2A2A',
    provinces: [
      'TP Hồ Chí Minh', 'Bình Phước', 'Tây Ninh',
      'Bình Dương', 'Đồng Nai', 'Bà Rịa - Vũng Tàu',
    ],
    description: '6 tỉnh/thành, đầu tàu kinh tế',
    population: 18,
    gdpShare: 32.0,
  ),
  VietnamRegion(
    name: 'Đồng bằng sông Cửu Long',
    color: '#5AABAB',
    borderColor: '#2A7A7A',
    provinces: [
      'Long An', 'Tiền Giang', 'Bến Tre', 'Trà Vinh',
      'Vĩnh Long', 'Đồng Tháp', 'An Giang', 'Kiên Giang',
      'Cần Thơ', 'Hậu Giang', 'Sóc Trăng', 'Bạc Liêu', 'Cà Mau',
    ],
    description: '13 tỉnh/thành, vựa lúa cả nước',
    population: 17,
    gdpShare: 13.0,
  ),
];

// Tra cứu nhanh: tên tỉnh → vùng
Map<String, VietnamRegion> buildProvinceToRegionMap() {
  final map = <String, VietnamRegion>{};
  for (final region in vietnamRegions) {
    for (final province in region.provinces) {
      map[province] = region;
    }
  }
  return map;
}