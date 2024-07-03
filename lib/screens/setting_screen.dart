import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:newsflash/provider/news_provider.dart';
import 'package:newsflash/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Map<String, String>> language = [
    {"language": "English", "code": "en", "index": "0"},
    {"language": "Spanish", "code": "es", "index": "1"}
  ];

  String selectedLanguageCode = "en";
  int selectedLanguageindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    getDefaltFunction();
    super.initState();
  }

  getDefaltFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("code")) {
      setState(() {
        selectedLanguageCode = pref.getString("code").toString();
      });
    } else {
      setState(() {
        selectedLanguageCode = 'en';
      });
    }
    if (pref.containsKey("index")) {
      setState(() {
        selectedLanguageindex = pref.getInt("index")!;
      });
    } else {
      setState(() {
        selectedLanguageindex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('Settings')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.tr('Theme'),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Switch(
                        value: Provider.of<ThemeProvider>(context).isDarkModeOn,
                        onChanged: (_) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.tr('Language'),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        filled: true,
                        hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
                      ),
                      value: selectedLanguageCode,
                      onChanged: (String? newValue) {
                        print(newValue);
                        var lang = language.where((e) => e["code"] == newValue);
                        print(lang.first["index"]);
                        setState(() {
                          selectedLanguageindex =
                              int.parse(lang.first["index"].toString());
                          selectedLanguageCode = newValue!;
                        });
                      },
                      items: language.map<DropdownMenuItem<String>>(
                          (Map<String, String> lang) {
                        return DropdownMenuItem<String>(
                          value: lang["code"],
                          child: Text(lang["language"]!),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () async {
                    await context.setLocale(
                        context.supportedLocales[selectedLanguageindex]);
                    saveFunctiono(selectedLanguageCode, selectedLanguageindex);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.065,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF874FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void saveFunctiono(String code, int index) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.setString("code", code);
    prefer.setInt("index", index);
    Provider.of<NewsProvider>(context, listen: false).getAllNews();
  }
}
