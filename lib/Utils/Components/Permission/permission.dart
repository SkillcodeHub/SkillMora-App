// // Permission Model
// class Permission {
//   final int permissionId;
//   final String moduleName;
//   final bool hasAccess;
//   final bool canCreate;
//   final bool canEdit;
//   final bool canDelete;
//   final bool canList;

//   Permission({
//     required this.permissionId,
//     required this.moduleName,
//     required this.hasAccess,
//     required this.canCreate,
//     required this.canEdit,
//     required this.canDelete,
//     required this.canList,
//   });

//   factory Permission.fromJson(Map<String, dynamic> json) {
//     return Permission(
//       permissionId: json['permissionId'] ?? 0,
//       moduleName: json['moduleName'] ?? '',
//       hasAccess: json['access'] == 1,
//       canCreate: json['create'] == 1,
//       canEdit: json['edit'] == 1,
//       canDelete: json['delete'] == 1,
//       canList: json['list'] == 1,
//     );
//   }
// }

const String Home = 'Home';
const String Payments = 'Payments';
const String MyAccount = 'My Account';
const String SoftwareFAQs = 'Software FAQs';
const String DoctorReference = 'Doctor Reference';
const String SupportTickets = 'Support Tickets';
const String Dashboardpage = 'Dashboard';
const String Appointment = 'Appointment';
const String Insight = 'Insight';
const String Patient = 'Patient';
const String Services = 'Services';
const String PatientPayment = 'Patient Payment';
const String AppRenewal = 'App Renewal';
const String AppBanner = 'App Banner';
const String AppSettings = 'App Settings';
const String PaymentSetting = 'Payment Setting';
const String News = 'News';
const String User = 'User';
const String BlockAppointment = 'Block Appointment';
const String AuthRoles = 'Auth Roles';
const String UserDetails = 'User Details';



// Permission model with corrected boolean parsing
class PermissionModel {
  final int permissionId;
  final String moduleName;
  final bool hasAccess;
  final bool canCreate;
  final bool canEdit;
  final bool canDelete;
  final bool canList;

  PermissionModel({
    required this.permissionId,
    required this.moduleName,
    required this.hasAccess,
    required this.canCreate,
    required this.canEdit,
    required this.canDelete,
    required this.canList,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    // Helper function to properly parse boolean values
    bool parseBool(dynamic value) {
      if (value is bool) return value;
      if (value is num) return value == 1;
      if (value is String) return value.toLowerCase() == 'true' || value == '1';
      return false;
    }

    return PermissionModel(
      permissionId: json['permissionId'] ?? 0,
      moduleName: json['moduleName'] ?? '',
      hasAccess: parseBool(json['access']),
      canCreate: parseBool(json['create']),
      canEdit: parseBool(json['edit']),
      canDelete: parseBool(json['delete']),
      canList: parseBool(json['list']),
    );
  }

  Map<String, dynamic> toJson() => {
    'permissionId': permissionId,
    'moduleName': moduleName,
    'access': hasAccess,
    'create': canCreate,
    'edit': canEdit,
    'delete': canDelete,
    'list': canList,
  };
}

