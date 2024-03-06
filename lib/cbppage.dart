import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'CBMCalculatorController.dart';

class CBMCalculatorPage extends StatelessWidget {
  CBMCalculatorPage({Key? key});

  final CBMCalculatorController controller = Get.put(CBMCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<CBMCalculatorController>(
        builder: (controller) => 
         Container(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            decoration:                                                                                                                                                       BoxDecoration(
              image: DecorationImage(
                  image: controller.inputMode == InputMode.Dimensions ?  const AssetImage('assets/background.jpg') :  const AssetImage('assets/background4.jpg'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    // Toggle input mode dropdown
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<InputMode>(
                            style: const TextStyle(color: Color.fromARGB(255, 186, 100, 100),fontWeight: FontWeight.w500,),
                            value: controller.inputMode,
                            onChanged: (mode) {
                              if (mode != null) {
                                controller.toggleInputMode(mode);
                              }
                            },
                            items: const [
                              DropdownMenuItem(
                                value: InputMode.Dimensions,
                                child: Row(
                                  
                                  children: [
                                    Icon(Icons
                                        .edit,color: Colors.black,), // يمكنك تغيير الرمز حسب الرغبة
                                    SizedBox(width: 10),
                                    Text("Enter Dimensions"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: InputMode.CBM,
                                child: Row(
                                  children: [
                                    Icon(Icons
                                        .calculate,color: Colors.black,), // يمكنك تغيير الرمز حسب الرغبة
                                    SizedBox(width: 10),
                                    Text("Enter CBM"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        
                      ],
                    ),
        
                    const SizedBox(height: 10),
                    // Build input fields based on input mode
                    if (controller.inputMode == InputMode.Dimensions)
                      Column(
                        children: [
                          _buildInputField(
                              controller.lengthController, 'Length (cm)'),
                          const SizedBox(height: 10),
                          _buildInputField(
                              controller.widthController, 'Width (cm)'),
                          const SizedBox(height: 10),
                          _buildInputField(
                              controller.heightController, 'Height (cm)'),
                          const SizedBox(height: 30),
                        ],
                      ),
                    if (controller.inputMode == InputMode.CBM)
                      Column(
                        children: [
                          _buildInputField(
                              controller.cbmController, 'CBM'), // CBM input field
                          const SizedBox(height: 30),
                        ],
                      ),
                    _buildInputField(controller.qtyController, 'Qty'),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildInputFieldwight(
                        controller.weightController, 'Weight (kg)'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => controller.calculateCBM(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 255, 255)),
                        elevation: MaterialStateProperty.all<double>(8.0),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(15.0)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text('Calculate',
                          style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(height: 90),
                    _buildResultText(),
                    const SizedBox(height: 3),
                    _buildIncreaseCBMText(),
                    const SizedBox(height: 3),
                    _buildIncreaseWeightText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText) {
    return Opacity(
      opacity: 0.8,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            color: Color.fromARGB(255, 243, 243, 243),
            fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 20, 19, 19),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 5, 4, 4).withOpacity(0.5),
                width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldwight(
      TextEditingController controller, String labelText) {
    return Opacity(
      opacity: 0.8,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(
            color: Color.fromARGB(255, 243, 243, 243),
            fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 95, 48, 48),
          labelText: labelText,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 46, 63, 78), width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 5, 4, 4).withOpacity(0.5),
                width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildResultText() {
    return GetBuilder<CBMCalculatorController>(
      builder: (controller) {
        if (controller.result > 0.0) {
          return GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(
                  text:
                      'CBM Result: ${controller.result.toStringAsFixed(controller.result.truncateToDouble() == controller.result ? 0 : 3)} Cbm'));
              // You can also add a notification or confirmation message here
            },
            child: Card(
              color: Colors.black.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectableText(
                  'CBM Result: ${controller.result.toStringAsFixed(controller.result.truncateToDouble() == controller.result ? 0 : 3)} Cbm',
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildIncreaseCBMText() {
    return GetBuilder<CBMCalculatorController>(
      builder: (controller) {
        return controller.increaseCbm > 0.0
            ? GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                      text:
                          'Overweight (CBM): ${controller.increaseCbm.toStringAsFixed(controller.increaseCbm.truncateToDouble() == controller.increaseCbm ? 0 : 3)} Cbm'));
                  // You can also add a notification or confirmation message here
                },
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      'Overweight (CBM): ${controller.increaseCbm.toStringAsFixed(controller.increaseCbm.truncateToDouble() == controller.increaseCbm ? 0 : 3)} Cbm',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 226, 226)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildIncreaseWeightText() {
    return GetBuilder<CBMCalculatorController>(
      builder: (controller) {
        return controller.increaseWeight > 0.0
            ? GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                      text:
                          'Overweight (Weight): ${controller.increaseWeight.toStringAsFixed(controller.increaseWeight.truncateToDouble() == controller.increaseWeight ? 0 : 3)} kg'));
                  // You can also add a notification or confirmation message here
                },
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      'Overweight (Weight): ${controller.increaseWeight.toStringAsFixed(controller.increaseWeight.truncateToDouble() == controller.increaseWeight ? 0 : 3)} kg',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 251, 102, 75),
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
