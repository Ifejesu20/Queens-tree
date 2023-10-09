import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/prediction/data/models/prediction_model.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/components/bottom_sheet_widget.dart';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../constants.dart';
import '../../../data/models/prediction_model.dart';
import '../../components/bottom_sheet_widget.dart';
import '../prediction/prediction_controller.dart';

class PreviewPage extends StatefulWidget {
  final String uid;
  final DocumentSnapshot snapshot;

  PreviewPage({@required this.uid, @required this.snapshot});

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends ModularState<PreviewPage, PredictionController> {
  bool liked = false;
  bool disliked = false;
  bool btnDisabled = false;
  bool showResults = true;
  Map<String, dynamic> _document;

  void _like() {
    setState(() {
      btnDisabled = true;
      liked = true;
    });
  }

  _dislike(context) {
    setState(() {
      btnDisabled = true;
      disliked = true;
      showResults = false;
    });

    showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      context: context,
      builder: (context) => BottomSheetWidget()
    ).then((value) => {
      setState(() {
        showResults = true;
      }),

      _document = new PredictionModel(
        user: widget.snapshot['user'],
        imageUrl: widget.snapshot['imageUrl'],
        predicted: widget.snapshot['predicted'],
        confidence: widget.snapshot['confidence'],
        isCorrect: false,
        details: value,
        isHidden: widget.snapshot['isHidden']
      ).toDocument(),
      controller.updatePredictionUseCase(widget.snapshot.id, _document)
    });
  }

  Future<bool> _onWillPop() async {
    Modular.to.pushNamed('/feed/', arguments: {"uid": widget.uid});
    return true;
  }

  Widget _appBar() {
    return new AppBar(
      backgroundColor: primaryColor,
      leading: new IconButton(
        icon: new Icon(Icons.close),
        iconSize: 30,
        color: Colors.white,
        onPressed: () => Navigator.of(context).pop()
      ),
    );
  }

  Widget _imageSection(String imagePath) {
    return Expanded(
        flex: 2,
        child: Image.network(imagePath, fit: BoxFit.cover)
    );
  }

  Widget _resultTexts(DocumentSnapshot documentSnapshot) {
    num confidence = documentSnapshot['confidence'] * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${documentSnapshot['predicted']}",
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Probability: " + confidence.toStringAsFixed(2) + "%",
          style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  Widget _feedBackButtons(context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
              liked ? Icons.thumb_up : Icons.thumb_up_outlined,
              color: liked ? Colors.green : Colors.green
          ),
          onPressed: () => btnDisabled ? null : _like(),
        ),
        IconButton(
          icon: Icon(
              disliked ? Icons.thumb_down : Icons.thumb_down_outlined,
              color: disliked ? Colors.red : Colors.red
          ),
          onPressed: () => btnDisabled ? null : _dislike(context),
        ),
      ],
    );
  }

  Widget _resultSection(DocumentSnapshot documentSnapshot, context) {
    return showResults ? Column(
      children: <Widget>[
        Center(
          child: Container(
            color: primaryColor,
            child: Container(
              alignment: Alignment.topLeft,
              color: primaryColor,
              margin: new EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 30.0),
              child: Text(
                "Plant predicted",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            color: primaryColor,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              color: Colors.white,
              height: 80.0,
              margin: new EdgeInsets.symmetric(
                vertical: 40.0, horizontal: 30.0),
              child: Row(
                children: <Widget>[
                  _resultTexts(documentSnapshot),
                  SizedBox(width: 70.0),
                  _feedBackButtons(context),
                ],
              ),
            ),
          ),
        ),
      ],
    ) : Container(color: primaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      top: false,
      bottom: false,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: _appBar(),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _imageSection(widget.snapshot['imageUrl']),
                _resultSection(widget.snapshot, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}