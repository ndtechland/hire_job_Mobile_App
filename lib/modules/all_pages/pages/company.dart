import 'package:flutter/material.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/company_detail.dart';
import 'package:hirejobindia/widget/navbar.dart';

class Company extends StatefulWidget {
  static const String id = 'Company';

  const Company({Key? key}) : super(key: key);

  @override
  CompanyState createState() => CompanyState();
}

class CompanyState extends State<Company> {
  @override
  void initState() {
    super.initState();
  }

  List<Item> companyList = <Item>[
    const Item('lib/assets/images/n3.png', 'Prince Tech'),
    const Item('lib/assets/images/n2.png', 'Global Info'),
    const Item('lib/assets/images/n1.png', 'Monarch IT'),
    const Item('lib/assets/images/n4.png', 'Prince PVT. LTD.'),
    const Item('lib/assets/images/n3.png', 'Rammurthi Tech'),
    const Item('lib/assets/images/n2.png', 'Fcc Info'),
    const Item('lib/assets/images/n1.png', 'Monar IT'),
    const Item('lib/assets/images/n4.png', 'Soft PVT. LTD.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Company'),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        shrinkWrap: true,
        children: companyList.map((e) {
          return _buildCompany(context, e);
        }).toList(),
      ),
    );
  }

  Widget _buildCompany(context, e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CompanyDetail()));
      },
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                e.img,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              boldText2(e.name),
              const SizedBox(height: 5),
              greyTextSmall('(150 jobs)')
            ],
          )),
    );
  }
}

class Item {
  const Item(this.img, this.name);
  final String img;
  final String name;
}
