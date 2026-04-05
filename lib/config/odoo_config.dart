class OdooConfig {
  // Odoo server configuration - fixed values
  static const String baseUrl = 'https://al-shalawi.gulftriangle.net/mobile/';
  static const String database = 'al-shalawi';
  static const String apiVersion = '1.0';

  // API endpoints
  static const String xmlRpcEndpoint = '/xmlrpc/2/';
  static const String commonEndpoint = '/xmlrpc/2/common';
  static const String objectEndpoint = '/xmlrpc/2/object';

  // Authentication timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int readTimeout = 30000; // 30 seconds
  static const int writeTimeout = 30000; // 30 seconds for write operations

  // Default page size for records
  static const int defaultPageSize = 20;

  // HR Models
  static const String hrEmployeeModel = 'hr.employee';
  static const String hrAttendanceModel = 'hr.attendance';
  static const String hrExpenseModel = 'hr.expense';
  static const String hrContractModel = 'hr.contract';
  static const String hrPayslipModel = 'hr.payslip';
  static const String hrLeaveModel = 'hr.leave';
  static const String hrExpenseCategoryModel = 'hr.expense.category';
  static const String hrWorkScheduleModel = 'hr.work.schedule';

  /// Get the full URL for a specific endpoint
  static String getEndpointUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

  /// Get common endpoint URL
  static String get commonUrl => getEndpointUrl(commonEndpoint);

  /// Get object endpoint URL
  static String get objectUrl => getEndpointUrl(objectEndpoint);
}
