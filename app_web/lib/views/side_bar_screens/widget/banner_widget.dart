import 'package:app_web/controller/banner_controller.dart';
import 'package:app_web/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => BannerWidgetState();
}

class BannerWidgetState extends State<BannerWidget> {
  //a future that will hold the list of the banners once loaded from the api
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    // it will load the banners once the widget is created
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  // Public method to reload banners
  void refresh() {
    setState(() {
      futureBanners = BannerController().loadBanners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No banners found"));
        } else {
          final banners = snapshot.data!;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: banners.map((banner) {
              return Image.network(banner.image, height: 100, width: 100);
            }).toList(),
          );
        }
      },
    );
  }
}
