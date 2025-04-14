import 'package:cred_first_project/Screen/secound_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatefulWidget {
  final int creditAmount; // Accepting credit amount as a parameter

  BottomSheetContent({
    required this.creditAmount,
  });

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  int selectedIndex = 0; // Track selected option
  late double emi1;
  late double emi2;
  late double emi3;
  late double emi4;

  void _openButtonPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SecoundBottomSheetContent(),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      emi1 = widget.creditAmount / 12;
      emi2 = widget.creditAmount / 9;
      emi3 = widget.creditAmount / 6;
      emi4 = widget.creditAmount / 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How do you wish to repay?',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              'Choose one of our recommended plans or make your own',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            Container(
              height: 150, // Set the height for each grid tile
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: EdgeInsets.only(right: 10),
                    child: _buildOptionTile(
                      label: index == 0
                          ? '₹${emi1.toStringAsFixed(2)} /mo\nfor 12 months'
                          : index == 1
                              ? '₹${emi2.toStringAsFixed(2)} /mo\nfor 9 months'
                              : index == 2
                                  ? '₹${emi3.toStringAsFixed(2)} /mo\nfor 6 months'
                                  : '₹${emi4.toStringAsFixed(2)} /mo\nfor 3 months',
                      index: index,
                      recommended: index == 1,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Create your own plan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity, // Set the width to infinity
                child: ElevatedButton(
                  onPressed: _openButtonPressed,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  child: Text(
                    "Select your bank account",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String label,
    required int index,
    required bool recommended,
  }) {
    bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update selected index
        });
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            if (recommended)
              Positioned(
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'recommended',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
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
