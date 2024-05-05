import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/repositories/culture_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/bottom_navbar.dart';
import 'package:aplikasi_budaya/presentation/widgets/culture_card.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CultureRepository _cultureRepo = CultureRepository();
  final TextEditingController _controller = TextEditingController();
  List<Culture> _cultureList = [];
  bool _isLoading = true, isSearch = false;

  Future<void> getCulture() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await _cultureRepo.getCulture();
      setState(() {
        _cultureList = res.data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        showSnackbar(context, e.toString());
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getCulture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(),
          const Positioned(
            bottom: 0,
            child: BottomNavbar(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            height: 156,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: CustomTextField(
              controller: _controller,
              textStyle: AppStyles.subtitle.copyWith(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              hintText: 'Search for...',
              hintStyle: AppStyles.subtitle.copyWith(
                fontSize: 16,
                color: const Color(0xFFB4BDC4),
              ),
              prefix: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/search.png'),
                  fit: BoxFit.contain,
                )),
              ),
              onChanged: (value) {
                setState(() {
                  isSearch = value.isNotEmpty;
                });
              },
            ),
          ),
          Expanded(
            child: _buildList(
              isSearch ? _cultureList.search(_controller.text) : _cultureList,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(List<Culture> data) {
    return data.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.all(32),
            children: [
              if (!isSearch)
                Text(
                  'Popular',
                  style: AppStyles.title.copyWith(fontSize: 18),
                ),
              const SizedBox(height: 16),
              ...data.map((e) => CultureCard(data: e)),
              const SizedBox(height: 56),
            ],
          )
        : buildEmptyView();
  }
}
