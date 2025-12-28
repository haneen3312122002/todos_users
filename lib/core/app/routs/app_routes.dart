class AppRoutes {
  static const String clientHome = '/client/home';
  static const String freelanceHome = '/freelancer/home';
  static const String adminHome = '/admin/home';
  static const jobsByCategory = '/jobsByCategory';

  static const String loading = '/loading';
  static const String login = '/login';
  static const String verifyEmail = '/verify-email';
  static const String register = '/register';
  static const String resetPassword = '/reset-pass';
  static const String jobDetails = '/job-details';
  static const String proposalDetails = '/proposal-details';

  static const String clientJobs = '/client/jobs';
  static const String clientChats = '/client/chats';
  static const String clientProfile = '/client/profile';
  static const String clientProposals = '/client/proposals';

  static const String freelancerJobs = '/freelancer/jobs';
  static const String freelancerProposals = '/freelancer/proposals';
  static const String freelancerChats = '/freelancer/chats';
  static const String freelancerProfile = '/freelancer/profile';

  // ✅ جديد
  static const String clientNotifications = '/client/notifications';
  static const String freelancerNotifications = '/freelancer/notifications';

  static const String adminDashboard = '/admin/dashboard';

  static const String userSectionDetails = '/user-section-details';
  static const String settings = '/settings';
  static const String changePassword = '/change-password';
  static const String projectDetails = '/project-details';
  static const chatDetails = '/chat';
  static String chatDetailsPath(String id) => '$chatDetails/$id';
}
