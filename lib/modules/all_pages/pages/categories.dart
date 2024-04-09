import 'package:flutter/material.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/company_detail.dart';
import 'package:hirejobindia/widget/navbar.dart';

class Categories extends StatefulWidget {
  static const String id = 'Categories';

  const Categories({Key? key}) : super(key: key);

  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  List<Item> cateList = <Item>[
    const Item('lib/assets/images/c1.png', 'Developer'),
    const Item('lib/assets/images/c2.png', 'Technology'),
    const Item('lib/assets/images/c3.png', 'Accounting'),
    const Item('lib/assets/images/c4.png', 'Engineer'),
    const Item('lib/assets/images/c1.png', 'Developer'),
    const Item('lib/assets/images/c2.png', 'Technology'),
    const Item('lib/assets/images/c3.png', 'Accounting'),
    const Item('lib/assets/images/c4.png', 'Engineer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        drawer: const NavBar(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Categories'),
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
        children: cateList.map((e) {
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
                color: appColor,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              boldText(e.name),
              const SizedBox(height: 4),
              greyTextSmall('(1111 jobs)'),
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
