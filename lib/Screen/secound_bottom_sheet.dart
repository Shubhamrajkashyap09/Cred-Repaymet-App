import 'package:flutter/material.dart';

class SecoundBottomSheetContent extends StatefulWidget {
  @override
  _SecoundBottomSheetContentState createState() =>
      _SecoundBottomSheetContentState();
}

class _SecoundBottomSheetContentState extends State<SecoundBottomSheetContent> {
  bool isSelected = false; // Track selection status

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
              'Where should we send the money?',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              'amount will be credited to this bank account, EMI will also be debited from this bank account',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/hdfc_logo.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'HDFC Bank',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        '50100117009192',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      isSelected ? Icons.check : Icons.circle_outlined,
                      color: isSelected ? Colors.white : Colors.blue,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Change account',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context);
                    print("Proceed button pressed!");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.all(15),
                  ),
                  child: Text(
                    "Tap for 1-click KYC",
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
}
