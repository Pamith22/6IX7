import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/shop/screens/ai_text_to_image_generator/widgets/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  final TextEditingController _controller = TextEditingController();
  late final PromptBloc _promptBloc;

  @override
  void initState() {
    super.initState();
    _promptBloc = PromptBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Images🚀"),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: _promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              // Image Preview Section
              _buildImagePreview(state),

              // Input Section
              _buildInputSection(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildImagePreview(PromptState state) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        child: _getPreviewContent(state),
      ),
    );
  }

  Widget _getPreviewContent(PromptState state) {
    if (state is PromptGeneratingImageLoadState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is PromptGeneratingImageErrorState) {
      return const Center(
        child: Text(
          "Failed to generate image\nPlease try again!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }

    if (state is PromptGeneratingImageSuccessState) {
      return Image.memory(state.uint8list, fit: BoxFit.cover);
    }

    return const Center(
      child: Text(
        "Your generated image will appear here",
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your prompt",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            cursorColor: Colors.deepPurple,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Describe the image you want to generate...",
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  _promptBloc.add(PromptEnteredEvent(
                      prompt: _controller.text.trim()));
                }
              },
              icon: const Icon(Icons.generating_tokens_outlined),
              label: const Text(
                "Generate Image",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _promptBloc.close();
    _controller.dispose();
    super.dispose();
  }
}