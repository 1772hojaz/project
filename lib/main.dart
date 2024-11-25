import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(SalesPredictionApp());
}

class SalesPredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      home: SalesPredictionHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SalesPredictionHome extends StatefulWidget {
  @override
  _SalesPredictionHomeState createState() => _SalesPredictionHomeState();
}

class _SalesPredictionHomeState extends State<SalesPredictionHome> {
  final TextEditingController itemMRPController = TextEditingController();
  final TextEditingController outletYearsController = TextEditingController();

  String result = '';
  String selectedOutletSize = "small";
  String selectedOutletLocationType = "Tier1";
  String selectedOutletType = "0";
  String selectedNewItemType = "Food";

  final List<String> outletSizes = ["small", "medium", "large"];
  final List<String> outletLocationTypes = ["Tier1", "Tier2", "Tier3"];
  final List<String> outletTypes = ["0", "1", "2", "3"];
  final List<String> newItemTypes = ["Food", "Drinks", "Non-Consumable"];

  Future<void> showResult() async {
    try {
      final itemMRP = double.tryParse(itemMRPController.text);
      final outletYears = int.tryParse(outletYearsController.text);

      if (itemMRP == null || outletYears == null) {
        setState(() {
          result = 'Please enter valid numeric values for all fields.';
        });
        return;
      }

      // Map Outlet_Size values to integers
      final outletSizeMapping = {
        "small": 1,
        "medium": 2,
        "large": 3,
      };

      var requestData = {
        'Item_MRP': itemMRP,
        'Outlet_Size': outletSizeMapping[selectedOutletSize],
        'Outlet_Location_Type':
            outletLocationTypes.indexOf(selectedOutletLocationType) + 1,
        'Outlet_Type': int.parse(selectedOutletType),
        'New_Item_Type': newItemTypes.indexOf(selectedNewItemType) + 1,
        'Outlet_Years': outletYears,
      };

      final response = await http.post(
        Uri.parse('https://regression-model.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        var prediction = json.decode(response.body);
        setState(() {
          result =
              'Predicted Sales: \$${prediction['prediction'].toStringAsFixed(2)}';
        });
      } else {
        setState(() {
          result = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Request failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Prediction'),
        elevation: 0,
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField('Item MRP', 'Enter item MRP',
                      itemMRPController, TextInputType.number),
                  buildInputField('Outlet Years', 'Enter outlet years',
                      outletYearsController, TextInputType.number),
                  buildDropdown('Outlet Size', outletSizes, selectedOutletSize,
                      (newValue) {
                    setState(() {
                      selectedOutletSize = newValue!;
                    });
                  }),
                  buildDropdown('Outlet Location Type', outletLocationTypes,
                      selectedOutletLocationType, (newValue) {
                    setState(() {
                      selectedOutletLocationType = newValue!;
                    });
                  }),
                  buildDropdown(
                      'Outlet Type (0-3)', outletTypes, selectedOutletType,
                      (newValue) {
                    setState(() {
                      selectedOutletType = newValue!;
                    });
                  }),
                  buildDropdown(
                      'New Item Type', newItemTypes, selectedNewItemType,
                      (newValue) {
                    setState(() {
                      selectedNewItemType = newValue!;
                    });
                  }),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: showResult,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Predict',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (result.isNotEmpty)
                    Center(
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, String hint,
      TextEditingController controller, TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
              fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.blue[50],
          ),
          keyboardType: keyboardType,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedItem,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
              fontSize: 16),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: selectedItem,
          isExpanded: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
