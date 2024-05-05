import 'package:aplikasi_budaya/data/repositories/image_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final ImageRepository _repository = ImageRepository();
  List<String> _imagesUrl = [];
  bool _isLoading = true;

  Future<void> _getImages() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await _repository.getImages();
      setState(() {
        _imagesUrl = res.map((e) => e.getImageUrl()).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        showSnackbar(context, e.toString().getExceptionMessage());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent());
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: _isLoading ? buildLoadingView() : _buildBody(),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return GridView.builder(
      itemCount: _imagesUrl.length,
      padding: const EdgeInsets.all(32),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.assetNetwork(
            placeholder: imagePlaceholder,
            image: _imagesUrl[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
