import 'dart:io';

import 'package:aplikasi_budaya/core/theme/app_color.dart';
import 'package:aplikasi_budaya/core/theme/app_styles.dart';
import 'package:aplikasi_budaya/data/models/historian.dart';
import 'package:aplikasi_budaya/data/repositories/historian_repo.dart';
import 'package:aplikasi_budaya/presentation/widgets/app_bar.dart';
import 'package:aplikasi_budaya/presentation/widgets/button.dart';
import 'package:aplikasi_budaya/presentation/widgets/radio.dart';
import 'package:aplikasi_budaya/presentation/widgets/text_field.dart';
import 'package:aplikasi_budaya/utils/constant.dart';
import 'package:aplikasi_budaya/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateHistorianPage extends StatefulWidget {
  final Historian data;
  const UpdateHistorianPage({super.key, required this.data});

  @override
  State<UpdateHistorianPage> createState() => _UpdateHistorianPageState();
}

class _UpdateHistorianPageState extends State<UpdateHistorianPage> {
  final HistorianRepository _historianRepo = HistorianRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _nameError = '',
      _dateOfBirthError = '',
      _fromError = '',
      _descriptionError = '';

  File? _image;
  bool _isLoading = false, _isImagePicked = false;
  String _gender = 'Laki-laki';

  bool _isValid() =>
      _nameError.isEmpty &&
      _dateOfBirthError.isEmpty &&
      _fromError.isEmpty &&
      _descriptionError.isEmpty;

  _validate() {
    setState(() {
      _nameError =
          _nameController.text.isEmpty ? 'Nama tidak boleh kosong' : '';
      _dateOfBirthError = _dateOfBirthController.text.isEmpty
          ? 'Tanggal lahiridak boleh kosong'
          : '';
      _fromError =
          _fromController.text.isEmpty ? 'Asal tidak boleh kosong' : '';
      _descriptionError = _descriptionController.text.isEmpty
          ? 'Deskripsi tidak boleh kosong'
          : '';
    });
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _isImagePicked = true;
      });
    }
  }

  Future<void> _updateHistorian() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String image = _image == null ? widget.data.image : _image!.path;
      final Historian historian = Historian(
        id: widget.data.id,
        name: _nameController.text,
        dateOfBirth: _dateOfBirthController.text,
        from: _fromController.text,
        description: _descriptionController.text,
        gender: _gender,
        image: image,
      );

      final res =
          await _historianRepo.updateHistorian(historian, _isImagePicked);

      setState(() {
        _isLoading = false;
        showSnackbar(context, res.message);
        Navigator.pushReplacementNamed(
          context,
          '/historian',
          arguments: res.data.first,
        );
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
    _nameController.text = widget.data.name;
    _fromController.text = widget.data.from;
    _dateOfBirthController.text = widget.data.dateOfBirth;
    _descriptionController.text = widget.data.description;
    _gender = widget.data.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColors.surface,
            backButtonCallback: () {
              Navigator.pushReplacementNamed(
                context,
                '/list',
                arguments: ListType.historian,
              );
            },
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: ListView(
        children: [
          Center(child: _buildImage()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Profile",
                  style: AppStyles.title.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                _buildDetailItem(
                  label: "Nama",
                  controller: _nameController,
                  errorText: _nameError,
                ),
                _buildDetailItem(
                  label: "Asal",
                  controller: _fromController,
                  errorText: _fromError,
                ),
                _buildDetailItem(
                  label: "Tanggal Lahir",
                  controller: _dateOfBirthController,
                  errorText: _dateOfBirthError,
                ),
                Text("Jenis Kelamin :", style: AppStyles.subtitle),
                Row(
                  children: [
                    CustomRadio(
                      value: 'Laki-laki',
                      groupValue: _gender,
                      label: 'Laki-laki',
                      onChanged: (value) {
                        setState(() {
                          _gender = 'Laki-laki';
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    CustomRadio(
                      value: 'Perempuan',
                      groupValue: _gender,
                      label: 'Perempuan',
                      onChanged: (value) {
                        setState(() {
                          _gender = 'Perempuan';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  "Tentang Profile",
                  style: AppStyles.title.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  height: 256,
                  color: AppColors.surface,
                  controller: _descriptionController,
                  textStyle: AppStyles.body,
                  hintText: "Deskripsi",
                  hintStyle: AppStyles.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  errorText: _descriptionError,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  onChanged: (value) => _validate(),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: "Submit",
                  enabled: !_isLoading,
                  onTap: () {
                    _validate();
                    if (_isValid()) {
                      _updateHistorian();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipOval(
                child: !_isImagePicked
                    ? Image.network(
                        widget.data.image.getImageUrl(),
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        _image!,
                        width: 128,
                        height: 128,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(.5),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _pickImage,
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.secondary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required TextEditingController controller,
    required String errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label :", style: AppStyles.subtitle),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          errorText: errorText,
          hintText: label,
          onChanged: (value) => _validate(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
