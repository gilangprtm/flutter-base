import 'package:get/get.dart';

import '../modules/artikel_detail/bindings/artikel_detail_binding.dart';
import '../modules/artikel_detail/views/artikel_detail_view.dart';
import '../modules/daftar_rawat_jalan/bindings/daftar_rawat_jalan_binding.dart';
import '../modules/daftar_rawat_jalan/views/daftar_rawat_jalan_view.dart';
import '../modules/detail_reservasi/bindings/detail_reservasi_binding.dart';
import '../modules/detail_reservasi/views/detail_reservasi_view.dart';
import '../modules/dokter_detail_tab/bindings/dokter_detail_tab_binding.dart';
import '../modules/dokter_detail_tab/views/dokter_detail_tab_view.dart';
import '../modules/dokter_favorite/bindings/dokter_favorite_binding.dart';
import '../modules/dokter_favorite/views/dokter_favorite_view.dart';
import '../modules/dokter_konfirmasi_tab/bindings/dokter_konfirmasi_tab_binding.dart';
import '../modules/dokter_konfirmasi_tab/views/dokter_konfirmasi_tab_view.dart';
import '../modules/dokter_tab/bindings/dokter_tab_binding.dart';
import '../modules/dokter_tab/views/dokter_tab_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/notifikasi_detail/bindings/notifikasi_detail_binding.dart';
import '../modules/notifikasi_detail/views/notifikasi_detail_view.dart';
import '../modules/pasien/bindings/pasien_binding.dart';
import '../modules/pasien/views/pasien_view.dart';
import '../modules/pasien_setup/bindings/pasien_setup_binding.dart';
import '../modules/pasien_setup/views/pasien_setup_view.dart';
import '../modules/phone_login/bindings/phone_login_binding.dart';
import '../modules/phone_login/views/phone_login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_setup/bindings/profile_setup_binding.dart';
import '../modules/profile_setup/views/profile_setup_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reservasi/bindings/reservasi_binding.dart';
import '../modules/reservasi/views/reservasi_view.dart';
import '../modules/reservasi_setup/bindings/reservasi_setup_binding.dart';
import '../modules/reservasi_setup/views/reservasi_setup_view.dart';
import '../modules/spesialisasi_detail_tab/bindings/spesialisasi_detail_tab_binding.dart';
import '../modules/spesialisasi_detail_tab/views/spesialisasi_detail_tab_view.dart';
import '../modules/spesialisasi_tab/bindings/spesialisasi_tab_binding.dart';
import '../modules/spesialisasi_tab/views/spesialisasi_tab_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';
import '../modules/support_faq/bindings/support_faq_binding.dart';
import '../modules/support_faq/views/support_faq_view.dart';
import '../modules/tambah_pasien/bindings/tambah_pasien_binding.dart';
import '../modules/tambah_pasien/views/tambah_pasien_view.dart';
import '../modules/ulasan/informasi/bindings/ulasan_informasi_binding.dart';
import '../modules/ulasan/informasi/views/ulasan_informasi_view.dart';
import '../modules/ulasan/ulasan/bindings/ulasan_ulasan_binding.dart';
import '../modules/ulasan/ulasan/views/ulasan_ulasan_view.dart';
import '../modules/ulasan/ulasanpage/bindings/ulasan_ulasanpage_binding.dart';
import '../modules/ulasan/ulasanpage/views/ulasan_ulasanpage_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_RAWAT_JALAN,
      page: () => const DaftarRawatJalanView(),
      binding: DaftarRawatJalanBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.ULASAN_INFORMASI,
      page: () => UlasanInformasiView(),
      binding: UlasanInformasiBinding(),
    ),
    GetPage(
      name: _Paths.ULASAN_ULASAN,
      page: () => UlasanUlasanView(),
      binding: UlasanUlasanBinding(),
    ),
    GetPage(
      name: _Paths.ULASAN_ULASANPAGE,
      page: () => UlasanUlasanpageView(),
      binding: UlasanUlasanpageBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER_TAB,
      page: () => const DokterTabView(),
      binding: DokterTabBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER_DETAIL_TAB,
      page: () => const DokterDetailTabView(),
      binding: DokterDetailTabBinding(),
    ),
    GetPage(
      name: _Paths.SPESIALISASI_TAB,
      page: () => const SpesialisasiTabView(),
      binding: SpesialisasiTabBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEL_DETAIL,
      page: () => const ArtikelDetailView(),
      binding: ArtikelDetailBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT_FAQ,
      page: () => SupportFaqView(),
      binding: SupportFaqBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PASIEN,
      page: () => PasienView(),
      binding: PasienBinding(),
    ),
    GetPage(
      name: _Paths.PASIEN_SETUP,
      page: () => PasienSetupView(),
      binding: PasienSetupBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER_FAVORITE,
      page: () => DokterFavoriteView(),
      binding: DokterFavoriteBinding(),
    ),
    GetPage(
      name: _Paths.SPESIALISASI_DETAIL_TAB,
      page: () => const SpesialisasiDetailTabView(),
      binding: SpesialisasiDetailTabBinding(),
    ),
    GetPage(
      name: _Paths.DOKTER_KONFIRMASI_TAB,
      page: () => const DokterKonfirmasiTabView(),
      binding: DokterKonfirmasiTabBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PASIEN,
      page: () => const TambahPasienView(),
      binding: TambahPasienBinding(),
    ),
    GetPage(
      name: _Paths.RESERVASI,
      page: () => ReservasiView(),
      binding: ReservasiBinding(),
    ),
    GetPage(
      name: _Paths.RESERVASI_SETUP,
      page: () => ReservasiSetupView(),
      binding: ReservasiSetupBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RESERVASI,
      page: () => const DetailReservasiView(),
      binding: DetailReservasiBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_LOGIN,
      page: () => const PhoneLoginView(),
      binding: PhoneLoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_SETUP,
      page: () => const ProfileSetupView(),
      binding: ProfileSetupBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI_DETAIL,
      page: () => const NotifikasiDetailView(),
      binding: NotifikasiDetailBinding(),
    ),
  ];
}
