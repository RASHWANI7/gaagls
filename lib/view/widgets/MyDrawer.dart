// // import 'package:flutter/material.dart';
// // import 'package:gaagls/view/pages/aboutAppPge.dart';
// // import 'package:gaagls/view/pages/bookingsPage.dart';
// //
// // class MyCustomDrawer extends StatelessWidget {
// //   const MyCustomDrawer({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       child: Container(
// //         decoration:  BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: [
// //             const UserAccountsDrawerHeader(
// //               decoration: BoxDecoration(
// //                 color: Colors.transparent,
// //               ),
// //               currentAccountPicture: CircleAvatar(
// //                 backgroundImage: AssetImage(''), // أو NetworkImage
// //               ),
// //               accountName: Text(
// //                 'اسم المستخدم',
// //                 style: TextStyle(fontWeight: FontWeight.bold),
// //               ),
// //               accountEmail: Text('user@example.com'),
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.save_as, color: Colors.white),
// //               title: const Text('My Reservation', style: TextStyle(color: Colors.white)),
// //               onTap: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingsPage()));
// //               },
// //             ),
// //             ListTile(
// //               leading: const Icon(Icons.info, color: Colors.white),
// //               title: const Text('حول التطبيق', style: TextStyle(color: Colors.white)),
// //               onTap: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutAppPage()));
// //               },
// //             ),
// //             const Divider(color: Colors.white70),
// //             ListTile(
// //               leading: const Icon(Icons.logout, color: Colors.white),
// //               title: const Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
// //               onTap: () {
// //                 // تنفيذ تسجيل الخروج
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gaagls/view/pages/aboutAppPge.dart';
// import 'package:gaagls/view/pages/bookingsPage.dart';
// import '../../controller/cubits/profileCubit/profileCubit.dart';
// import '../../controller/cubits/profileCubit/profileState.dart';
//
// class MyCustomDrawer extends StatelessWidget {
//   const MyCustomDrawer({super.key});
//
//   Widget _buildAvatar(BuildContext context, String? imageUrl, String nameOrEmail) {
//     final theme = Theme.of(context);
//     if (imageUrl != null && imageUrl.isNotEmpty) {
//       return CircleAvatar(
//         radius: 36,
//         backgroundColor: theme.primaryColor,
//         child: ClipOval(
//           child: Image.network(
//             imageUrl,
//             width: 72,
//             height: 72,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) => Icon(Icons.person, size: 40, color: Colors.white),
//           ),
//         ),
//       );
//     } else {
//       // إظهار الحروف الأولى من الإيميل كـ بديل
//       String initials = '?';
//       if (nameOrEmail.trim().isNotEmpty) {
//         final parts = nameOrEmail.trim().split(RegExp(r'\s+'));
//         if (parts.length >= 2) {
//           initials = (parts[0][0] + parts[1][0]).toUpperCase();
//         } else {
//           initials = nameOrEmail.trim()[0].toUpperCase();
//         }
//       }
//       return CircleAvatar(
//         radius: 36,
//         backgroundColor: theme.primaryColor,
//         child: Text(initials, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [theme.colorScheme.secondary, theme.primaryColor],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // هنا نعرض الصورة و الايميل من الـ Cubit
//             BlocBuilder<ProfileCubit, ProfileState>(
//               builder: (context, state) {
//                 String displayNameOrEmail = 'ضيف';
//                 String email = '';
//                 String imageUrl = '';
//
//                 if (state is ProfileSuccess) {
//                   displayNameOrEmail = ((state.firstName ?? '') + ' ' + (state.lastName ?? '')).trim();
//                   if (displayNameOrEmail.isEmpty) displayNameOrEmail = state.email ?? 'ضيف';
//                   email = state.email ?? '';
//                   imageUrl = state.image ?? '';
//                 }
//
//                 return UserAccountsDrawerHeader(
//                   decoration: const BoxDecoration(color: Colors.transparent),
//                   currentAccountPicture: _buildAvatar(context, imageUrl, displayNameOrEmail),
//                   accountName: Text(
//                     // نعرض الاسم إن وجد وإلا نعرض جزء من الايميل أو 'ضيف'
//                     displayNameOrEmail,
//                     style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   accountEmail: email.isEmpty ? null : Text(email, style: const TextStyle(color: Colors.white70)),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.save_as, color: Colors.white),
//               title: const Text('My Reservation', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingsPage()));
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.info, color: Colors.white),
//               title: const Text('حول التطبيق', style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const AboutAppPage()));
//               },
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaagls/view/pages/aboutAppPge.dart';
import 'package:gaagls/view/pages/bookingsPage.dart';
import 'package:remixicon/remixicon.dart';
import '../../controller/cubits/profileCubit/profileCubit.dart';
import '../../controller/cubits/profileCubit/profileState.dart';
import '../pages/carBrandPage.dart';
import '../pages/destinationsPage.dart';
import '../pages/hotelsPage.dart';
import '../pages/resturantsPage.dart';
import '../pages/tripsPage.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  // استخرج الحروف الأولى لعرضها داخل الـ avatar كبديل
  String _initials(String text) {
    final t = text.trim();
    if (t.isEmpty) return '?';
    final parts = t.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return t[0].toUpperCase();
  }

  // ويدجت الصورة مع حلقة مضيئة وزخرفة
  Widget _fancyAvatar(BuildContext context, String? imageUrl, String display) {
    final primary = Theme.of(context).primaryColor;
    final accent = Theme.of(context).colorScheme.secondary;

    // حلقة خارجية متدرجة
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [accent.withOpacity(0.95), primary.withOpacity(0.95)]),
        boxShadow: [
          BoxShadow(color: accent.withOpacity(0.25), blurRadius: 12, spreadRadius: 2),
        ],
      ),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        ),
        child: ClipOval(
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallbackCircle(context, display),
          )
              : _fallbackCircle(context, display),
        ),
      ),
    );
  }

  Widget _fallbackCircle(BuildContext context, String display) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.12),
      alignment: Alignment.center,
      child: Text(
        _initials(display),
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  // ويدجت صف عنصر (card-like) في الدروير
  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final primary = Theme.of(context).primaryColor;
    final accent = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent.withOpacity(0.12), Colors.white.withOpacity(0.02)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.06)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primary.withOpacity(0.12),
                  child: Icon(icon, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                Icon(Icons.chevron_right, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // فرض عرض أكبر لجمالية أفضل (اختياري؛ يعالج الهوامش)
    return SizedBox(
      width: 320,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.colorScheme.secondary, theme.primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ---- رأس الدروير المزخرف ----
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // خلفية رأس منحنية مع زخارف دائرية
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [theme.primaryColor.withOpacity(0.95), theme.colorScheme.secondary.withOpacity(0.85)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 18, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          String display = 'ضيف';
                          String email = '';
                          String imageUrl = '';

                          if (state is ProfileSuccess) {
                            final fn = state.firstName ?? '';
                            final ln = state.lastName ?? '';
                            display = (fn + ' ' + ln).trim();
                            if (display.isEmpty) display = state.email ?? 'ضيف';
                            email = state.email ?? '';
                            imageUrl = state.image ?? '';
                          }

                          return Row(
                            children: [
                              // Avatar مع حلقة
                              _fancyAvatar(context, imageUrl, display),
                              const SizedBox(width: 14),
                              // اسم و ايميل
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      display,
                                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      email.isEmpty ? 'غير مسجل' : email,
                                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    // شريط حالة صغير (مثال مزخرف)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.verified_user, size: 14, color: Colors.white70),
                                          SizedBox(width: 6),
                                          Text('مُسجل', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // زخرفة دائرية عائمة (خلفية)
                    Positioned(
                      right: -30,
                      top: -10,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [theme.primaryColor.withOpacity(0.14), Colors.transparent]),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -40,
                      bottom: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [theme.colorScheme.secondary.withOpacity(0.12), Colors.transparent]),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ---- عناصر الدروير كبطاقات شفافة ----
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [

                        _drawerItem(
                          context: context,
                          icon: RemixIcons.plane_line,
                          title: 'Flights',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DestinationsPage()));
                          },
                        ),

                        _drawerItem(
                          context: context,
                          icon: RemixIcons.restaurant_line,
                          title: 'Restaurants',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const ResturantsPage()));
                          },
                        ),

                        _drawerItem(
                          context: context,
                          icon: RemixIcons.hotel_line,
                          title: 'Hotels',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const HotelsPage()));
                          },
                        ),

                        _drawerItem(
                          context: context,
                          icon: RemixIcons.map_line,
                          title: 'Trips',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const TripsPage()));
                          },
                        ),
                        _drawerItem(
                          context: context,
                          icon: RemixIcons.car_line,
                          title: 'Cars',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const CarBrandPage()));
                          },
                        ),


                        _drawerItem(
                          context: context,
                          icon: RemixIcons.calendar_2_fill,
                          title: 'My Reservation',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookingsPage()));
                          },
                        ),

                        _drawerItem(
                          context: context,
                          icon: Icons.info,
                          title: 'About us',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAppPage()));
                          },
                        ),

                        // فاصل متدرّج
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.white.withOpacity(0.12), Colors.white.withOpacity(0.02)]),
                            ),
                          ),
                        ),


                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
