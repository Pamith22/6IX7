import 'package:flutter/material.dart';

class PositionDialog extends StatelessWidget {
  const PositionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: scrollController,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Position',
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

              // Move Section
              _buildSectionHeader('Move'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDirectionButton(Icons.arrow_back, 'Left'),
                  _buildDirectionButton(Icons.arrow_forward, 'Right'),
                  _buildDirectionButton(Icons.arrow_upward, 'Up'),
                  _buildDirectionButton(Icons.arrow_downward, 'Down'),
                ],
              ),
              const SizedBox(height: 24),

              // Align Section
              _buildSectionHeader('Align'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAlignButton([Icons.arrow_upward]),
                        _buildAlignButton([
                          Icons.arrow_forward,
                          Icons.arrow_downward,
                          Icons.arrow_back
                        ]),
                        _buildAlignButton([
                          Icons.arrow_downward,
                          Icons.arrow_back
                        ]),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAlignButton([Icons.arrow_forward, Icons.arrow_downward]),
                        _buildAlignButton([Icons.arrow_upward]),
                        _buildAlignButton([Icons.arrow_downward]),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Added extra spacing
            ],
          ),
        );
      },
    );
  }

  // Keep rest of the helper methods same as before
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildDirectionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildAlignButton(List<IconData> icons) {
    return Container(
      width: 80,
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: icons.map((icon) => Icon(icon, size: 18)).toList(),
      ),
    );
  }
}