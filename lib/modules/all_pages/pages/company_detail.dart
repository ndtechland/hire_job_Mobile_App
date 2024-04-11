import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/view_jobs.dart';
import 'package:hirejobindia/widget/elevated_button.dart';
import 'package:hirejobindia/widget/navbar.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri urlfb = Uri.parse('https://www.facebook.com/HireJobsIndia/');
final Uri _urllnkdn = Uri.parse(
    'https://www.linkedin.com/company/hire-job-india/?originalSubdomain=in');
final Uri _urltwtr = Uri.parse('https://twitter.com/');
final Uri _urlinsta = Uri.parse('https://www.instagram.com/hirejobindia/');
final Uri _urlytube = Uri.parse('https://www.youtube.com/@HireJobIndia');

// Future<void> _launchUrlfb() async {
//   if (!await launchUrl(_urlfb)) {
//     throw 'Could not launch $_urlfb';
//   }
// }

Future<void> _launchUrlfb() async {
  //const url = 'https://www.facebook.com/HireJobsIndia';
  if (await canLaunch(urlfb.toString())) {
    await launch(urlfb.toString());
  } else {
    throw 'Could not launch $urlfb';
  }
}

Future<void> _launchUrllkdn() async {
  if (await canLaunch(_urllnkdn.toString())) {
    await launch(_urllnkdn.toString());
  } else {
    throw 'Could not launch $_urllnkdn';
  }
}

Future<void> _launchUrltwtr() async {
  if (await canLaunch(_urltwtr.toString())) {
    await launch(_urltwtr.toString());
  } else {
    throw 'Could not launch $_urltwtr';
  }
}

Future<void> _launchUrlinsta() async {
  if (await canLaunch(_urlinsta.toString())) {
    await launch(_urlinsta.toString());
  } else {
    throw 'Could not launch $_urlinsta';
  }
}

Future<void> _launchUrlytbee() async {
  if (await canLaunch(_urlytube.toString())) {
    await launch(_urlytube.toString());
  } else {
    throw 'Could not launch $_urlytube';
  }
}

class CompanyDetail extends StatefulWidget {
  static const String id = 'CompanyDetail';

  const CompanyDetail({Key? key}) : super(key: key);

  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}

class _CompanyDetailState extends State<CompanyDetail> {
  final Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        const Marker(
          markerId: MarkerId('Id-1'),
          position: LatLng(28.5851, 77.3116),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Prince Technology'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[appColor2, appColor]),
            ),
          ),
          elevation: 0,
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  Column(
                    children: [_buildHeader(), _buildBottomDtl()],
                  ),
                  Positioned(
                      top: 120,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _buildLoginDetail()),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        image: DecorationImage(
            image: AssetImage('lib/assets/images/p2.jpg'), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildLoginDetail() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ViewJobs()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                )
              ]),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset('lib/assets/images/n3.png',
                          width: 30, height: 30)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blackHeadingSmall('Prince Technology'),
                        greyTextSmall('Noida, India')
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -16,
                right: 0,
                child: SizedBox(
                  child: MyElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewJobs()));
                      },
                      text: btnText('4 OPEN POSITIONS'),
                      height: 28,
                      width: 140),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomDtl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          blackHeadingSmall('About us'.toUpperCase()),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackHeadingSmall('Grow Next Level Business'.toUpperCase()),
                  const SizedBox(height: 8),
                  greyText(
                      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which dont look \n \n Lorem slightly believable. If you ar ything embarra text on theefined chunks as necessary,')
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Intro video'.toUpperCase()),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/p2.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 8),
          blackHeadingSmall('Overview company'.toUpperCase()),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOverviewList(Icons.category_outlined, 'Categories',
                      'Design & Development'),
                  _buildOverviewList(Icons.location_on_outlined, 'Location',
                      'Noida sector 12 NOIDA'),
                  _buildOverviewList(
                      Icons.call_outlined, 'Phone Number', '456-347-3456'),
                  _buildOverviewList(Icons.mail_outline, 'Email Address',
                      'co@flutter_prince.com'),
                  _buildOverviewList(
                      Icons.language, 'Website', 'www.flutter_prince.com'),
                ],
              )),
          const SizedBox(height: 8),
          blackHeadingSmall('Destination Map'.toUpperCase()),
          Container(
            height: 160,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(28.5851, 77.3116), zoom: 15),
            ),
          ),
          const SizedBox(height: 8),
          blackHeadingSmall('Social Profile'.toUpperCase()),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20.0,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await _launchUrlfb();
                    },
                    child: Image.asset('lib/assets/images/facebook.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                  InkWell(
                    onTap: () async {
                      await _launchUrllkdn();
                    },
                    //https://www.linkedin.com/company/hire-job-india/?originalSubdomain=in
                    child: Image.asset('lib/assets/images/linkedinicon.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                  InkWell(
                    onTap: () async {
                      await _launchUrltwtr();
                    },
                    //https://twitter.com/home
                    child: Image.asset('lib/assets/images/twitter.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                  InkWell(
                    onTap: () async {
                      await _launchUrlinsta();
                    },
                    //https://www.instagram.com/hirejobindia/
                    child: Image.asset('lib/assets/images/instagram.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                  InkWell(
                    onTap: () async {
                      await _launchUrlytbee();
                    },
                    //https://www.youtube.com/@HireJobIndia
                    child: Image.asset('lib/assets/images/youtube.png',
                        width: 40, height: 40, fit: BoxFit.cover),
                  ),
                ],
              )),

          ///
          const SizedBox(height: 8),
          blackHeadingSmall('Job Vacancies'.toUpperCase()),
          SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 2,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) => Column(
                  children: [_buildJobs()],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildOverviewList(icon, title, txt) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          leading: CircleAvatar(
              backgroundColor: backgroundColor,
              child: Icon(icon, size: 20, color: appColor),
              radius: 18),
          minLeadingWidth: 0,
          title: Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: boldText(title)),
          subtitle: greyTextSmall(txt),
        ),
        const Divider(thickness: 1, color: Colors.black12)
      ],
    );
  }

  Widget _buildJobs() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset('lib/assets/images/n3.png',
                        width: 30, height: 30)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackHeadingSmall('Flutter Developer'),
                      greyTextSmall('Prince Tech. Noida India, IND')
                    ],
                  ),
                ),
                const Icon(Icons.bookmark, color: appColor, size: 16),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: greyTextSmall(
                  'It is a long established fact that a reader be distracted by content of page when looking at its layout..'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                boldText('₹ 3,35,000 - ₹ 5,85,000 a year'),
                MyElevatedButton(
                    onPressed: () {},
                    text: btnText('Apply'),
                    height: 28,
                    width: 80)
              ],
            ),
          ],
        ),
      ),
    );
  }

  //https://www.facebook.com/HireJobsIndia
  //https://www.linkedin.com/company/hire-job-india/?originalSubdomain=in
  //https://www.instagram.com/hirejobindia/
  //https://www.youtube.com/@HireJobIndia

}
