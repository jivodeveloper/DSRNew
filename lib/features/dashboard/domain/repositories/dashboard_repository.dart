import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';

abstract interface class DashboardRepository {

  Future<UserDetails> getDetailsById();
  
}
