import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum InputMode { Dimensions, CBM }

class CBMCalculatorController extends GetxController {
  late TextEditingController lengthController;
  late TextEditingController widthController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController qtyController;
  late TextEditingController cbmController; // Controller for CBM input
  var result = 0.0;
  var increaseCbm = 0.0;
  var increaseWeight = 0.0;
  var inputMode = InputMode.Dimensions;

  @override
  void onInit() {
    toggleInputMode(InputMode.Dimensions);
    lengthController = TextEditingController();
    widthController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    qtyController = TextEditingController();
    cbmController = TextEditingController(); // Initialize CBM controller
    super.onInit();
  }

  @override
  void onClose() {
    lengthController.dispose();
    widthController.dispose();
    heightController.dispose();
    weightController.dispose();
    qtyController.dispose();
    cbmController.dispose(); // Dispose CBM controller
    super.onClose();
  }

  void calculateCBM() {
    double length = double.tryParse(lengthController.text) ?? 0.0;
    double width = double.tryParse(widthController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;
    int qty = int.tryParse(qtyController.text) ?? 1;
    double cbmInput = double.tryParse(cbmController.text) ?? 0.0; // Get CBM input

    double cbm;
    if (inputMode == InputMode.Dimensions) {
      cbm = (length * width * height / 1000000) * qty;
    } else {
      cbm = cbmInput * qty; // Use CBM input directly
    }

    double adjustedCBM = (weight / 500) * qty;
    double weightIncrease = weight - (cbm * 500 / qty);

    if (adjustedCBM > cbm) {
      playSound();
      result = adjustedCBM;
      increaseCbm = adjustedCBM - cbm;
      increaseWeight = weightIncrease * qty;
    } else {
      result = cbm;
      increaseCbm = 0.0;
      increaseWeight = 0.0;
    }

    update();
  }

  void updatee() {
    return update();
  }

  void toggleInputMode(InputMode mode) {
   
    inputMode = mode;
    update();
  }

  playSound() async {
    AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
    await audioPlayer.open(
      Audio(
        'assets/gallina.mp3',
      ),
    );
  }
}
