import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/data/models/culture.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/repositories/culture_repo.dart';
import 'package:aplikasi_budaya/data/repositories/historian_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/presentation/widgets/bottom_navbar.dart';
import 'package:aplikasi_budaya/presentation/widgets/culture_card.dart';
import 'package:aplikasi_budaya/presentation/widgets/historian_tile.dart';
import 'package:aplikasi_budaya/presentation/widgets/tab_container.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final ListType? listType;
  const ListPage({super.key, this.listType});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final CultureRepository _cultureRepo = CultureRepository();
  final HistorianRepository _historianRepo = HistorianRepository();
  final TextEditingController _searchController = TextEditingController();
  String _appBarTitle = 'List Berita';
  bool _isLoading = true, isSearch = false, isSearchFieldOpened = false;
  ListType _listType = ListType.culture;
  List<Culture> _cultureList = [];
  List<Historian> _historianList = [];

  getCulture() async {
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

  getHistorian() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await _historianRepo.getHistorian();
      setState(() {
        _historianList = res.data;
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
    if (widget.listType == ListType.historian) {
      _listType = ListType.historian;
      _appBarTitle = 'List Sejarawan';
      getHistorian();
    } else {
      _listType = ListType.culture;
      _appBarTitle = 'List Berita';
      getCulture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildContent(),
          if (_listType == ListType.historian) _buildAddButton(),
          const Positioned(
            bottom: 0,
            child: BottomNavbar(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: _appBarTitle,
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            isSearchFieldOpened = !isSearchFieldOpened;
            isSearch = false;
            _searchController.text = '';
          });
        },
        child: isSearchFieldOpened
            ? const Icon(
                Icons.close_rounded,
                size: 24,
                color: AppColors.secondary,
              )
            : Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/search.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
      backButtonCallback: () {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      },
    );
  }

  Widget _buildContent() {
    List<Culture> cultureList = _cultureList;
    List<Historian> historianList = _historianList;

    if (isSearch) {
      cultureList = cultureList.search(_searchController.text);
      historianList = historianList.search(_searchController.text);
    }

    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(),
          !isSearchFieldOpened ? _buildTab() : _buildSearchField(),
          Expanded(
            child: _listType == ListType.culture
                ? _buildCultureList(cultureList.search(_searchController.text))
                : _buildHistorianList(
                    historianList.search(_searchController.text)),
          )
        ],
      ),
    );
  }

  Widget _buildTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: TabContainer(
              title: 'Berita',
              isActive: _listType == ListType.culture,
              onTap: () async {
                await getCulture();
                setState(() {
                  _listType = ListType.culture;
                  _appBarTitle = 'List Berita';
                });
              },
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: TabContainer(
              title: 'Sejarawan',
              isActive: _listType == ListType.historian,
              onTap: () async {
                await getHistorian();
                setState(() {
                  _listType = ListType.historian;
                  _appBarTitle = 'List Sejarawan';
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    String hintText = _listType == ListType.culture
        ? "Cari berdasarkan judul..."
        : "Cari berdasarkan nama...";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: CustomTextField(
        controller: _searchController,
        hintText: hintText,
        onChanged: (p0) {
          setState(() {
            isSearch = p0.isNotEmpty;
          });
        },
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
      ),
    );
  }

  Widget _buildCultureList(List<Culture> data) {
    return data.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            children: [
              ...data.map((e) => CultureCard(data: e)),
              const SizedBox(height: 56),
            ],
          )
        : buildEmptyView();
  }

  Widget _buildHistorianList(List<Historian> data) {
    return data.isNotEmpty
        ? ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            children: [
              ...data.map((e) => HistorianTile(data: e)),
              const SizedBox(height: 56),
            ],
          )
        : buildEmptyView();
  }

  _buildAddButton() {
    return Positioned(
        bottom: 100,
        right: 32,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/historian/add');
          },
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.add_rounded,
            color: AppColors.textOnPrimary,
          ),
        ));
  }
}
