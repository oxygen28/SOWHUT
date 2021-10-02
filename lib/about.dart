import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xff1d1d1d),
      title:  const Text("About"),
      centerTitle: true,
    ),
    body: Container(
      width: 400,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff222222),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "About SOWHUT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Linkify(
            textScaleFactor: 1.15,
            onOpen: _onOpen,
            text: "SOWHUT provide easy access to the National Aeronautics and Space Administration (NASA) Langley Research Center (LaRC) Prediction of Worldwide Energy Resource (POWER) Project data. It takes several input parameters (Location data, data name, temporal resolution, and date range) to provide customisable data for the user. For the daily temporal resolution, SOWHUT will convert the data taken into weekly averages. The source code of SOWHUT is available at https://github.com/oxygen28/SOWHUT",
            style: const TextStyle(color: Colors.white),
            linkStyle: const TextStyle(color: Color(0xffffc04d)),
          ),
          const SizedBox(height: 10),
          const Text(
            "Data Source",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Linkify(
            textScaleFactor: 1.15,
            onOpen: _onOpen,
            text: "The data was obtained from the National Aeronautics and Space Administration (NASA) Langley Research Center (LaRC) Prediction of Worldwide Energy Resource (POWER) Project https://power.larc.nasa.gov/ funded through the NASA Earth Science/Applied Science Program.",
            style: const TextStyle(color: Colors.white),
            linkStyle: const TextStyle(color: Color(0xffffc04d)),
          ),
          const SizedBox(height: 10),
          const Text(
            "Attributes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Linkify(
            textScaleFactor: 1.15,
            onOpen: _onOpen,
            text: "Logo made by https://www.freepik.com",
            style: const TextStyle(color: Colors.white),
            linkStyle: const TextStyle(color: Color(0xffffc04d)),
          ),
        ],
      ),
    ),
  );

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}