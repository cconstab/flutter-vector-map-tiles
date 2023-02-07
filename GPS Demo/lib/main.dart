import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_cli/at_onboarding_cli.dart';

// ignore: uri_does_not_exist
import 'api_key.dart';

void main() async {
  await onboardAtsign();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atsign Secure & Private GPS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Atsign Secure & Private GPS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MapController _controller = MapController();
  double lat1 = 42;
  double long1 = -83;

  double lat2 = 42;
  double long2 = -83;

  double lat3 = 42;
  double long3 = -83;

  double lat4 = 42;
  double long4 = -83;

  double lat5 = 42;
  double long5 = -83;

  double lat6 = 42;
  double long6 = -83;

  String car = '';
  String car1 = '';
  String car2 = '';
  String car3 = '';
  String car4 = '';
  String car5 = '';
  String car6 = '';

  @override
  void initState() {
    super.initState();
    String atSign = '@atgps_receiver';

    print(atSign);
    AtClientManager atClientManager = AtClientManager.getInstance();
    //atSign = atClientManager.atClient.getCurrentAtSign().toString();
    print(atSign);
    NotificationService notificationService =
        atClientManager.atClient.notificationService;

    notificationService
        .subscribe(regex: '@atgps_receiver:{"device":"car', shouldDecrypt: true)
        .listen(((notification) async {
      String? sendingAtsign = notification.from;
      String? json = notification.key;
      json = json.replaceFirst('@atgps_receiver:', '');
      print(json);
      int timeNow = DateTime.now().millisecondsSinceEpoch;
      var decodeJson = jsonDecode(json.toString());
      int timeSent = int.parse(decodeJson['Time']);
      int timeDelay = timeNow - timeSent;
      // if (timeSent > lastTime) {
      //   lastTime = timeSent;
      print('Time Delay: $timeDelay');
      decodeJson['Time'] = '${timeDelay.toString()} ms';
      String sendJson = jsonEncode(decodeJson);
      car = decodeJson['device'];
      print('car:$car');
      if (car == 'car1') {
        car1 = car;
        long1 = double.parse(decodeJson['longitude']);
        lat1 = double.parse(decodeJson['latitude']);
        setState(() {});
      } 
      if (car == 'car2'){
        car2 = car;
        long2 = double.parse(decodeJson['longitude']);
        lat2 = double.parse(decodeJson['latitude']);
        setState(() {});
      }
      if (car == 'car3'){
        car3 = car;
        long3 = double.parse(decodeJson['longitude']);
        lat3 = double.parse(decodeJson['latitude']);
        setState(() {});
      }
      if (car == 'car4'){
        car4 = car;
        long4 = double.parse(decodeJson['longitude']);
        lat4 = double.parse(decodeJson['latitude']);
        setState(() {});
      }
      if (car == 'car5'){
        car5 = car;
        long5 = double.parse(decodeJson['longitude']);
        lat5 = double.parse(decodeJson['latitude']);
        setState(() {});
      }
      if (car == 'car6'){
        car6 = car;
        long6 = double.parse(decodeJson['longitude']);
        lat6 = double.parse(decodeJson['latitude']);
        setState(() {});
      }
    }),
            onError: (e) => print('Notification Failed:' + e.toString()),
            onDone: () => print('Notification listener stopped'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: Column(children: [
          Flexible(
              child: FlutterMap(
            mapController: _controller,
            options: MapOptions(
                center: LatLng(lat1, long1),
                zoom: 10,
                maxZoom: 22,
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchMove |
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.doubleTapZoom),
            children: [
              // normally you would see TileLayer which provides raster tiles
              // instead this vector tile layer replaces the standard tile layer
              VectorTileLayer(
                theme: _mapTheme(),
                backgroundTheme: _backgroundTheme(),
                // tileOffset: TileOffset.mapbox, enable with mapbox
                tileProviders: TileProviders(
                    // Name must match name under "sources" in theme
                    {'openmaptiles': _cachingTileProvider(_urlTemplate())}),
              ),
              MarkerLayer(markers: [
                Marker(
                    point: LatLng(lat1, long1),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car1,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
                Marker(
                    point: LatLng(lat2, long2),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
                                        Marker(
                    point: LatLng(lat3, long3),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car3,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
                                        Marker(
                    point: LatLng(lat4, long4),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car4,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
                                        Marker(
                    point: LatLng(lat5, long5),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car5,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
                                        Marker(
                    point: LatLng(lat6, long6),
                    width: 38,
                    height: 38,
                    builder: (context) => Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            // ignore: prefer_const_constructors
                            Icon(
                              Icons.directions_car_filled,
                              color: Colors.red,
                              size: 40,
                            ),
                            Text(
                              " "+car6,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800,color: Colors.black),
                            ),
                          ],
                         )
                        ),
              ]),
            ],
          )),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_statusText()])
        ])));
  }

  VectorTileProvider _cachingTileProvider(String urlTemplate) {
    return MemoryCacheVectorTileProvider(
        delegate: NetworkVectorTileProvider(
            urlTemplate: urlTemplate,
            // this is the maximum zoom of the provider, not the
            // maximum of the map. vector tiles are rendered
            // to larger sizes to support higher zoom levels
            maximumZoom: 14),
        maxSizeBytes: 1024 * 1024 * 2);
  }

  Theme _mapTheme() {
    // maps are rendered using themes
    // to provide a dark theme do something like this:
    // if (MediaQuery.of(context).platformBrightness == Brightness.dark) return myDarkTheme();
    return ProvidedThemes.lightTheme();
    // return ThemeReader(logger: const Logger.console())
    //     .read(myCustomStyle());
  }

  _backgroundTheme() {
    return _mapTheme()
        .copyWith(types: {ThemeLayerType.background, ThemeLayerType.fill});
  }

  String _urlTemplate() {
    // IMPORTANT: See readme about matching tile provider with theme

    // Stadia Maps source https://docs.stadiamaps.com/vector/
    // ignore: undefined_identifier
    // return 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=$stadiaMapsApiKey';

    // Maptiler source
    return 'https://api.maptiler.com/tiles/v3/{z}/{x}/{y}.pbf?key=$maptilerApiKey';

    // Mapbox source https://docs.mapbox.com/api/maps/vector-tiles/#example-request-retrieve-vector-tiles
    // return 'https://api.mapbox.com/v4/mapbox.mapbox-streets-v8/{z}/{x}/{y}.mvt?access_token=$mapboxApiKey',
  }

  Widget _statusText() => Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: StreamBuilder(
          stream: _controller.mapEventStream,
          builder: (context, snapshot) {
            return Text(
                'Zoom: ${_controller.zoom.toStringAsFixed(2)} Center: ${_controller.center.latitude.toStringAsFixed(4)},${_controller.center.longitude.toStringAsFixed(4)}');
          }));
}

Future<void> onboardAtsign() async {
  String atSign = '@atgps_receiver';
  String homeDirectory = '/Users/cconstab/';
  String nameSpace = 'ai6bh';

  //onboarding preference builder can be used to set onboardingService parameters
  AtOnboardingPreference atOnboardingConfig = AtOnboardingPreference()
    //..qrCodePath = 'etc/qrcode_blueamateurbinding.png'
    ..hiveStoragePath = '$homeDirectory/.$nameSpace/$atSign/storage'
    ..namespace = nameSpace
    ..downloadPath = '$homeDirectory/.$nameSpace/files'
    ..isLocalStoreRequired = true
    ..commitLogPath = '$homeDirectory/.$nameSpace/$atSign/storage/commitLog'
    //..cramSecret = '<your cram secret>';
    ..atKeysFilePath = '/Users/cconstab/.atsign/keys/@atgps_receiver_key.atKeys'
    ..fetchOfflineNotifications = false
    ..useAtChops = true;

  AtOnboardingService onboardingService =
      AtOnboardingServiceImpl(atSign, atOnboardingConfig);
  bool onboarded = false;
  Duration retryDuration = Duration(seconds: 3);
  while (!onboarded) {
    try {
      stderr.write(('\r\x1b[KConnecting ... '));
      await Future.delayed(Duration(
          milliseconds:
              1000)); // Pause just long enough for the retry to be visible
      onboarded = await onboardingService.authenticate();
    } catch (exception) {
      stderr.write(
          ('$exception. Will retry in ${retryDuration.inSeconds} seconds'));
    }
    if (!onboarded) {
      await Future.delayed(retryDuration);
    }
  }
}
