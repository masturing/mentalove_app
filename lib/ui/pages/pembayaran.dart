import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mentalove_app/ui/shared/gaps.dart';
import 'package:mentalove_app/ui/shared/theme.dart';
import 'package:mentalove_app/ui/widgets/appbar.dart';
import 'package:mentalove_app/ui/widgets/button.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class Pembayaran extends StatefulWidget {
  final Map<String, dynamic> terapisData;
  final bool mode;
  final int selectedTanggal;
  final int selectedJam;

  const Pembayaran(
      {super.key,
      required this.terapisData,
      required this.mode,
      required this.selectedTanggal,
      required this.selectedJam});

  @override
  State<Pembayaran> createState() => _PembayaranState();
}

class _PembayaranState extends State<Pembayaran> {
  @override
  Widget build(BuildContext context) {
    final terapisData = widget.terapisData;
    final mode = widget.mode;
    final selectedJam = widget.selectedJam;
    final selectedHari = widget.selectedTanggal;

    Map<String, dynamic> waktuData = terapisData['waktu'];
    String hari = waktuData.keys.elementAt(selectedHari);
    dynamic jamList = waktuData[hari];
    String jam = jamList[selectedJam];

    int harga = terapisData['harga'];
    String hargaStr = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(harga);
    int hargaAdmin = 1000;
    String hargaAdminStr = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(hargaAdmin);
    int totalPembayaran = harga + hargaAdmin;
    String hargaRp = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(totalPembayaran);

    MidtransSDK? _midtrans;

  @override
  void initState() {
    super.initState();
    initSDK();
  }

  void initSDK() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: dotenv.env['SB-Mid-client-8N4d_4Ss4vSRG6WX'] ?? "",
        merchantBaseUrl: dotenv.env['G553050654'] ?? "",
        colorTheme: ColorTheme(
          colorPrimary: Theme.of(context).colorScheme.secondary,
          colorPrimaryDark: Theme.of(context).colorScheme.secondary,
          colorSecondary: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
    _midtrans?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );
    _midtrans!.setTransactionFinishedCallback((result) {
      print(result.toJson());
    });
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
  }

    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: CustomScrollView(
        slivers: <Widget>[
          AppBarCustom(
            title: 'Pembayaran',
            startColor: kPrimaryColor,
            endColor: kPrimary2Color,
            leftAction: () {
              Navigator.pop(context);
            },
            leftIcon: Icons.arrow_back,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                color: kPrimary2Color,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: const DecorationImage(
                                    image: AssetImage('assets/default_pfp.png'),
                                    fit: BoxFit.cover)),
                          ),
                          gapW12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  terapisData['name'],
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18, fontWeight: extraBold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(terapisData['title'],
                                    style:
                                        blackTextStyle.copyWith(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      gapH24,
                      Text('Jadwal',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: extraBold)),
                      gapH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: kPurpleColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      mode
                                          ? Icons.person_pin_rounded
                                          : Icons.chat,
                                      color: kWhiteColor,
                                    ),
                                    gapW12,
                                    Text(
                                      mode ? 'Video Call' : 'Chat',
                                      style: blackTextStyle.copyWith(
                                          color: kWhiteColor, fontWeight: bold),
                                    ),
                                  ],
                                )),
                          ),
                          gapW12,
                          Expanded(
                            child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    border: Border.all(
                                        color: kPurpleColor, width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: kPurpleColor,
                                    ),
                                    gapW12,
                                    Text(
                                      '$hari, Jam $jam',
                                      style: purpleTextStyle.copyWith(
                                          fontWeight: bold),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      gapH12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biaya Sesi 1 Jam',
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            hargaStr,
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biaya Admin',
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            hargaAdminStr,
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Potongan Harga',
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                          Text(
                            '-',
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: blackTextStyle.copyWith(fontWeight: bold),
                          ),
                          Text(
                            hargaRp,
                            style: blackTextStyle.copyWith(fontWeight: bold),
                          ),
                        ],
                      ),
                      gapH12,
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        width: 1.0, color: kPurpleColor),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13.0),
                                    backgroundColor: kWhiteColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    elevation: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    gapW24,
                                    Icon(
                                      Icons.shopping_cart,
                                      color: kPurpleColor,
                                    ),
                                    gapW12,
                                    Text(
                                      'Pilih Metode Pembayaran',
                                      style: purpleTextStyle.copyWith(
                                          fontWeight: bold),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: kPurpleColor, width: 1.0))),
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            gapH8,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hargaRp,
                      style: blackTextStyle.copyWith(fontWeight: extraBold))
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  //padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Button(
                          text: "Bayar Sekarang",
                          textColor: kPurpleColor,
                          startColor: kPrimaryLightColor,
                          endColor: kPrimaryLightColor,
                          onPressed: () {
                            //Navigator.pushNamed(context, '/pembayaran');
                          })
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
