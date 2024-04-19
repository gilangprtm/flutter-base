import 'package:flutter/material.dart';
import '../../mahas_colors.dart';
import '../mahas_themes.dart';

class NoInternetConnectionPage extends StatelessWidget {
  final Function()? onPressed;

  const NoInternetConnectionPage({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no_internet.png",
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.width * 0.3,
            ),
            Text(
              "Terjadi Kesalahan!",
              style: MahasThemes.h2,
              textAlign: TextAlign.center,
            ),
            Text(
              "Pastikan internetmu lancar, cek ulang jaringan di tempatmu",
              style: MahasThemes.normal,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Visibility(
              visible: onPressed != null ? true : false,
              child: ElevatedButton(
                onPressed: onPressed ?? () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MahasColors.primary,
                ),
                child: Text(
                  "Coba Lagi",
                  style: MahasThemes.h3.copyWith(color: MahasColors.light),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
