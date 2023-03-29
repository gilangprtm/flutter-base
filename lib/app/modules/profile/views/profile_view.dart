import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                title: Text("Gilang Pratama",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: SectionHeaderDelegate(
                Column(
                  children: [
                    ListMenu(
                      title: "gilangprtm210498@gmail.com",
                      subtitle: "Email",
                      detail: false,
                    ),
                    ListMenu(
                      title: "Akun Pasien & Reservasi",
                      subtitle: "Akun terdaftar",
                      onTap: () {
                        controller.toPasien();
                      },
                    ),
                    ListMenu(
                      title: "Dokter",
                      subtitle: "List Favorite",
                      onTap: () {
                        controller.toDokter();
                      },
                    ),
                  ],
                ),
                MediaQuery.of(context).size.height - 120,
              ),
              pinned: true,
            ),
          ];
        },
        body: SizedBox(),
      ),
    );
  }
}

class ListMenu extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? detail;
  final Function()? onTap;
  const ListMenu({
    Key? key,
    required this.title,
    required this.subtitle,
    this.detail = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(MahasThemes.borderRadius),
          ),
          child: Container(
            height: 50,
            child: Row(
              children: [
                Icon(
                  Icons.developer_board,
                  // size: 24.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                    ),
                    Text(
                      subtitle,
                    ),
                  ],
                ),
                Spacer(),
                Visibility(
                  visible: detail!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius:
                          BorderRadius.circular(MahasThemes.borderRadius),
                    ),
                    child: TextButton(
                      onPressed: onTap ?? () {},
                      child: const Text(
                        "Detail",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  SectionHeaderDelegate(this.child, this.height);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // color: Theme.of(context).primaryColor,
      // alignment: Alignment.topCenter,
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
