import 'package:flutter/material.dart';
import 'package:mentalove_app/main.dart';
import 'package:mentalove_app/ui/shared/theme.dart';
import 'package:mentalove_app/ui/widgets/appbar.dart';

class DailyContentPage extends StatefulWidget {
  const DailyContentPage({super.key});

  @override
  State<DailyContentPage> createState() => _DailyContentPageState();
}

class _DailyContentPageState extends State<DailyContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor.withOpacity(0.5),
      body: CustomScrollView(slivers: <Widget>[
        AppBarCustom(
          title: 'Daily Content',
          startColor: kPrimaryColor,
          endColor: kPrimary2Color,
          // leftIcon: Icons.menu,
          rightIcon: Icons.logout,
          rightAction: () async {
            await supabase.auth.signOut();
          },
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height - 120,
              child: Center(
                child: Text(
                  'Coming Soon',
                  style: whiteTextStyle.copyWith(
                      fontSize: 20, fontWeight: extraBold),
                ),
              ),
            ),
          ),
          // Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Motivasi',
          //             style: blackTextStyle.copyWith(
          //                 fontSize: 20, fontWeight: extraBold),
          //           ),
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 )
          //               ]),
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 )
          //               ]),
          //           gapH24,
          //           Text(
          //             'Komik',
          //             style: blackTextStyle.copyWith(
          //                 fontSize: 20, fontWeight: extraBold),
          //           ),
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 )
          //               ]),
          //           Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 ),
          //                 DailyCard(
          //                   // image: const AssetImage(''),
          //                   title: 'Double Take',
          //                   desc: 'Constellation of Stars',
          //                   onTap: () {},
          //                 )
          //               ])
          //         ]))
        ]))
      ]),
    );
  }
}
