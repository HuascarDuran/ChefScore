import 'package:flutter/material.dart';

class NewOrderSheet extends StatefulWidget {
  const NewOrderSheet({super.key});
  @override
  State<NewOrderSheet> createState() => _NewOrderSheetState();
}

class _NewOrderSheetState extends State<NewOrderSheet> {
  final _itemsController = TextEditingController();

  @override
  void dispose() {
    _itemsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Nuevo pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _itemsController,
            decoration: const InputDecoration(
              labelText: 'Items (separados por coma)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              final items = _itemsController.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              Navigator.pop(context, items);
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}
