import 'dart:io';
import 'package:flutter/material.dart';

class TextDesign {
  String text;
  Color color;
  Offset position;
  double scale;

  TextDesign({
    required this.text,
    this.color = Colors.black,
    this.position = Offset.zero,
    this.scale = 1.0,
  });
}

class TShirtDesigner extends StatefulWidget {
  final String tshirtImage;
  final String sketchImage;
  final File? selectedImage;
  final Function onImageSelected;
  final VoidCallback? onImageDeleted;
  final VoidCallback? onImageTapped;
  final List<TextDesign> textDesigns;
  final Function(TextDesign) onTextAdded;
  final Function(int) onTextDeleted;

  const TShirtDesigner({
    super.key,
    required this.tshirtImage,
    required this.sketchImage,
    this.selectedImage,
    required this.onImageSelected,
    this.onImageDeleted,
    this.onImageTapped,
    required this.textDesigns,
    required this.onTextAdded,
    required this.onTextDeleted,
  });

  @override
  State<TShirtDesigner> createState() => _TShirtDesignerState();
}

class _TShirtDesignerState extends State<TShirtDesigner> {
  bool hasBeenTapped = false;
  Offset _position = Offset.zero;
  double _scale = 1.0;
  double _previousScale = 1.0;
  Offset _previousOffset = Offset.zero;
  bool _isSelected = false;

  // Text handling variables
  int? _selectedTextIndex;
  Offset _textPosition = Offset.zero;
  double _textScale = 1.0;
  double _previousTextScale = 1.0;

  void _handleImageTap() {
    if (widget.selectedImage != null) {
      widget.onImageTapped?.call();
      setState(() => _isSelected = !_isSelected);
    }
  }

  @override
  void didUpdateWidget(TShirtDesigner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedImage != widget.selectedImage) {
      _position = Offset.zero;
      _scale = 1.0;
      _isSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Base T-shirt image
        Image.asset(
          widget.selectedImage != null ? widget.sketchImage : widget.tshirtImage,
          fit: BoxFit.contain,
        ),

        // Upload prompt circle
        if (widget.selectedImage == null)
          Positioned(
            child: GestureDetector(
              onTap: () {
                setState(() => hasBeenTapped = true);
                widget.onImageSelected();
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.3),
                  border: Border.all(color: Colors.yellow, width: 2),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      hasBeenTapped ? "Upload your design" : "Tap to design",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: hasBeenTapped ? 14 : 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        // User uploaded image layer
        if (widget.selectedImage != null)
          Positioned.fill(
            child: GestureDetector(
              onTap: _handleImageTap,
              onScaleStart: (details) {
                _previousScale = _scale;
                _previousOffset = details.focalPoint;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = (_previousScale * details.scale).clamp(0.5, 3.0);
                  final offsetDelta = details.focalPoint - _previousOffset;
                  _position += offsetDelta;
                  _previousOffset = details.focalPoint;
                });
              },
              child: Stack(
                children: [
                  Center(
                    child: ClipRect(
                      child: Transform.translate(
                        offset: _position,
                        child: Transform.scale(
                          scale: _scale,
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            heightFactor: 0.7,
                            child: Image.file(
                              widget.selectedImage!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_isSelected)
                    Positioned(
                      right: 20,
                      top: 20,
                      child: GestureDetector(
                        onTap: widget.onImageDeleted,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

        // Text rendering layer
        ...widget.textDesigns.asMap().entries.map((entry) {
          final index = entry.key;
          final design = entry.value;
          return Positioned(
            left: design.position.dx,
            top: design.position.dy,
            child: GestureDetector(
              onTap: () => setState(() => _selectedTextIndex = index),
              onScaleStart: (details) {
                _previousTextScale = _textScale;
                _textPosition = design.position;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _textScale = (_previousTextScale * details.scale).clamp(0.5, 3.0);
                  _textPosition += details.focalPoint - details.localFocalPoint;
                  widget.textDesigns[index] = TextDesign(
                    text: design.text,
                    color: design.color,
                    position: _textPosition,
                    scale: _textScale,
                  );
                });
              },
              child: Transform.scale(
                scale: design.scale,
                child: Stack(
                  children: [
                    Text(
                      design.text,
                      style: TextStyle(
                        color: design.color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_selectedTextIndex == index)
                      Positioned(
                        right: -10,
                        top: -10,
                        child: GestureDetector(
                          onTap: () => widget.onTextDeleted(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}