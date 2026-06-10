import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Posição inicial (FIAP Paulista)
  final LatLng _initialPosition = const LatLng(-23.5614, -46.6559);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _initialPosition,
        initialZoom: 16.0,
      ),
      children: [
        // 1. A camada de "azulejos" (As imagens das ruas do OpenStreetMap)
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.seunome.biptag', // Boa prática do OSM
        ),

        // Marcadores (sensores, câmeras e itens)
        MarkerLayer(
          markers: [
            Marker(
              point: const LatLng(-23.5614, -46.6559),
              width: 50,
              height: 50,
              child: const Icon(
                Icons.videocam,
                color: Colors.blue,
                size: 40,
              ),
            ),
            Marker(
              point: const LatLng(-23.5620, -46.6550),
              width: 50,
              height: 50,
              child: const Icon(
                Icons.thermostat,
                color: Colors.orange,
                size: 40,
              ),
            ),
            Marker(
              point: const LatLng(-23.5610, -46.6565),
              width: 50,
              height: 50,
              child: const Icon(
                Icons.laptop_mac,
                color: Colors.black,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}