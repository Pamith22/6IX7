import 'package:flutter/material.dart';

class TransformDialog extends StatefulWidget {
  const TransformDialog({super.key});

  @override
  State<TransformDialog> createState() => _TransformDialogState();
}

class _TransformDialogState extends State<TransformDialog> {
  double _rotationValue = 0;
  double _widthValue = 64;
  double _heightValue = 36;
  late TextEditingController _widthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(text: _widthValue.toStringAsFixed(2));
    _heightController = TextEditingController(text: _heightValue.toStringAsFixed(2));
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transform',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),

              // Rotation Section
              _buildSectionHeader('Rotate'),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _rotationValue,
                      min: -180,
                      max: 180,
                      label: _rotationValue.toStringAsFixed(2),
                      onChanged: (value) => setState(() => _rotationValue = value),
                    ),
                  ),
                  Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _rotationValue.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Width & Height Section
              _buildSectionHeader('Width'),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _widthController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Width',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => setState(() => _widthValue = double.tryParse(value) ?? 64),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                final newValue = _widthValue + 1;
                                setState(() => _widthValue = newValue);
                                _widthController.text = newValue.toStringAsFixed(2);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                final newValue = _widthValue - 1;
                                setState(() => _widthValue = newValue);
                                _widthController.text = newValue.toStringAsFixed(2);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Height',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) => setState(() => _heightValue = double.tryParse(value) ?? 36),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add, size: 20),
                              onPressed: () {
                                final newValue = _heightValue + 1;
                                setState(() => _heightValue = newValue);
                                _heightController.text = newValue.toStringAsFixed(2);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove, size: 20),
                              onPressed: () {
                                final newValue = _heightValue - 1;
                                setState(() => _heightValue = newValue);
                                _heightController.text = newValue.toStringAsFixed(2);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Flip Buttons
              _buildSectionHeader('Flip'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.flip),
                    label: const Text('Horizontally'),
                    onPressed: () {},
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.flip),
                    label: const Text('Vertically'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}