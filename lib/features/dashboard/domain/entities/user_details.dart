class UserDetails {

  const UserDetails({
    required this.id,
    required this.name,
    required this.userName,
    this.type,
    this.group,
    this.attendanceStatus,
    required this.target,
    required this.productiveTarget,
    required this.visitTarget,
    required this.totalShops,
    required this.assignedShops,
    required this.shopsCovered,
    required this.shopsProductive,
    required this.distanceAllowed,
    this.startTime,
    this.endTime,
  });
  
  final int id;
  final String name;
  final String userName;
  final String? type; 
  final String? group; 
  final String? attendanceStatus; 

  final double target;
  final int productiveTarget;
  final int visitTarget;

  final int totalShops;
  final int assignedShops;
  final int shopsCovered;
  final int shopsProductive;

  final int distanceAllowed; 
  final Duration? startTime;
  final Duration? endTime;
  
  bool get isPresent => attendanceStatus == 'P';

  /// 0.0 – 1.0  (102 / 316 = 0.32)
  double get coverageProgress =>
      assignedShops == 0 ? 0 : (shopsCovered / assignedShops).clamp(0, 1);

        /// 0.0 – 1.0  (9 / 200 = 0.045)
  double get productiveProgress =>
      productiveTarget == 0 ? 0 : (shopsProductive / productiveTarget).clamp(0, 1);

  int get shopsLeft => (assignedShops - shopsCovered).clamp(0, assignedShops);

  int get productiveLeft =>
      (productiveTarget - shopsProductive).clamp(0, productiveTarget);

}
