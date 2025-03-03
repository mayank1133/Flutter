import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 20),
                  _buildDecorativeSeparator(),
                  const SizedBox(height: 20),
                  _buildTeamCard(),
                  const SizedBox(height: 20),
                  _buildASWDCCard(),
                  const SizedBox(height: 20),
                  _buildTitleSection("Contact Us"),
                  _buildContactCard(
                    email: "23010101234@darshan.ac.in",
                    phone: "+91-9727747317",
                    website: "https://www.darshan.ac.in",
                  ),
                  const SizedBox(height: 30),
                  _buildBottomButtons(), // Now scrolls with the page
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Title Card**
  Widget _buildTitleCard() {
    return Card(
      elevation: 12,
      shadowColor: Colors.pink.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          children: [
            Text(
              'About Us',
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Get to know us better!',
              style: GoogleFonts.lora(
                fontSize: 16,
                color: Colors.pink.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDecorativeSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        '· ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ·',
        style: GoogleFonts.lora(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade500,
          letterSpacing: 4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// **Reusable Title Section**
  Widget _buildTitleSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// **Team Card**
  Widget _buildTeamCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTitleSection("Meet Our Team"),
            _buildInfoTile("Developed by", "Mayank Sakariya (23010101234)"),
            _buildInfoTile("Mentored by", "Prof. Mehul Bhundiya\n(Computer Engineering Department),\nSchool of Computer Science"),
            _buildInfoTile("Explored by", "ASWDC, School Of Computer Science,\nDarshan University"),
            _buildInfoTile("Eulogized by", "Darshan University, Rajkot, Gujarat - INDIA"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String detail) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink.shade600),
      ),
      subtitle: Text(
        detail,
        style: GoogleFonts.lora(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  /// **ASWDC Card**
  Widget _buildASWDCCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTitleSection("About ASWDC"),
            _buildText(
              "ASWDC (Application, Software, and Website Development Center) at Darshan University is run by students and staff of the School of Computer Science.\n\n"
                  "The primary goal of ASWDC is to bridge the gap between university curriculum and industry demands. Students gain hands-on experience with cutting-edge technologies, develop real-world applications, and experience a professional environment under the guidance of industry experts and faculty members.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.lora(fontSize: 16, color: Colors.black87),
      textAlign: TextAlign.justify,
    );
  }

  /// **Contact Card**
  Widget _buildContactCard({required String email, required String phone, required String website}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _buildLinkTile(Icons.email, email, 'mailto:$email'),
          _buildLinkTile(Icons.phone, phone, 'tel:$phone'),
          _buildLinkTile(Icons.public, website, website),
        ],
      ),
    );
  }

  Widget _buildLinkTile(IconData icon, String text, String url) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink.shade600),
      title: Text(
        text,
        style: GoogleFonts.lora(fontSize: 16, color: Colors.blue),
      ),
      onTap: () => _launchURL(url),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// **Bottom Buttons (Now Scrollable)**
  Widget _buildBottomButtons() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 250),
        child: Column(
          children: [
            _buildGradientButton("Share App", Icons.share),
            _buildGradientButton("More Apps", Icons.apps),
            _buildGradientButton("Rate Us", Icons.star_rate),
            _buildGradientButton("Like us on Facebook", Icons.thumb_up),
            _buildGradientButton("Check for Update", Icons.system_update),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
        label: Text(text, style: GoogleFonts.lora(fontSize: 16, color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink.shade500,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
