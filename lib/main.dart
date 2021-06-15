import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

var letterList = [
  "ّ",
  "ٌ",
  "ُ",
  "َ",
  "ِ",
  "ٍ",
  "ً",
  "ْ",
  "آ",
  "إ",
  "أ",
  "ض",
  "ث",
  "ق",
  "ف",
  "غ",
  "خ",
  "چ",
  "ج",
  "ش",
  "ي",
  "ب",
  "ت",
  "ن",
  "ئ",
  "ؤ",
  "ة",
  "ز",
  "ظ",
  "ذ"
];
var replacement = [
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "ا",
  "ا",
  "ا",
  "ص",
  "ٮ",
  "ٯ",
  "ڡ",
  "ع",
  "ح",
  "ح",
  "ح",
  "س",
  "ى",
  "ٮ",
  "ٮ",
  "ں",
  "ئ",
  "ؤ",
  "ه",
  "ر",
  "ط",
  "د"
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'),
      title: "بدون نقاط",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.cairoTextTheme(),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: GoogleFonts.cairo().copyWith(color: Colors.white),
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController dotsController = TextEditingController();
  TextEditingController noDotsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "بدون نقاط",
          style: GoogleFonts.cairo(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                expands: true,
                minLines: null,
                style: TextStyle(fontSize: 32),
                maxLines: null,
                controller: dotsController,
                onChanged: (value) {
                  noDotsController.text = removeDots(value);
                },
                decoration: InputDecoration(
                    hintText: "عربي مع نقاط", border: OutlineInputBorder()),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("ٮم الںسح الى الحاڡطه"),
                    ));
                    Clipboard.setData(
                        ClipboardData(text: noDotsController.text));
                  },
                  child: TextField(
                    expands: true,
                    enabled: false,
                    minLines: null,
                    maxLines: null,
                    controller: noDotsController,
                    decoration: InputDecoration(
                        hintText: "عرٮى ٮدوں ںٯاط",
                        suffix: Column(
                          children: [
                            Icon(
                              Icons.copy,
                              color: Colors.grey[400],
                            ),
                            Text("اصعط\nللںسح"),
                          ],
                        ),
                        border: OutlineInputBorder()),
                  ),
                );
              }),
            )),
          ],
        ),
      ),
    );
  }

  String removeDots(String value) {
    return value.replaceAllMapped(RegExp("[${letterList.join()}]"), (match) {
      String matched = match.groups([0]).first ?? "";
      var indexOfMatched = letterList.indexOf(matched);
      if (indexOfMatched != -1)
        return replacement[indexOfMatched];
      else
        return match.input;
    });
  }
}
