// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HR App';

  @override
  String get signIn => 'Sign In';

  @override
  String get secureAccess => 'Secure Access';

  @override
  String get connectWorkspace => 'Connect with your BLUE HR workspace';

  @override
  String get email => 'Email';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 4 characters';

  @override
  String welcomeName(String name) {
    return 'Welcome $name!';
  }

  @override
  String get authFailed => 'Authentication failed';

  @override
  String connectionError(String error) {
    return 'Connection error: $error';
  }

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get loggedOutSuccess => 'Logged out successfully';

  @override
  String logoutError(String error) {
    return 'Error during logout: $error';
  }

  @override
  String get hrDashboard => 'HR Dashboard';

  @override
  String get employee => 'Employee';

  @override
  String get noEmail => 'No email';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get goodNight => 'Good Night';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String greetingHappyDay(String greeting, String day) {
    return '$greeting! Happy $day';
  }

  @override
  String get welcomeBackDashboard => 'Welcome back to your HR dashboard';

  @override
  String currentTime(String time) {
    return 'Current time: $time';
  }

  @override
  String get registerAttendance => 'Register Attendance';

  @override
  String get currentlyWorking => 'Currently Working';

  @override
  String get notCheckedIn => 'Not Checked In';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get currentSession => 'Current Session';

  @override
  String startedAt(String time) {
    return 'Started at $time';
  }

  @override
  String get checkInFace => 'Check In (Face)';

  @override
  String get checkOutFace => 'Check Out (Face)';

  @override
  String get viewDetails => 'View Details';

  @override
  String get whatDoYouNeed => 'What do you need?';

  @override
  String get contracts => 'Contracts';

  @override
  String get payslip => 'Payslip';

  @override
  String get expenses => 'Expenses';

  @override
  String get attendance => 'Attendance';

  @override
  String get successCheckedOut => 'Successfully checked out';

  @override
  String get successCheckedIn => 'Successfully checked in';

  @override
  String get failedUpdateAttendance =>
      'Failed to update attendance. Please check your connection and try again.';

  @override
  String errorGeneric(String error) {
    return 'Error: $error';
  }

  @override
  String get attendanceManagement => 'Attendance Management';

  @override
  String get viewReports => 'View Reports';

  @override
  String get dismiss => 'Dismiss';

  @override
  String alreadyCheckedInSnack(String time) {
    return 'You are already checked in since $time. Use the Log Out button below to check out.';
  }

  @override
  String get readyToStart => 'Ready to Start';

  @override
  String get currentlyWorkingStatus => 'Currently Working';

  @override
  String get checkedInActive =>
      'You are checked in and your work session is active';

  @override
  String get notCheckedInReady =>
      'You are not checked in. Ready to start your work session.';

  @override
  String startedAtLabel(String time) {
    return 'Started at: $time';
  }

  @override
  String idLabel(String id) {
    return 'ID: $id';
  }

  @override
  String get na => 'N/A';

  @override
  String get notCheckedInUseLogin =>
      'Not Checked In - Use Log In to start your shift';

  @override
  String checkedInSinceUseLogout(String time) {
    return 'Checked in since $time - Use Log Out to end your shift';
  }

  @override
  String get records => 'Records';

  @override
  String get endYourShift => 'End Your Shift';

  @override
  String get startYourShift => 'Start Your Shift';

  @override
  String get checkedInClickLogout =>
      'You are currently checked in. Click Log Out to end your work session.';

  @override
  String get notCheckedInClickLogin =>
      'You are not checked in. Click Log In to start your work session.';

  @override
  String get logOut => 'Log Out';

  @override
  String get logIn => 'Log In';

  @override
  String get todaySummary => 'Today\'s Summary';

  @override
  String get totalWorked => 'Total Worked';

  @override
  String get todayRecords => 'Today\'s Records';

  @override
  String get noAttendanceToday => 'No attendance records for today';

  @override
  String get checkInToStart => 'Check in to start tracking your time';

  @override
  String get viewDetailedReports => 'View Detailed Reports';

  @override
  String get activeSession => 'Active Session';

  @override
  String get completedSession => 'Completed Session';

  @override
  String get live => 'LIVE';

  @override
  String get checkIn => 'Check In';

  @override
  String get checkOut => 'Check Out';

  @override
  String get duration => 'Duration';

  @override
  String get successCheckedOutShort => 'Successfully checked out';

  @override
  String get successCheckedInShort => 'Successfully checked in';

  @override
  String get failedUpdateAttendanceShort => 'Failed to update attendance';

  @override
  String get attendanceReport => 'Attendance Report';

  @override
  String get summary => 'Summary';

  @override
  String get analytics => 'Analytics';

  @override
  String get thisMonth => 'This Month';

  @override
  String get lastMonth => 'Last Month';

  @override
  String get customRange => 'Custom Range';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get quickStatistics => 'Quick Statistics';

  @override
  String get totalHours => 'Total Hours';

  @override
  String get dailyAverage => 'Daily Average';

  @override
  String get sessions => 'Sessions';

  @override
  String get onTime => 'On Time';

  @override
  String get weeklyOverview => 'Weekly Overview';

  @override
  String get monthlyOverview => 'Monthly Overview';

  @override
  String get workingDays => 'Working Days';

  @override
  String get avgDaily => 'Avg Daily';

  @override
  String get attendanceTrends => 'Attendance Trends';

  @override
  String get loadingTrends => 'Loading trends...';

  @override
  String get totalHoursLabel => 'Total Hours';

  @override
  String get onTimeRate => 'On Time Rate';

  @override
  String get sessionsWithLocation => 'Sessions with Location';

  @override
  String get punctualityAnalysis => 'Punctuality Analysis';

  @override
  String get late => 'Late';

  @override
  String get earlyLeave => 'Early Leave';

  @override
  String get locationTracking => 'Location Tracking';

  @override
  String get withLocation => 'With Location';

  @override
  String get withoutLocation => 'Without Location';

  @override
  String get noAttendanceRecords => 'No attendance records found';

  @override
  String get tryDifferentPeriod => 'Try selecting a different period';

  @override
  String get exportReport => 'Export Report';

  @override
  String get exportAsCsv => 'Export as CSV';

  @override
  String get exportCsvSubtitle => 'Spreadsheet compatible format';

  @override
  String get exportAsPdf => 'Export as PDF';

  @override
  String get exportPdfSubtitle => 'Print-ready format';

  @override
  String get exportAsJson => 'Export as JSON';

  @override
  String get exportJsonSubtitle => 'Developer-friendly format';

  @override
  String exportingAs(String format) {
    return 'Exporting report as $format...';
  }

  @override
  String get newExpense => 'New Expense';

  @override
  String get expenseName => 'Expense Name';

  @override
  String get expenseNameHint => 'e.g., Business lunch with client';

  @override
  String get pleaseEnterExpenseName => 'Please enter expense name';

  @override
  String get amount => 'Amount';

  @override
  String get pleaseEnterAmount => 'Please enter amount';

  @override
  String get pleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get descriptionOptional => 'Description (Optional)';

  @override
  String get descriptionHint => 'Additional details about the expense';

  @override
  String get referenceOptional => 'Reference (Optional)';

  @override
  String get referenceHint => 'Invoice number or reference';

  @override
  String get submitExpense => 'Submit Expense';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Select a category';

  @override
  String get unknown => 'Unknown';

  @override
  String get noCategoriesAvailable =>
      'No categories available. Please configure expense products in Odoo.';

  @override
  String get date => 'Date';

  @override
  String get paymentMode => 'Payment Mode';

  @override
  String get ownAccount => 'Own Account';

  @override
  String get companyAccount => 'Company Account';

  @override
  String get receiptOptional => 'Receipt (Optional)';

  @override
  String get receiptAttached => 'Receipt attached';

  @override
  String get tapToUploadReceipt => 'Tap to upload receipt';

  @override
  String get takePhotoOrSelect => 'Take photo or select from gallery';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get removeReceipt => 'Remove Receipt';

  @override
  String failedToLoadData(String error) {
    return 'Failed to load data: $error';
  }

  @override
  String get employeeInfoNotAvailable => 'Employee information not available';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get expenseCreatedSuccess => 'Expense created successfully!';

  @override
  String get failedToCreateExpense => 'Failed to create expense';

  @override
  String errorCreatingExpense(String error) {
    return 'Error creating expense: $error';
  }

  @override
  String get locationServicesDisabled =>
      'Location services are disabled. Please enable them to continue.';

  @override
  String get locationPermissionDenied =>
      'Location permission denied. Please grant access from settings.';

  @override
  String get couldNotSelectImage => 'Could not select image.';

  @override
  String get faceImageNotSelected =>
      'Face image not selected. Please try again.';

  @override
  String get checkoutCompletedSuccess => 'Check-out completed successfully.';

  @override
  String get checkinCompletedSuccess => 'Check-in completed successfully.';

  @override
  String get attendanceActionFailed => 'Attendance action failed.';

  @override
  String unexpectedError(String error) {
    return 'Unexpected error: $error';
  }

  @override
  String errorPickingImage(String error) {
    return 'Error picking image: $error';
  }

  @override
  String get waitingForLocation => 'Waiting for location...';

  @override
  String get smartAttendance => 'Smart Attendance';

  @override
  String get welcome => 'Welcome!';

  @override
  String get whatWouldYouLikeToDo => 'What would you like to do today?';

  @override
  String get checkInCheckOut => 'Check In / Check Out';

  @override
  String get currentlyCheckedInTapOut =>
      'Currently checked in - Tap to check out';

  @override
  String get readyToStartTapIn => 'Ready to start - Tap to check in';

  @override
  String get currentLocation => 'Current Location';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get odooServer => 'Odoo Server';

  @override
  String get view => 'View';

  @override
  String failedToLoadPayslips(String error) {
    return 'Failed to load payslips: $error';
  }

  @override
  String failedToLoadEmployeeData(String error) {
    return 'Failed to load employee data: $error';
  }

  @override
  String get contractsNotAvailable => 'Contracts Not Available';

  @override
  String errorLoadingEmployeeData(String error) {
    return 'Error loading employee data: $error';
  }

  @override
  String leaveRequestStatusUpdated(String leaveType, String status) {
    return '$leaveType request status updated to $status';
  }

  @override
  String get payslips => 'Payslips';

  @override
  String get errorLoadingPayslips => 'Error Loading Payslips';

  @override
  String get retry => 'Retry';

  @override
  String get employeePayslipOverview => 'Employee Payslip Overview';

  @override
  String get total => 'Total';

  @override
  String get paid => 'Paid';

  @override
  String get verified => 'Verified';

  @override
  String get draft => 'Draft';

  @override
  String get all => 'All';

  @override
  String get noPayslipsFound => 'No payslips found for this employee';

  @override
  String get payslipsWillAppear =>
      'Payslips will appear here once they are generated for this employee';

  @override
  String get noPayslipsMatchingFilter =>
      'No payslips found matching your filter';

  @override
  String get tryAdjustingFilterPayslip =>
      'Try adjusting your filter or contact HR to generate a new payslip.';

  @override
  String periodLabel(String period) {
    return 'Period: $period';
  }

  @override
  String statusLabel(String status) {
    return 'Status: $status';
  }

  @override
  String netWage(String amount) {
    return 'Net Wage: $amount';
  }

  @override
  String get employeeLabel => 'Employee';

  @override
  String get dateRange => 'Date Range';

  @override
  String get basicWage => 'Basic Wage';

  @override
  String get grossWage => 'Gross Wage';

  @override
  String get created => 'Created';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String get edit => 'Edit';

  @override
  String get actions => 'Actions';

  @override
  String get payslipActionsComingSoon => 'Payslip actions coming soon!';

  @override
  String get createPayslipComingSoon =>
      'Create payslip functionality coming soon!';

  @override
  String get editPayslipComingSoon => 'Edit payslip functionality coming soon!';

  @override
  String get contractsTitle => 'Contracts';

  @override
  String get employeeContractOverview => 'Employee Contract Overview';

  @override
  String get active => 'Active';

  @override
  String get expired => 'Expired';

  @override
  String get goBack => 'Go Back';

  @override
  String get noContractsFound => 'No contracts found for this employee';

  @override
  String get contractsWillAppear =>
      'Contracts will appear here once they are created for this employee';

  @override
  String get createContract => 'Create Contract';

  @override
  String get noContractsMatchingFilter =>
      'No contracts found matching your filter';

  @override
  String get tryAdjustingFilterContract =>
      'Try adjusting your filter or contact HR to create a new contract.';

  @override
  String get unknownEmployee => 'Unknown Employee';

  @override
  String get closed => 'Closed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get employeeInformation => 'Employee Information';

  @override
  String get contractPeriod => 'Contract Period';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get ongoing => 'Ongoing';

  @override
  String durationDays(int count) {
    return '$count days';
  }

  @override
  String get salaryDetails => 'Salary Details';

  @override
  String get wage => 'Wage';

  @override
  String get contractType => 'Contract Type';

  @override
  String get fullTime => 'Full Time';

  @override
  String get systemInformation => 'System Information';

  @override
  String get delete => 'Delete';

  @override
  String get deleteContract => 'Delete Contract';

  @override
  String deleteContractConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get createContractComingSoon =>
      'Create contract functionality coming soon!';

  @override
  String get editContractComingSoon =>
      'Edit contract functionality coming soon!';

  @override
  String get deleteContractComingSoon =>
      'Delete contract functionality coming soon!';

  @override
  String get myExpenses => 'My Expenses';

  @override
  String get addNewExpense => 'Add New Expense';

  @override
  String get refresh => 'Refresh';

  @override
  String get noExpensesFound => 'No expenses found';

  @override
  String get tapNewExpenseToCreate =>
      'Tap the \"New Expense\" button above to create your first expense request';

  @override
  String get expenseDetails => 'Expense Details';

  @override
  String get description => 'Description';

  @override
  String get taxAmount => 'Tax Amount';

  @override
  String get notes => 'Notes';

  @override
  String get employeeId => 'Employee ID';

  @override
  String get paidBy => 'Paid By';

  @override
  String get errorLoadingExpenses => 'Error loading expenses';

  @override
  String get failedToLoadExpenses => 'Failed to load expenses';

  @override
  String errorProcessingExpenses(String error) {
    return 'Error processing expenses: $error';
  }

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';
}
