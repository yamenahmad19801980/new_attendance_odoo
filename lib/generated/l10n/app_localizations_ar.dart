// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق الموارد البشرية';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get secureAccess => 'الوصول الآمن';

  @override
  String get connectWorkspace => 'اربط بمساحة عمل BLUE HR';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get usernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صالحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 4 أحرف على الأقل';

  @override
  String welcomeName(String name) {
    return 'مرحباً $name!';
  }

  @override
  String get authFailed => 'فشل المصادقة';

  @override
  String connectionError(String error) {
    return 'خطأ في الاتصال: $error';
  }

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get logoutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get loggedOutSuccess => 'تم تسجيل الخروج بنجاح';

  @override
  String logoutError(String error) {
    return 'خطأ أثناء تسجيل الخروج: $error';
  }

  @override
  String get hrDashboard => 'لوحة الموارد البشرية';

  @override
  String get employee => 'موظف';

  @override
  String get noEmail => 'لا يوجد بريد إلكتروني';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodAfternoon => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get goodNight => 'ليلة سعيدة';

  @override
  String get monday => 'الإثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String greetingHappyDay(String greeting, String day) {
    return '$greeting! $day سعيد';
  }

  @override
  String get welcomeBackDashboard => 'مرحباً بعودتك إلى لوحة الموارد البشرية';

  @override
  String currentTime(String time) {
    return 'الوقت الحالي: $time';
  }

  @override
  String get registerAttendance => 'تسجيل الحضور';

  @override
  String get currentlyWorking => 'يعمل حالياً';

  @override
  String get notCheckedIn => 'لم يسجل الحضور';

  @override
  String get today => 'اليوم';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get currentSession => 'الجلسة الحالية';

  @override
  String startedAt(String time) {
    return 'بدأ في $time';
  }

  @override
  String get checkInFace => 'تسجيل الحضور (الوجه)';

  @override
  String get checkOutFace => 'تسجيل الخروج (الوجه)';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get whatDoYouNeed => 'ماذا تحتاج؟';

  @override
  String get contracts => 'العقود';

  @override
  String get payslip => 'قسيمة الراتب';

  @override
  String get expenses => 'المصروفات';

  @override
  String get attendance => 'الحضور';

  @override
  String get successCheckedOut => 'تم تسجيل الخروج بنجاح';

  @override
  String get successCheckedIn => 'تم تسجيل الحضور بنجاح';

  @override
  String get failedUpdateAttendance =>
      'فشل تحديث الحضور. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String errorGeneric(String error) {
    return 'خطأ: $error';
  }

  @override
  String get attendanceManagement => 'إدارة الحضور';

  @override
  String get viewReports => 'عرض التقارير';

  @override
  String get dismiss => 'تجاهل';

  @override
  String alreadyCheckedInSnack(String time) {
    return 'أنت مسجل الحضور منذ $time. استخدم زر تسجيل الخروج أدناه.';
  }

  @override
  String get readyToStart => 'مستعد للبدء';

  @override
  String get currentlyWorkingStatus => 'يعمل حالياً';

  @override
  String get checkedInActive => 'أنت مسجل الحضور وجلسة العمل نشطة';

  @override
  String get notCheckedInReady => 'لم تسجل الحضور. مستعد لبدء جلسة العمل.';

  @override
  String startedAtLabel(String time) {
    return 'بدأ في: $time';
  }

  @override
  String idLabel(String id) {
    return 'المعرف: $id';
  }

  @override
  String get na => 'غير متاح';

  @override
  String get notCheckedInUseLogin =>
      'لم يسجل الحضور - استخدم تسجيل الدخول لبدء الدوام';

  @override
  String checkedInSinceUseLogout(String time) {
    return 'مسجل الحضور منذ $time - استخدم تسجيل الخروج لإنهاء الدوام';
  }

  @override
  String get records => 'السجلات';

  @override
  String get endYourShift => 'إنهاء الدوام';

  @override
  String get startYourShift => 'بدء الدوام';

  @override
  String get checkedInClickLogout =>
      'لقد قمت بتسجيل الحضور. انقر على تسجيل الخروج لإنهاء جلسة العمل.';

  @override
  String get notCheckedInClickLogin =>
      'لم تسجل الحضور. انقر على تسجيل الدخول لبدء جلسة العمل.';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get todaySummary => 'ملخص اليوم';

  @override
  String get totalWorked => 'إجمالي العمل';

  @override
  String get todayRecords => 'سجلات اليوم';

  @override
  String get noAttendanceToday => 'لا توجد سجلات حضور لليوم';

  @override
  String get checkInToStart => 'سجل الحضور لبدء تتبع وقتك';

  @override
  String get viewDetailedReports => 'عرض التقارير التفصيلية';

  @override
  String get activeSession => 'جلسة نشطة';

  @override
  String get completedSession => 'جلسة مكتملة';

  @override
  String get live => 'مباشر';

  @override
  String get checkIn => 'تسجيل الحضور';

  @override
  String get checkOut => 'تسجيل الخروج';

  @override
  String get duration => 'المدة';

  @override
  String get successCheckedOutShort => 'تم تسجيل الخروج بنجاح';

  @override
  String get successCheckedInShort => 'تم تسجيل الحضور بنجاح';

  @override
  String get failedUpdateAttendanceShort => 'فشل تحديث الحضور';

  @override
  String get attendanceReport => 'تقرير الحضور';

  @override
  String get summary => 'ملخص';

  @override
  String get analytics => 'التحليلات';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get lastMonth => 'الشهر الماضي';

  @override
  String get customRange => 'نطاق مخصص';

  @override
  String get selectPeriod => 'اختر الفترة';

  @override
  String get quickStatistics => 'إحصائيات سريعة';

  @override
  String get totalHours => 'إجمالي الساعات';

  @override
  String get dailyAverage => 'المتوسط اليومي';

  @override
  String get sessions => 'الجلسات';

  @override
  String get onTime => 'في الموعد';

  @override
  String get weeklyOverview => 'نظرة أسبوعية';

  @override
  String get monthlyOverview => 'نظرة شهرية';

  @override
  String get workingDays => 'أيام العمل';

  @override
  String get avgDaily => 'المتوسط اليومي';

  @override
  String get attendanceTrends => 'اتجاهات الحضور';

  @override
  String get loadingTrends => 'جاري تحميل الاتجاهات...';

  @override
  String get totalHoursLabel => 'إجمالي الساعات';

  @override
  String get onTimeRate => 'نسبة الحضور في الموعد';

  @override
  String get sessionsWithLocation => 'جلسات مع الموقع';

  @override
  String get punctualityAnalysis => 'تحليل الالتزام بالوقت';

  @override
  String get late => 'متأخر';

  @override
  String get earlyLeave => 'مغادرة مبكرة';

  @override
  String get locationTracking => 'تتبع الموقع';

  @override
  String get withLocation => 'مع الموقع';

  @override
  String get withoutLocation => 'بدون موقع';

  @override
  String get noAttendanceRecords => 'لم يتم العثور على سجلات حضور';

  @override
  String get tryDifferentPeriod => 'حاول اختيار فترة مختلفة';

  @override
  String get exportReport => 'تصدير التقرير';

  @override
  String get exportAsCsv => 'تصدير كـ CSV';

  @override
  String get exportCsvSubtitle => 'تنسيق متوافق مع جداول البيانات';

  @override
  String get exportAsPdf => 'تصدير كـ PDF';

  @override
  String get exportPdfSubtitle => 'تنسيق جاهز للطباعة';

  @override
  String get exportAsJson => 'تصدير كـ JSON';

  @override
  String get exportJsonSubtitle => 'تنسيق للمطورين';

  @override
  String exportingAs(String format) {
    return 'جاري تصدير التقرير كـ $format...';
  }

  @override
  String get newExpense => 'مصروف جديد';

  @override
  String get expenseName => 'اسم المصروف';

  @override
  String get expenseNameHint => 'مثال: غداء عمل مع العميل';

  @override
  String get pleaseEnterExpenseName => 'الرجاء إدخال اسم المصروف';

  @override
  String get amount => 'المبلغ';

  @override
  String get pleaseEnterAmount => 'الرجاء إدخال المبلغ';

  @override
  String get pleaseEnterValidAmount => 'الرجاء إدخال مبلغ صالح';

  @override
  String get descriptionOptional => 'الوصف (اختياري)';

  @override
  String get descriptionHint => 'تفاصيل إضافية عن المصروف';

  @override
  String get referenceOptional => 'المرجع (اختياري)';

  @override
  String get referenceHint => 'رقم الفاتورة أو المرجع';

  @override
  String get submitExpense => 'إرسال المصروف';

  @override
  String get category => 'الفئة';

  @override
  String get selectCategory => 'اختر فئة';

  @override
  String get unknown => 'غير معروف';

  @override
  String get noCategoriesAvailable =>
      'لا توجد فئات. يرجى تكوين منتجات المصروفات في أودو.';

  @override
  String get date => 'التاريخ';

  @override
  String get paymentMode => 'طريقة الدفع';

  @override
  String get ownAccount => 'حسابي';

  @override
  String get companyAccount => 'حساب الشركة';

  @override
  String get receiptOptional => 'الإيصال (اختياري)';

  @override
  String get receiptAttached => 'تم إرفاق الإيصال';

  @override
  String get tapToUploadReceipt => 'انقر لرفع الإيصال';

  @override
  String get takePhotoOrSelect => 'التقط صورة أو اختر من المعرض';

  @override
  String get takePhoto => 'التقط صورة';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get removeReceipt => 'إزالة الإيصال';

  @override
  String failedToLoadData(String error) {
    return 'فشل تحميل البيانات: $error';
  }

  @override
  String get employeeInfoNotAvailable => 'معلومات الموظف غير متوفرة';

  @override
  String get pleaseSelectCategory => 'الرجاء اختيار فئة';

  @override
  String get expenseCreatedSuccess => 'تم إنشاء المصروف بنجاح!';

  @override
  String get failedToCreateExpense => 'فشل إنشاء المصروف';

  @override
  String errorCreatingExpense(String error) {
    return 'خطأ في إنشاء المصروف: $error';
  }

  @override
  String get locationServicesDisabled =>
      'خدمات الموقع معطلة. يرجى تفعيلها للمتابعة.';

  @override
  String get locationPermissionDenied =>
      'تم رفض إذن الموقع. يرجى منح الوصول من الإعدادات.';

  @override
  String get couldNotSelectImage => 'تعذر اختيار الصورة.';

  @override
  String get faceImageNotSelected =>
      'لم يتم اختيار صورة الوجه. يرجى المحاولة مرة أخرى.';

  @override
  String get checkoutCompletedSuccess => 'تم تسجيل الخروج بنجاح.';

  @override
  String get checkinCompletedSuccess => 'تم تسجيل الحضور بنجاح.';

  @override
  String get attendanceActionFailed => 'فشل إجراء الحضور.';

  @override
  String unexpectedError(String error) {
    return 'خطأ غير متوقع: $error';
  }

  @override
  String errorPickingImage(String error) {
    return 'خطأ في اختيار الصورة: $error';
  }

  @override
  String get waitingForLocation => 'في انتظار الموقع...';

  @override
  String get smartAttendance => 'الحضور الذكي';

  @override
  String get welcome => 'مرحباً!';

  @override
  String get whatWouldYouLikeToDo => 'ماذا تريد أن تفعل اليوم؟';

  @override
  String get checkInCheckOut => 'تسجيل الحضور / الخروج';

  @override
  String get currentlyCheckedInTapOut => 'مسجل الحضور - انقر لتسجيل الخروج';

  @override
  String get readyToStartTapIn => 'مستعد للبدء - انقر لتسجيل الحضور';

  @override
  String get currentLocation => 'الموقع الحالي';

  @override
  String get latitude => 'خط العرض';

  @override
  String get longitude => 'خط الطول';

  @override
  String get odooServer => 'خادم أودو';

  @override
  String get view => 'عرض';

  @override
  String failedToLoadPayslips(String error) {
    return 'فشل تحميل قسائم الراتب: $error';
  }

  @override
  String failedToLoadEmployeeData(String error) {
    return 'فشل تحميل بيانات الموظف: $error';
  }

  @override
  String get contractsNotAvailable => 'العقود غير متوفرة';

  @override
  String errorLoadingEmployeeData(String error) {
    return 'خطأ في تحميل بيانات الموظف: $error';
  }

  @override
  String leaveRequestStatusUpdated(String leaveType, String status) {
    return 'تم تحديث حالة طلب $leaveType إلى $status';
  }

  @override
  String get payslips => 'قسائم الراتب';

  @override
  String get errorLoadingPayslips => 'خطأ في تحميل قسائم الراتب';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get employeePayslipOverview => 'نظرة على قسائم راتب الموظف';

  @override
  String get total => 'الإجمالي';

  @override
  String get paid => 'مدفوع';

  @override
  String get verified => 'موثق';

  @override
  String get draft => 'مسودة';

  @override
  String get all => 'الكل';

  @override
  String get noPayslipsFound => 'لم يتم العثور على قسائم راتب لهذا الموظف';

  @override
  String get payslipsWillAppear =>
      'ستظهر قسائم الراتب هنا عند إنشائها لهذا الموظف';

  @override
  String get noPayslipsMatchingFilter =>
      'لم يتم العثور على قسائم راتب تطابق الفلتر';

  @override
  String get tryAdjustingFilterPayslip =>
      'حاول تعديل الفلتر أو تواصل مع الموارد البشرية.';

  @override
  String periodLabel(String period) {
    return 'الفترة: $period';
  }

  @override
  String statusLabel(String status) {
    return 'الحالة: $status';
  }

  @override
  String netWage(String amount) {
    return 'صافي الراتب: $amount';
  }

  @override
  String get employeeLabel => 'الموظف';

  @override
  String get dateRange => 'نطاق التاريخ';

  @override
  String get basicWage => 'الراتب الأساسي';

  @override
  String get grossWage => 'إجمالي الراتب';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get lastUpdated => 'آخر تحديث';

  @override
  String get edit => 'تعديل';

  @override
  String get actions => 'إجراءات';

  @override
  String get payslipActionsComingSoon => 'إجراءات قسيمة الراتب قريباً!';

  @override
  String get createPayslipComingSoon => 'وظيفة إنشاء قسيمة الراتب قريباً!';

  @override
  String get editPayslipComingSoon => 'وظيفة تعديل قسيمة الراتب قريباً!';

  @override
  String get contractsTitle => 'العقود';

  @override
  String get employeeContractOverview => 'نظرة على عقود الموظف';

  @override
  String get active => 'نشط';

  @override
  String get expired => 'منتهي';

  @override
  String get goBack => 'رجوع';

  @override
  String get noContractsFound => 'لم يتم العثور على عقود لهذا الموظف';

  @override
  String get contractsWillAppear => 'ستظهر العقود هنا عند إنشائها لهذا الموظف';

  @override
  String get createContract => 'إنشاء عقد';

  @override
  String get noContractsMatchingFilter => 'لم يتم العثور على عقود تطابق الفلتر';

  @override
  String get tryAdjustingFilterContract =>
      'حاول تعديل الفلتر أو تواصل مع الموارد البشرية.';

  @override
  String get unknownEmployee => 'موظف غير معروف';

  @override
  String get closed => 'مغلق';

  @override
  String get cancelled => 'ملغى';

  @override
  String get employeeInformation => 'معلومات الموظف';

  @override
  String get contractPeriod => 'فترة العقد';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String get ongoing => 'جاري';

  @override
  String durationDays(int count) {
    return 'عدد الأيام: $count';
  }

  @override
  String get salaryDetails => 'تفاصيل الراتب';

  @override
  String get wage => 'الراتب';

  @override
  String get contractType => 'نوع العقد';

  @override
  String get fullTime => 'دوام كامل';

  @override
  String get systemInformation => 'معلومات النظام';

  @override
  String get delete => 'حذف';

  @override
  String get deleteContract => 'حذف العقد';

  @override
  String deleteContractConfirm(String name) {
    return 'هل أنت متأكد أنك تريد حذف \"$name\"؟';
  }

  @override
  String get createContractComingSoon => 'وظيفة إنشاء العقد قريباً!';

  @override
  String get editContractComingSoon => 'وظيفة تعديل العقد قريباً!';

  @override
  String get deleteContractComingSoon => 'وظيفة حذف العقد قريباً!';

  @override
  String get myExpenses => 'مصروفاتي';

  @override
  String get addNewExpense => 'إضافة مصروف جديد';

  @override
  String get refresh => 'تحديث';

  @override
  String get noExpensesFound => 'لم يتم العثور على مصروفات';

  @override
  String get tapNewExpenseToCreate =>
      'انقر \"مصروف جديد\" أعلاه لإنشاء أول طلب مصروف';

  @override
  String get expenseDetails => 'تفاصيل المصروف';

  @override
  String get description => 'الوصف';

  @override
  String get taxAmount => 'مبلغ الضريبة';

  @override
  String get notes => 'ملاحظات';

  @override
  String get employeeId => 'معرف الموظف';

  @override
  String get paidBy => 'مدفوع من قبل';

  @override
  String get errorLoadingExpenses => 'خطأ في تحميل المصروفات';

  @override
  String get failedToLoadExpenses => 'فشل تحميل المصروفات';

  @override
  String errorProcessingExpenses(String error) {
    return 'خطأ في معالجة المصروفات: $error';
  }

  @override
  String get language => 'اللغة';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';
}
