import 'package:flutter/material.dart';

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
  final TextEditingController establishmentYearController =
      TextEditingController();

  String selectedOutlet = 'OUT010'; // Default to a valid identifier
  String selectedSize = 'Large'; // Default to a valid size
  String selectedType = 'Supermarket Type1'; // Default to a valid type

  String result = '';

  void showResult() {
    // Placeholder for prediction logic
    double dummyPrediction = 1000.0; // Replace with model prediction logic
    setState(() {
      result = 'Predicted Sales: \$${dummyPrediction.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Prediction',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.blue[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item Price",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: itemMRPController,
                    decoration: InputDecoration(
                      hintText: 'Enter item price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  // Store Identifier
                  Text(
                    "Store Identifier",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedOutlet,
                    onChanged: (value) {
                      setState(() {
                        selectedOutlet = value!;
                      });
                    },
                    items: [
                      'OUT010',
                      'OUT013',
                      'OUT017',
                      'OUT018',
                      'OUT019',
                      'OUT027',
                      'OUT035',
                      'OUT045',
                      'OUT046',
                      'OUT049'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Store Size
                  Text(
                    "Store Size",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedSize,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value!;
                      });
                    },
                    items: ['Large', 'Medium', 'Small']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Store Type
                  Text(
                    "Grocery Store Type",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    items: [
                      'Supermarket Type1',
                      'Supermarket Type2',
                      'Supermarket Type3'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Establishment Year
                  Text(
                    "Outlet Establishment Year",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: establishmentYearController,
                    decoration: InputDecoration(
                      hintText: 'Enter year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30),
                  // Predict Button
                  SizedBox(
                    width: double.infinity, // Full-width button
                    child: ElevatedButton(
                      onPressed: showResult,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Predict',
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              Colors.white, // Change this to the desired color
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
}
