class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;

  Job(this.company, this.logoUrl, this.isMark, this.title, this.location, this.time, this.req);

  static List<Job> generateJobs() {
    return [
      Job(
        'Google LLC',
        'assets/images/google_logo.png',
        false,
        'Software Engineer',
        'Mountain View, CA',
        'Full-time',
        ['BSc in Computer Science', '3+ years of experience', 'Proficiency in Dart']
      ),
      Job(
        'LinkedIn comp.',
        'assets/images/linkedin_logo.png',
        true,
        'Data Scientist',
        'San Francisco, CA',
        'Full-time',
        ['MSc in Data Science', '2+ years of experience', 'Experience with Python and R']
      ),
      Job(
        'Airbnb inc.',
        'assets/images/airbnb_logo.png',
        false,
        'Product Manager',
        'San Francisco, CA',
        'Full-time',
        ['BSc in Business Administration', '5+ years of experience', 'Strong leadership skills']
      ),
    ];
  }
}