import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatelessWidget {
  const HelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              tileColor: Colors.white,
              title: Text(
                'Stress',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelpTileWidget(
                      label: 'Stress Management Techniques for Students',
                      link:
                          'https://www.verywellmind.com/top-school-stress-relievers-for-students-3145179',
                    ),
                    HelpTileWidget(
                      label: 'Best ways to manage Stress for Students',
                      link:
                          'https://www.prospects.ac.uk/applying-for-university/university-life/5-ways-to-manage-student-stress',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            ListTile(
              visualDensity: VisualDensity.compact,
              tileColor: Colors.white,
              title: Text(
                'Medical',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelpTileWidget(
                      label: 'Health and Nutrition Tips',
                      link: 'https://www.healthline.com/nutrition/27-health-and-nutrition-tips',
                    ),
                    HelpTileWidget(
                      label: 'Health and Wellness Tips for Students',
                      link:
                          'https://wellnesscenter.camden.rutgers.edu/101-health-and-wellness-tips-for-college-students',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            ListTile(
              visualDensity: VisualDensity.compact,
              tileColor: Colors.white,
              title: Text(
                'Lack of Confidence',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelpTileWidget(
                      label: 'How to build self-confidence for Students',
                      link: 'https://www.readandspell.com/how-to-build-self-confidence-in-students',
                    ),
                    HelpTileWidget(
                      label: 'How To Boost Self-Confidence in Students',
                      link:
                          'https://www.theasianschool.net/blog/how-to-boost-self-confidence-and-self-esteem-in-students',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpTileWidget extends StatelessWidget {
  final String? label;
  final String? link;
  final bool isLast;

  const HelpTileWidget({
    Key? key,
    this.label,
    this.link,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url = Uri.parse(link!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? 'Label',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            link ?? 'Link',
            style: TextStyle(
              color: Colors.indigo,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (!isLast) SizedBox(height: 16),
        ],
      ),
    );
  }
}
