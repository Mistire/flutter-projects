class Job {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;

  Job(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.time, this.req);

  static List<Job> generateJobs() {
    return [
      Job('Google LLC', 'assets/images/google_logo.png', false,
          'Software Engineer', 'Mountain View, CA', 'Full-time', [
        'BSc in Computer Science or related field',
        '3+ years of experience in software development',
        'Proficiency in Dart and Flutter for cross-platform development',
        'Strong understanding of algorithms and data structures',
        'Excellent problem-solving skills'
      ]),
      Job('LinkedIn Corp.', 'assets/images/linkedin_logo.png', true,
          'Data Scientist', 'San Francisco, CA', 'Full-time', [
        'MSc in Data Science, Statistics, or related field',
        '2+ years of hands-on experience with data analysis',
        'Proficiency in Python, R, and SQL',
        'Experience with machine learning models and frameworks',
        'Strong communication skills to present data insights'
      ]),
      Job('Airbnb Inc.', 'assets/images/airbnb_logo.png', false,
          'Product Manager', 'San Francisco, CA', 'Full-time', [
        'BSc in Business Administration, Marketing, or related field',
        '5+ years of experience in product management',
        'Proven track record of launching successful products',
        'Strong leadership and team collaboration skills',
        'Ability to conduct market research and user analysis'
      ]),
      Job('Apple Inc.', 'assets/images/apple_logo.png', false, 'iOS Developer',
          'Cupertino, CA', 'Full-time', [
        'BSc in Computer Science or related field',
        '3+ years of experience in iOS development',
        'Strong proficiency in Swift and Objective-C',
        'Experience with iOS SDK, UIKit, and Core Data',
        'Understanding of RESTful APIs and third-party libraries'
      ]),
      Job('Amazon (AWS)', 'assets/images/aws_logo.png', true,
          'Cloud Solutions Architect', 'Seattle, WA', 'Full-time', [
        'BSc in Computer Science or related field',
        '5+ years of experience in cloud architecture',
        'Deep knowledge of AWS services and architecture best practices',
        'Strong problem-solving and communication skills',
        'Experience in infrastructure automation and DevOps practices'
      ]),
      Job('Microsoft Corp', 'assets/images/microsoft_logo.png', false,
          'Software Engineer', 'Redmond, WA', 'Full-time', [
        'BSc in Computer Science or related field',
        '2+ years of experience in software development',
        'Proficiency in C#, Java, or C++',
        'Experience with cloud computing and distributed systems',
        'Excellent debugging and problem-solving skills'
      ]),
      Job('Meta (Facebook)', 'assets/images/meta_logo.png', false,
          'Frontend Engineer', 'Menlo Park, CA', 'Full-time', [
        'BSc in Computer Science or related field',
        '2+ years of experience in frontend development',
        'Proficiency in JavaScript, React, and CSS',
        'Experience with RESTful APIs and modern frontend tools',
        'Understanding of web performance optimization techniques'
      ]),
      Job('Netflix Inc.', 'assets/images/netflix_logo.png', true,
          'Software Engineer - Backend', 'Los Gatos, CA', 'Full-time', [
        'BSc in Computer Science or related field',
        '3+ years of experience in backend development',
        'Strong proficiency in Python, Java, or Go',
        'Experience with large-scale distributed systems',
        'Solid understanding of databases and microservices architecture'
      ]),
      Job('Spotify Technology', 'assets/images/spotify_logo.png', false,
          'Data Engineer', 'Stockholm, Sweden', 'Full-time', [
        'BSc in Computer Science, Engineering, or related field',
        '2+ years of experience in data engineering',
        'Proficiency in Python, SQL, and data pipelines',
        'Experience with big data technologies (Hadoop, Spark)',
        'Strong understanding of data modeling and ETL processes'
      ]),
      Job('Tesla, Inc.', 'assets/images/tesla_logo.png', false,
          'Machine Learning Engineer', 'Palo Alto, CA', 'Full-time', [
        'BSc in Computer Science, Electrical Engineering, or related field',
        '3+ years of experience in machine learning and AI',
        'Proficiency in Python, TensorFlow, or PyTorch',
        'Experience in building machine learning models for real-world applications',
        'Strong mathematical and statistical skills'
      ]),
    ];
  }
}
