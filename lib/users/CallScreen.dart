import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class callscreen extends StatelessWidget {
  const callscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          onPressed: () async {
            final Uri url = Uri(
              scheme: 'tel',
              path: '03118049814',
            );
            if(await canLaunchUrl(url)){

              await launchUrl(url);
            }else{
              print('can not launch this url');
            }

          },
          child: Text("call now"),
        )
    );
  }
}
