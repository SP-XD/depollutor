import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_green_extended/api_key.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _mapController = MapController();
  LatLng? _currentPostion;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                  onMapReady: (() {}),
                  center: _currentPostion ?? LatLng(22.5726, 88.3639),
                  zoom: 12),
              nonRotatedChildren: const [],
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.spxd.go-green-extended',
                ),
                MarkerLayer(markers: [
                  Marker(
                    point: _currentPostion ?? LatLng(22.5726, 88.3639),
                    width: 80,
                    height: 80,
                    builder: (context) => const Icon(Icons.pin_drop),
                  ),
                ])
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.white.withAlpha(0),
                      Colors.white.withAlpha(100),
                      Colors.white
                    ])),
                height: 100,
                width: double.maxFinite,
              )),
          Positioned(
              left: 12,
              right: 12,
              bottom: 15,
              child: ElevatedButton(
                onPressed: (() async {
                  final XFile? images =
                      await _picker.pickImage(source: ImageSource.camera);

                  if (!mounted) return;
                  context.push("/upload_spot", extra: images);
                }),
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  textStyle: const TextStyle(color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Capture Dump",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        const SnackBar(content: Text("Please give location permission"));
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        const SnackBar(content: Text("Please give location permission"));
      }
    }

    locationData = await location.getLocation();

    setState(() {
      _currentPostion = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }
}
