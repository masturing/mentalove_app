import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentalove_app/main.dart';
import 'package:mentalove_app/ui/shared/gaps.dart';
import 'package:mentalove_app/ui/widgets/card.dart';

import '../shared/theme.dart';
import '../widgets/appbar.dart';

class TellUsPage extends StatefulWidget {
  const TellUsPage({super.key});

  @override
  State<TellUsPage> createState() => _TellUsPageState();
}

class _TellUsPageState extends State<TellUsPage> {
  final _future = supabase
      .from('tell_us')
      .select<List<Map<String, dynamic>>>()
      .order('created_at', ascending: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightGreyColor,
        body: CustomScrollView(slivers: <Widget>[
          AppBarCustom(
            title: 'Tell Us',
            startColor: kPrimaryColor,
            endColor: kPrimary2Color,
            // leftIcon: Icons.menu,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/add-status');
              },
              child: Container(
                width: parentW(context),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                height: 50,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "Tambah Status",
                  style:
                      whiteTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                )),
              ),
            ),
            gapH12,
            FutureBuilder(
              future: _future,
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final data = snapshot.data!;
                  final items = List<Widget>.generate(data.length, (index) {
                    final dataTell = data[index];
                    return TellUsCard(
                      name: toBeginningOfSentenceCase(dataTell['pengirim']) ??
                          "Loading",
                      date: dataTell['tanggal'],
                      desc: dataTell['konten'],
                      profil: const AssetImage('assets/default_pfp.png'),
                      onTap: () {},
                    );
                  });

                  return Column(
                    // Menggunakan Column untuk menampilkan item
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: items,
                  );
                }
              }),
            )
          ]))
        ]));
  }
}
