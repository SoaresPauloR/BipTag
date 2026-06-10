import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/rfid_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _initialPosition = const LatLng(-23.5614, -46.6559);
  bool _isScanning = false;

  // Função para o serviço HTTP
  void _scanArea() async {
    setState(() {
      _isScanning = true;
    });

    // Chama a nossa "API" do GitHub
    final tagData = await RfidService.scanTag();

    setState(() {
      _isScanning = false;
    });

    // Se a API retornar dados, mostra o Pop-up
    if (tagData != null && mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'Alerta da Rede!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tagData['alert_message'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Equipamento: ${tagData['item_name']}'),
                    const SizedBox(height: 4),
                    Text('ID da Etiqueta: ${tagData['rfid_id']}'),
                    const SizedBox(height: 4),
                    Text(
                      'Status: ${tagData['item_status']}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Entendido',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    } else if (mounted) {
      // Caso o Gist no Github saia do ar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma etiqueta suspeita detectada na área.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold sem AppBar para uso do FloatingActionButton
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _initialPosition,
          initialZoom: 16.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.seunome.biptag',
          ),
        ],
      ),
      // O Botão Flutuante de Scanner
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isScanning ? null : _scanArea,
        backgroundColor: _isScanning ? Colors.grey : const Color(0xFF282828),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: _isScanning
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.radar),
        label: Text(
          _isScanning ? 'Escaneando...' : 'Escanear Área',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat,
    );
  }
}
