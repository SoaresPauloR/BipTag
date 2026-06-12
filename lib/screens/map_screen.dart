import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../services/rfid_service.dart';
import '../providers/inventory_provider.dart';

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
    // Escutando a lista de itens do Provider em tempo real
    final inventoryItems = context.watch<InventoryProvider>().inventory;

    // Scaffold sem AppBar para uso do FloatingActionButton
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _initialPosition,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.seunome.biptag',
          ),
          // Marcadores (Pinos no Mapa)
          MarkerLayer(
            markers: inventoryItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isStolen =
                  item.status == 'Stolen' || item.status == 'Roubado';

              // Calcula uma posição falsa para cada item não ficar sobreposto
              final lat = _initialPosition.latitude + (index * 0.002);
              final lng = _initialPosition.longitude + (index * 0.001);

              return Marker(
                point: LatLng(lat, lng),
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    // Etiqueta flutuante com o nome do item
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // O ícone do pino (Alerta vermelho se roubado, Preto padrão se OK)
                    Icon(
                      isStolen ? Icons.warning_rounded : Icons.location_on,
                      color: isStolen ? Colors.red : const Color(0xFF282828),
                      size: 36,
                    ),
                  ],
                ),
              );
            }).toList(),
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
          _isScanning ? 'Escaneando...' : 'Escanear Objeto',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
