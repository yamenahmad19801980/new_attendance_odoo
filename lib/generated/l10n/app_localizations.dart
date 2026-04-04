import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HR App'**
  String get appTitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @secureAccess.
  ///
  /// In en, this message translates to:
  /// **'Secure Access'**
  String get secureAccess;

  /// No description provided for @connectWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Connect with your BLUE HR workspace'**
  String get connectWorkspace;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 4 characters'**
  String get passwordMinLength;

  /// No description provided for @welcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}!'**
  String welcomeName(String name);

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authFailed;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error: {error}'**
  String connectionError(String error);

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @loggedOutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get loggedOutSuccess;

  /// No description provided for @logoutError.
  ///
  /// In en, this message translates to:
  /// **'Error during logout: {error}'**
  String logoutError(String error);

  /// No description provided for @hrDashboard.
  ///
  /// In en, this message translates to:
  /// **'HR Dashboard'**
  String get hrDashboard;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No email'**
  String get noEmail;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get goodNight;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @greetingHappyDay.
  ///
  /// In en, this message translates to:
  /// **'{greeting}! Happy {day}'**
  String greetingHappyDay(String greeting, String day);

  /// No description provided for @welcomeBackDashboard.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to your HR dashboard'**
  String get welcomeBackDashboard;

  /// No description provided for @currentTime.
  ///
  /// In en, this message translates to:
  /// **'Current time: {time}'**
  String currentTime(String time);

  /// No description provided for @registerAttendance.
  ///
  /// In en, this message translates to:
  /// **'Register Attendance'**
  String get registerAttendance;

  /// No description provided for @currentlyWorking.
  ///
  /// In en, this message translates to:
  /// **'Currently Working'**
  String get currentlyWorking;

  /// No description provided for @notCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Not Checked In'**
  String get notCheckedIn;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @currentSession.
  ///
  /// In en, this message translates to:
  /// **'Current Session'**
  String get currentSession;

  /// No description provided for @startedAt.
  ///
  /// In en, this message translates to:
  /// **'Started at {time}'**
  String startedAt(String time);

  /// No description provided for @checkInFace.
  ///
  /// In en, this message translates to:
  /// **'Check In (Face)'**
  String get checkInFace;

  /// No description provided for @checkOutFace.
  ///
  /// In en, this message translates to:
  /// **'Check Out (Face)'**
  String get checkOutFace;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @whatDoYouNeed.
  ///
  /// In en, this message translates to:
  /// **'What do you need?'**
  String get whatDoYouNeed;

  /// No description provided for @contracts.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get contracts;

  /// No description provided for @payslip.
  ///
  /// In en, this message translates to:
  /// **'Payslip'**
  String get payslip;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @successCheckedOut.
  ///
  /// In en, this message translates to:
  /// **'Successfully checked out'**
  String get successCheckedOut;

  /// No description provided for @successCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Successfully checked in'**
  String get successCheckedIn;

  /// No description provided for @failedUpdateAttendance.
  ///
  /// In en, this message translates to:
  /// **'Failed to update attendance. Please check your connection and try again.'**
  String get failedUpdateAttendance;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(String error);

  /// No description provided for @attendanceManagement.
  ///
  /// In en, this message translates to:
  /// **'Attendance Management'**
  String get attendanceManagement;

  /// No description provided for @viewReports.
  ///
  /// In en, this message translates to:
  /// **'View Reports'**
  String get viewReports;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @alreadyCheckedInSnack.
  ///
  /// In en, this message translates to:
  /// **'You are already checked in since {time}. Use the Log Out button below to check out.'**
  String alreadyCheckedInSnack(String time);

  /// No description provided for @readyToStart.
  ///
  /// In en, this message translates to:
  /// **'Ready to Start'**
  String get readyToStart;

  /// No description provided for @currentlyWorkingStatus.
  ///
  /// In en, this message translates to:
  /// **'Currently Working'**
  String get currentlyWorkingStatus;

  /// No description provided for @checkedInActive.
  ///
  /// In en, this message translates to:
  /// **'You are checked in and your work session is active'**
  String get checkedInActive;

  /// No description provided for @notCheckedInReady.
  ///
  /// In en, this message translates to:
  /// **'You are not checked in. Ready to start your work session.'**
  String get notCheckedInReady;

  /// No description provided for @startedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Started at: {time}'**
  String startedAtLabel(String time);

  /// No description provided for @idLabel.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String idLabel(String id);

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @notCheckedInUseLogin.
  ///
  /// In en, this message translates to:
  /// **'Not Checked In - Use Log In to start your shift'**
  String get notCheckedInUseLogin;

  /// No description provided for @checkedInSinceUseLogout.
  ///
  /// In en, this message translates to:
  /// **'Checked in since {time} - Use Log Out to end your shift'**
  String checkedInSinceUseLogout(String time);

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @endYourShift.
  ///
  /// In en, this message translates to:
  /// **'End Your Shift'**
  String get endYourShift;

  /// No description provided for @startYourShift.
  ///
  /// In en, this message translates to:
  /// **'Start Your Shift'**
  String get startYourShift;

  /// No description provided for @checkedInClickLogout.
  ///
  /// In en, this message translates to:
  /// **'You are currently checked in. Click Log Out to end your work session.'**
  String get checkedInClickLogout;

  /// No description provided for @notCheckedInClickLogin.
  ///
  /// In en, this message translates to:
  /// **'You are not checked in. Click Log In to start your work session.'**
  String get notCheckedInClickLogin;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Summary'**
  String get todaySummary;

  /// No description provided for @totalWorked.
  ///
  /// In en, this message translates to:
  /// **'Total Worked'**
  String get totalWorked;

  /// No description provided for @todayRecords.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Records'**
  String get todayRecords;

  /// No description provided for @noAttendanceToday.
  ///
  /// In en, this message translates to:
  /// **'No attendance records for today'**
  String get noAttendanceToday;

  /// No description provided for @checkInToStart.
  ///
  /// In en, this message translates to:
  /// **'Check in to start tracking your time'**
  String get checkInToStart;

  /// No description provided for @viewDetailedReports.
  ///
  /// In en, this message translates to:
  /// **'View Detailed Reports'**
  String get viewDetailedReports;

  /// No description provided for @activeSession.
  ///
  /// In en, this message translates to:
  /// **'Active Session'**
  String get activeSession;

  /// No description provided for @completedSession.
  ///
  /// In en, this message translates to:
  /// **'Completed Session'**
  String get completedSession;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get live;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @successCheckedOutShort.
  ///
  /// In en, this message translates to:
  /// **'Successfully checked out'**
  String get successCheckedOutShort;

  /// No description provided for @successCheckedInShort.
  ///
  /// In en, this message translates to:
  /// **'Successfully checked in'**
  String get successCheckedInShort;

  /// No description provided for @failedUpdateAttendanceShort.
  ///
  /// In en, this message translates to:
  /// **'Failed to update attendance'**
  String get failedUpdateAttendanceShort;

  /// No description provided for @attendanceReport.
  ///
  /// In en, this message translates to:
  /// **'Attendance Report'**
  String get attendanceReport;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @thisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// No description provided for @lastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get lastMonth;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get customRange;

  /// No description provided for @selectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// No description provided for @quickStatistics.
  ///
  /// In en, this message translates to:
  /// **'Quick Statistics'**
  String get quickStatistics;

  /// No description provided for @totalHours.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get totalHours;

  /// No description provided for @dailyAverage.
  ///
  /// In en, this message translates to:
  /// **'Daily Average'**
  String get dailyAverage;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On Time'**
  String get onTime;

  /// No description provided for @weeklyOverview.
  ///
  /// In en, this message translates to:
  /// **'Weekly Overview'**
  String get weeklyOverview;

  /// No description provided for @monthlyOverview.
  ///
  /// In en, this message translates to:
  /// **'Monthly Overview'**
  String get monthlyOverview;

  /// No description provided for @workingDays.
  ///
  /// In en, this message translates to:
  /// **'Working Days'**
  String get workingDays;

  /// No description provided for @avgDaily.
  ///
  /// In en, this message translates to:
  /// **'Avg Daily'**
  String get avgDaily;

  /// No description provided for @attendanceTrends.
  ///
  /// In en, this message translates to:
  /// **'Attendance Trends'**
  String get attendanceTrends;

  /// No description provided for @loadingTrends.
  ///
  /// In en, this message translates to:
  /// **'Loading trends...'**
  String get loadingTrends;

  /// No description provided for @totalHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get totalHoursLabel;

  /// No description provided for @onTimeRate.
  ///
  /// In en, this message translates to:
  /// **'On Time Rate'**
  String get onTimeRate;

  /// No description provided for @sessionsWithLocation.
  ///
  /// In en, this message translates to:
  /// **'Sessions with Location'**
  String get sessionsWithLocation;

  /// No description provided for @punctualityAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Punctuality Analysis'**
  String get punctualityAnalysis;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @earlyLeave.
  ///
  /// In en, this message translates to:
  /// **'Early Leave'**
  String get earlyLeave;

  /// No description provided for @locationTracking.
  ///
  /// In en, this message translates to:
  /// **'Location Tracking'**
  String get locationTracking;

  /// No description provided for @withLocation.
  ///
  /// In en, this message translates to:
  /// **'With Location'**
  String get withLocation;

  /// No description provided for @withoutLocation.
  ///
  /// In en, this message translates to:
  /// **'Without Location'**
  String get withoutLocation;

  /// No description provided for @noAttendanceRecords.
  ///
  /// In en, this message translates to:
  /// **'No attendance records found'**
  String get noAttendanceRecords;

  /// No description provided for @tryDifferentPeriod.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different period'**
  String get tryDifferentPeriod;

  /// No description provided for @exportReport.
  ///
  /// In en, this message translates to:
  /// **'Export Report'**
  String get exportReport;

  /// No description provided for @exportAsCsv.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get exportAsCsv;

  /// No description provided for @exportCsvSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Spreadsheet compatible format'**
  String get exportCsvSubtitle;

  /// No description provided for @exportAsPdf.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get exportAsPdf;

  /// No description provided for @exportPdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Print-ready format'**
  String get exportPdfSubtitle;

  /// No description provided for @exportAsJson.
  ///
  /// In en, this message translates to:
  /// **'Export as JSON'**
  String get exportAsJson;

  /// No description provided for @exportJsonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Developer-friendly format'**
  String get exportJsonSubtitle;

  /// No description provided for @exportingAs.
  ///
  /// In en, this message translates to:
  /// **'Exporting report as {format}...'**
  String exportingAs(String format);

  /// No description provided for @newExpense.
  ///
  /// In en, this message translates to:
  /// **'New Expense'**
  String get newExpense;

  /// No description provided for @expenseName.
  ///
  /// In en, this message translates to:
  /// **'Expense Name'**
  String get expenseName;

  /// No description provided for @expenseNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Business lunch with client'**
  String get expenseNameHint;

  /// No description provided for @pleaseEnterExpenseName.
  ///
  /// In en, this message translates to:
  /// **'Please enter expense name'**
  String get pleaseEnterExpenseName;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get pleaseEnterAmount;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionOptional;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Additional details about the expense'**
  String get descriptionHint;

  /// No description provided for @referenceOptional.
  ///
  /// In en, this message translates to:
  /// **'Reference (Optional)'**
  String get referenceOptional;

  /// No description provided for @referenceHint.
  ///
  /// In en, this message translates to:
  /// **'Invoice number or reference'**
  String get referenceHint;

  /// No description provided for @submitExpense.
  ///
  /// In en, this message translates to:
  /// **'Submit Expense'**
  String get submitExpense;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select a category'**
  String get selectCategory;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available. Please configure expense products in Odoo.'**
  String get noCategoriesAvailable;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @paymentMode.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode'**
  String get paymentMode;

  /// No description provided for @ownAccount.
  ///
  /// In en, this message translates to:
  /// **'Own Account'**
  String get ownAccount;

  /// No description provided for @companyAccount.
  ///
  /// In en, this message translates to:
  /// **'Company Account'**
  String get companyAccount;

  /// No description provided for @receiptOptional.
  ///
  /// In en, this message translates to:
  /// **'Receipt (Optional)'**
  String get receiptOptional;

  /// No description provided for @receiptAttached.
  ///
  /// In en, this message translates to:
  /// **'Receipt attached'**
  String get receiptAttached;

  /// No description provided for @tapToUploadReceipt.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload receipt'**
  String get tapToUploadReceipt;

  /// No description provided for @takePhotoOrSelect.
  ///
  /// In en, this message translates to:
  /// **'Take photo or select from gallery'**
  String get takePhotoOrSelect;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @removeReceipt.
  ///
  /// In en, this message translates to:
  /// **'Remove Receipt'**
  String get removeReceipt;

  /// No description provided for @failedToLoadData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data: {error}'**
  String failedToLoadData(String error);

  /// No description provided for @employeeInfoNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Employee information not available'**
  String get employeeInfoNotAvailable;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// No description provided for @expenseCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Expense created successfully!'**
  String get expenseCreatedSuccess;

  /// No description provided for @failedToCreateExpense.
  ///
  /// In en, this message translates to:
  /// **'Failed to create expense'**
  String get failedToCreateExpense;

  /// No description provided for @errorCreatingExpense.
  ///
  /// In en, this message translates to:
  /// **'Error creating expense: {error}'**
  String errorCreatingExpense(String error);

  /// No description provided for @locationServicesDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled. Please enable them to continue.'**
  String get locationServicesDisabled;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied. Please grant access from settings.'**
  String get locationPermissionDenied;

  /// No description provided for @couldNotSelectImage.
  ///
  /// In en, this message translates to:
  /// **'Could not select image.'**
  String get couldNotSelectImage;

  /// No description provided for @faceImageNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Face image not selected. Please try again.'**
  String get faceImageNotSelected;

  /// No description provided for @checkoutCompletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Check-out completed successfully.'**
  String get checkoutCompletedSuccess;

  /// No description provided for @checkinCompletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Check-in completed successfully.'**
  String get checkinCompletedSuccess;

  /// No description provided for @attendanceActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Attendance action failed.'**
  String get attendanceActionFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedError(String error);

  /// No description provided for @errorPickingImage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image: {error}'**
  String errorPickingImage(String error);

  /// No description provided for @waitingForLocation.
  ///
  /// In en, this message translates to:
  /// **'Waiting for location...'**
  String get waitingForLocation;

  /// No description provided for @smartAttendance.
  ///
  /// In en, this message translates to:
  /// **'Smart Attendance'**
  String get smartAttendance;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @whatWouldYouLikeToDo.
  ///
  /// In en, this message translates to:
  /// **'What would you like to do today?'**
  String get whatWouldYouLikeToDo;

  /// No description provided for @checkInCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check In / Check Out'**
  String get checkInCheckOut;

  /// No description provided for @currentlyCheckedInTapOut.
  ///
  /// In en, this message translates to:
  /// **'Currently checked in - Tap to check out'**
  String get currentlyCheckedInTapOut;

  /// No description provided for @readyToStartTapIn.
  ///
  /// In en, this message translates to:
  /// **'Ready to start - Tap to check in'**
  String get readyToStartTapIn;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get currentLocation;

  /// No description provided for @latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get latitude;

  /// No description provided for @longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get longitude;

  /// No description provided for @odooServer.
  ///
  /// In en, this message translates to:
  /// **'Odoo Server'**
  String get odooServer;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @failedToLoadPayslips.
  ///
  /// In en, this message translates to:
  /// **'Failed to load payslips: {error}'**
  String failedToLoadPayslips(String error);

  /// No description provided for @failedToLoadEmployeeData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load employee data: {error}'**
  String failedToLoadEmployeeData(String error);

  /// No description provided for @contractsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Contracts Not Available'**
  String get contractsNotAvailable;

  /// No description provided for @errorLoadingEmployeeData.
  ///
  /// In en, this message translates to:
  /// **'Error loading employee data: {error}'**
  String errorLoadingEmployeeData(String error);

  /// No description provided for @leaveRequestStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'{leaveType} request status updated to {status}'**
  String leaveRequestStatusUpdated(String leaveType, String status);

  /// No description provided for @payslips.
  ///
  /// In en, this message translates to:
  /// **'Payslips'**
  String get payslips;

  /// No description provided for @errorLoadingPayslips.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Payslips'**
  String get errorLoadingPayslips;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @employeePayslipOverview.
  ///
  /// In en, this message translates to:
  /// **'Employee Payslip Overview'**
  String get employeePayslipOverview;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noPayslipsFound.
  ///
  /// In en, this message translates to:
  /// **'No payslips found for this employee'**
  String get noPayslipsFound;

  /// No description provided for @payslipsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Payslips will appear here once they are generated for this employee'**
  String get payslipsWillAppear;

  /// No description provided for @noPayslipsMatchingFilter.
  ///
  /// In en, this message translates to:
  /// **'No payslips found matching your filter'**
  String get noPayslipsMatchingFilter;

  /// No description provided for @tryAdjustingFilterPayslip.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filter or contact HR to generate a new payslip.'**
  String get tryAdjustingFilterPayslip;

  /// No description provided for @periodLabel.
  ///
  /// In en, this message translates to:
  /// **'Period: {period}'**
  String periodLabel(String period);

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusLabel(String status);

  /// No description provided for @netWage.
  ///
  /// In en, this message translates to:
  /// **'Net Wage: {amount}'**
  String netWage(String amount);

  /// No description provided for @employeeLabel.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeLabel;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @basicWage.
  ///
  /// In en, this message translates to:
  /// **'Basic Wage'**
  String get basicWage;

  /// No description provided for @grossWage.
  ///
  /// In en, this message translates to:
  /// **'Gross Wage'**
  String get grossWage;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @payslipActionsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Payslip actions coming soon!'**
  String get payslipActionsComingSoon;

  /// No description provided for @createPayslipComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Create payslip functionality coming soon!'**
  String get createPayslipComingSoon;

  /// No description provided for @editPayslipComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Edit payslip functionality coming soon!'**
  String get editPayslipComingSoon;

  /// No description provided for @contractsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get contractsTitle;

  /// No description provided for @employeeContractOverview.
  ///
  /// In en, this message translates to:
  /// **'Employee Contract Overview'**
  String get employeeContractOverview;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @noContractsFound.
  ///
  /// In en, this message translates to:
  /// **'No contracts found for this employee'**
  String get noContractsFound;

  /// No description provided for @contractsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Contracts will appear here once they are created for this employee'**
  String get contractsWillAppear;

  /// No description provided for @createContract.
  ///
  /// In en, this message translates to:
  /// **'Create Contract'**
  String get createContract;

  /// No description provided for @noContractsMatchingFilter.
  ///
  /// In en, this message translates to:
  /// **'No contracts found matching your filter'**
  String get noContractsMatchingFilter;

  /// No description provided for @tryAdjustingFilterContract.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filter or contact HR to create a new contract.'**
  String get tryAdjustingFilterContract;

  /// No description provided for @unknownEmployee.
  ///
  /// In en, this message translates to:
  /// **'Unknown Employee'**
  String get unknownEmployee;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @employeeInformation.
  ///
  /// In en, this message translates to:
  /// **'Employee Information'**
  String get employeeInformation;

  /// No description provided for @contractPeriod.
  ///
  /// In en, this message translates to:
  /// **'Contract Period'**
  String get contractPeriod;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @durationDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String durationDays(int count);

  /// No description provided for @salaryDetails.
  ///
  /// In en, this message translates to:
  /// **'Salary Details'**
  String get salaryDetails;

  /// No description provided for @wage.
  ///
  /// In en, this message translates to:
  /// **'Wage'**
  String get wage;

  /// No description provided for @contractType.
  ///
  /// In en, this message translates to:
  /// **'Contract Type'**
  String get contractType;

  /// No description provided for @fullTime.
  ///
  /// In en, this message translates to:
  /// **'Full Time'**
  String get fullTime;

  /// No description provided for @systemInformation.
  ///
  /// In en, this message translates to:
  /// **'System Information'**
  String get systemInformation;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteContract.
  ///
  /// In en, this message translates to:
  /// **'Delete Contract'**
  String get deleteContract;

  /// No description provided for @deleteContractConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteContractConfirm(String name);

  /// No description provided for @createContractComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Create contract functionality coming soon!'**
  String get createContractComingSoon;

  /// No description provided for @editContractComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Edit contract functionality coming soon!'**
  String get editContractComingSoon;

  /// No description provided for @deleteContractComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Delete contract functionality coming soon!'**
  String get deleteContractComingSoon;

  /// No description provided for @myExpenses.
  ///
  /// In en, this message translates to:
  /// **'My Expenses'**
  String get myExpenses;

  /// No description provided for @addNewExpense.
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get addNewExpense;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @noExpensesFound.
  ///
  /// In en, this message translates to:
  /// **'No expenses found'**
  String get noExpensesFound;

  /// No description provided for @tapNewExpenseToCreate.
  ///
  /// In en, this message translates to:
  /// **'Tap the \"New Expense\" button above to create your first expense request'**
  String get tapNewExpenseToCreate;

  /// No description provided for @expenseDetails.
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetails;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @taxAmount.
  ///
  /// In en, this message translates to:
  /// **'Tax Amount'**
  String get taxAmount;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @employeeId.
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employeeId;

  /// No description provided for @paidBy.
  ///
  /// In en, this message translates to:
  /// **'Paid By'**
  String get paidBy;

  /// No description provided for @errorLoadingExpenses.
  ///
  /// In en, this message translates to:
  /// **'Error loading expenses'**
  String get errorLoadingExpenses;

  /// No description provided for @failedToLoadExpenses.
  ///
  /// In en, this message translates to:
  /// **'Failed to load expenses'**
  String get failedToLoadExpenses;

  /// No description provided for @errorProcessingExpenses.
  ///
  /// In en, this message translates to:
  /// **'Error processing expenses: {error}'**
  String errorProcessingExpenses(String error);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
