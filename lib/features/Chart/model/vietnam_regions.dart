// lib/features/Chart/model/vietnam_regions.dart

class VietnamRegion {
  final String name;
  final String shortName;      
  final String color;        
  final String borderColor;   
  final List<String> provinces;
  final String description;
  final int population;       
  final double gdpShare;      

  const VietnamRegion({
    required this.name,
    required this.shortName,
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
    shortName: 'Miền núi BB',
    color: '#5B7FA6',
    borderColor: '#3A5A80',
    provinces: [
      'Hà Giang', 'Cao Bằng', 'Bắc Kạn', 'Tuyên Quang',
      'Lào Cai', 'Yên Bái', 'Thái Nguyên', 'Lạng Sơn',
      'Bắc Giang', 'Phú Thọ', 'Điện Biên', 'Lai Châu',
      'Sơn La', 'Hòa Bình',
    ],
    description: '14 tỉnh · Tây Bắc & Đông Bắc · Diện tích lớn nhất',
    population: 13,
    gdpShare: 9.5,
  ),
  VietnamRegion(
    name: 'Đồng bằng sông Hồng',
    shortName: 'ĐB sông Hồng',
    color: '#D4922A',
    borderColor: '#A06800',
    provinces: [
      'Hà Nội', 'Hải Phòng', 'Quảng Ninh', 'Vĩnh Phúc',
      'Bắc Ninh', 'Hải Dương', 'Hưng Yên', 'Thái Bình',
      'Hà Nam', 'Nam Định', 'Ninh Bình',
    ],
    description: '11 tỉnh/thành · Trung tâm chính trị · Văn hóa ngàn năm',
    population: 23,
    gdpShare: 28.5,
  ),
  VietnamRegion(
    name: 'Bắc Trung Bộ và Duyên hải miền Trung',
    shortName: 'Duyên hải MT',
    color: '#4A9A5A',
    borderColor: '#2A6A3A',
    provinces: [
      'Thanh Hóa', 'Nghệ An', 'Hà Tĩnh', 'Quảng Bình',
      'Quảng Trị', 'Thừa Thiên Huế', 'Đà Nẵng', 'Quảng Nam',
      'Quảng Ngãi', 'Bình Định', 'Phú Yên', 'Khánh Hòa',
      'Ninh Thuận', 'Bình Thuận',
    ],
    description: '14 tỉnh/thành · Dải đất hẹp ven biển · Du lịch phát triển',
    population: 20,
    gdpShare: 13.0,
  ),
  VietnamRegion(
    name: 'Tây Nguyên',
    shortName: 'Tây Nguyên',
    color: '#B86830',
    borderColor: '#884010',
    provinces: [
      'Kon Tum', 'Gia Lai', 'Đắk Lắk', 'Đắk Nông', 'Lâm Đồng',
    ],
    description: '5 tỉnh · Cao nguyên · Cà phê & hồ tiêu số 1 VN',
    population: 6,
    gdpShare: 4.0,
  ),
  VietnamRegion(
    name: 'Đông Nam Bộ',
    shortName: 'Đông Nam Bộ',
    color: '#B84848',
    borderColor: '#882020',
    provinces: [
      'TP Hồ Chí Minh', 'Bình Phước', 'Tây Ninh',
      'Bình Dương', 'Đồng Nai', 'Bà Rịa - Vũng Tàu',
    ],
    description: '6 tỉnh/thành · Đầu tàu kinh tế · GDP cao nhất cả nước',
    population: 18,
    gdpShare: 32.0,
  ),
  VietnamRegion(
    name: 'Đồng bằng sông Cửu Long',
    shortName: 'ĐB sông CL',
    color: '#2A9898',
    borderColor: '#0A6868',
    provinces: [
      'Long An', 'Tiền Giang', 'Bến Tre', 'Trà Vinh',
      'Vĩnh Long', 'Đồng Tháp', 'An Giang', 'Kiên Giang',
      'Cần Thơ', 'Hậu Giang', 'Sóc Trăng', 'Bạc Liêu', 'Cà Mau',
    ],
    description: '13 tỉnh/thành · Vựa lúa & thuỷ sản · Sông nước mênh mang',
    population: 17,
    gdpShare: 13.0,
  ),
];

Map<String, VietnamRegion> buildProvinceToRegionMap() {
  final map = <String, VietnamRegion>{};
  for (final region in vietnamRegions) {
    for (final province in region.provinces) {
      map[province] = region;
    }
  }
  return map;
}