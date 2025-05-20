import 'package:flutter/material.dart';
import '../tshirt_designer.dart';

class TextEditorDialog extends StatefulWidget {
  final Function(TextDesign) onSave;

  const TextEditorDialog({super.key, required this.onSave});

  @override
  State<TextEditorDialog> createState() => _TextEditorDialogState();
}

class _TextEditorDialogState extends State<TextEditorDialog> {
  final TextEditingController _textController = TextEditingController();
  Color _selectedColor = Colors.black;

  final List<Color> _presetColors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  final List<String> _quotes = [
    "Be the change you wish to see",
    "Dream big, work hard",
    "Create your own sunshine",
    "Stay hungry, stay foolish",
    "Never give up on your dreams",
    "Make it happen",
  ];

  final List<TextPreset> _textPresets = [
    TextPreset("Your text\nhere", TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
    TextPreset("Your text\nhere", TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber)),
    TextPreset("YOUR TEXT\nhere", TextStyle(fontWeight: FontWeight.w900, fontSize: 20, fontFamily: 'RobotoCondensed')),
    TextPreset("Your text\nhere", TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.green)),
    TextPreset("Your text\nhere", TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black)),
    TextPreset("Your text\nhere", TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.red,
      shadows: [Shadow(offset: Offset(1, 1), color: Colors.blue)],
    )),
  ];

  void _insertText(String text) {
    final selection = _textController.selection;
    final newText = _textController.text.replaceRange(
      selection.start,
      selection.end,
      text,
    );
    _textController.text = newText;
    _textController.selection = TextSelection.collapsed(
      offset: selection.start + text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Add Text", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 16),

            // Text input field
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                style: TextStyle(color: _selectedColor),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Type your text here...",
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Color Presets
            const Text("Text Color", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _presetColors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = _presetColors[index]);
                  },
                  child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                      color: _presetColors[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _presetColors[index] == _selectedColor ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Text Style Presets
            const Text("Text Style Presets", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _textPresets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final preset = _textPresets[index];
                return GestureDetector(
                  onTap: () => _insertText(preset.text),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        preset.text,
                        style: preset.style,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Quotes Grid (Styled like Presets)
            const Text("Ready to Use Quotes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _quotes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final quote = _quotes[index];
                return GestureDetector(
                  onTap: () => _insertText(quote),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        quote,
                        style: TextStyle(color: _selectedColor, fontSize: 14, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Apply Button
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  widget.onSave(TextDesign(
                    text: _textController.text,
                    color: _selectedColor,
                  ));
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Apply', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class TextPreset {
  final String text;
  final TextStyle style;

  TextPreset(this.text, this.style);
}
