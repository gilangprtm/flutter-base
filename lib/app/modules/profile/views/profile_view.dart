import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:haimed_getx/app/mahas/mahas_colors.dart';

import '../../../mahas/components/mahas_themes.dart';
import '../../../mahas/mahas_service.dart';
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
              backgroundColor: MahasColors.primary,
              actions: [
                PopupMenuButton(
                  icon: const Icon(
                    Icons.edit_note_rounded,
                    size: 30,
                  ),
                  onSelected: (value) =>
                      controller.popupMenuButtonOnSelected(value),
                  itemBuilder: (BuildContext context) {
                    List<PopupMenuItem<String>> r = [];
                    r.add(
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: MahasColors.dark,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Edit Profile'),
                          ],
                        ),
                      ),
                    );
                    r.add(
                      PopupMenuItem(
                        value: 'keluar',
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.rightFromBracket,
                              color: MahasColors.dark,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Keluar'),
                          ],
                        ),
                      ),
                    );

                    return r;
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(auth.currentUser!.displayName ?? "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: controller.profilePic.value != ''
                    ? Image.network(
                        controller.profilePic.value,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/no-photo.png",
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SliverPersistentHeader(
              delegate: SectionHeaderDelegate(
                Column(
                  children: [
                    ListMenu(
                      title: auth.currentUser!.email ?? "",
                      subtitle: "Email",
                      icon: Icons.mail_outline_rounded,
                      detail: false,
                    ),
                    ListMenu(
                      title: "Akun Pasien & Reservasi",
                      subtitle: "Akun terdaftar",
                      icon: Icons.person_add_alt_1_rounded,
                      onTap: () {
                        controller.toPasien();
                      },
                    ),
                    ListMenu(
                      title: "Dokter",
                      subtitle: "List Favorite",
                      icon: FontAwesomeIcons.userDoctor,
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
  final IconData icon;
  final bool? detail;
  final Function()? onTap;
  const ListMenu({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
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
                  icon,
                  size: 23.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: MahasThemes.h3,
                    ),
                    Text(
                      subtitle,
                      style: MahasThemes.muted,
                    ),
                  ],
                ),
                Spacer(),
                Visibility(
                  visible: detail!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: MahasColors.primary,
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
