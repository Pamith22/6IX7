import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FileLibraryScreen extends StatefulWidget {
  const FileLibraryScreen({super.key});

  @override
  State<FileLibraryScreen> createState() => _FileLibraryScreenState();
}

class _FileLibraryScreenState extends State<FileLibraryScreen> {
  final List<File> _recentFiles = [];
  final List<File> _allFiles = [];
  final TextEditingController _searchController = TextEditingController();
  File? selectedFile;

  Future<void> _addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        final file = File(pickedFile.path);
        _recentFiles.add(file);  // Maintain recent files
        _allFiles.add(file);
        selectedFile = file;
      });
    }
  }

// Rest of your existing code remains the same...
// [Keep all other methods and widgets unchanged]


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          'File Library',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: 'Recently Used',
                      child: SizedBox(
                        height: 100,
                        child: _recentFiles.isEmpty
                            ? _buildDefaultImage()
                            : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _recentFiles.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, index) => _buildImageItem(_recentFiles[index]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: 'Folders',
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('78 files, 0 folders'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: 'Files',
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _allFiles.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) return _buildAddButton();
                          return _buildImageItem(_allFiles[index - 1]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Fixed Apply Button at bottom
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (selectedFile != null) {
                  Navigator.pop(context, selectedFile);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a file')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultImage() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 40, color: Colors.grey),
      ),
    );
  }

  Widget _buildImageItem(File file) {
    final isSelected = selectedFile == file;
    return GestureDetector(
      onTap: () => setState(() => selectedFile = file),
      child: Container(
        decoration: BoxDecoration(
          border: isSelected
              ? Border.all(color: Colors.blue, width: 3)
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(file, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _addImage,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 40, color: Colors.black),
        ),
      ),
    );
  }
}