import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidget createState() => _BottomSheetWidget();
}

class _BottomSheetWidget extends State<BottomSheetWidget> {
  String _details;
  bool success = false;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onVerticalDragStart: (_) { },
        child: Container(
          height: 185,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.grey[300],
                spreadRadius: 5
              )
            ]
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  autocorrect: false,
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: 500,
                  decoration: InputDecoration.collapsed(hintText: 'Please tell us the details'),
                  onChanged: (val) {
                    _details = val;
                  },
                ),
              ),
              !pressed ? MaterialButton(
                color: Colors.grey[800],
                onPressed: () async {
                  setState(() {
                    pressed = true;
                  });
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {
                    success = true;
                  });

                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pop(context, _details);
                },
                child: Text(
                  'Send',
                  style: TextStyle(color: Colors.white),
                ),
              ) : !success ? CircularProgressIndicator() : Icon(
                Icons.check,
                color: Colors.green
              ),
            ],
          )
        )
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom
      ),
    );
  }
}
