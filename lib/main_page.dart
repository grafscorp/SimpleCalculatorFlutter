// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:calcul/additional_widgets.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class main_page extends StatefulWidget {
  const main_page({super.key});

  @override
  State<StatefulWidget> createState() {
    return page();
  }
}

class page extends State<main_page> {
  bool is_snd_active = true;
  final snd = AudioPlayer();
  var text_field_controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    text_field_controller.text = "0";
  }

  // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
  Widget btn_spawn(String _text, Color _color_btn, Color _text_color) {
    return SizedBox(
      height: 90,
      width: 90,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: _color_btn,
            padding: EdgeInsets.all(20),
            side: BorderSide(color: Colors.black, width: 2)),
        onPressed: () {
          play_sound();

          setState(() {
            switch (_text) {
              case "AC":
                text_field_controller.text = "0";
                break;
              case "=":
                //if last symbol is operator, its remove
                if (int.tryParse(text_field_controller.text
                        .substring(text_field_controller.text.length - 1)) ==
                    null) {
                  text_field_controller.text = text_field_controller.text
                      .substring(0, text_field_controller.text.length - 1);
                }
                try {
                  var res = eval(text_field_controller.text);
                  if (res % 1 == 0) {
                    text_field_controller.text = res.toInt().toString();
                  } else {
                    text_field_controller.text = res.toString();
                  }
                } catch (e) {
                  text_field_controller.text = "0";
                }

                break;
              case "^":
                break;
              default:
                if ((text_field_controller.text == "0") ||
                    (text_field_controller.text == 'Infinity')) {
                  if (int.tryParse(_text) != null)
                    text_field_controller.text = _text;
                } else {
                  //*!TODO
                  if (int.tryParse(_text) == null) {
                    //if enter is '(' or ')'
                    if ((_text == '(' || _text == ')')) {
                      if (int.tryParse(text_field_controller.text.substring(
                              text_field_controller.text.length - 1)) !=
                          null) {
                        if (_text == ')') text_field_controller.text += _text;
                      } else if ((_text == ')' &&
                          (int.tryParse(text_field_controller.text.substring(
                                  text_field_controller.text.length - 1)) ==
                              null))) {
                        text_field_controller.text += _text;
                      }
                      break;
                    }
                    // if last symbol is operator and enter is operator they are replace
                    else if (int.tryParse(text_field_controller.text.substring(
                            text_field_controller.text.length - 1)) ==
                        null) {
                      text_field_controller.text = text_field_controller.text
                          .substring(0, text_field_controller.text.length - 1);
                    }
                  }
                  text_field_controller.text += _text;
                  break;
                }
              // if last symbol is operator and enter is operator they are replace
              //   else if (((int.tryParse(_text) == null) &&
              //           (_text != ')' || _text != '(')) &&
              //       int.tryParse(text_field_controller.text.substring(
              //               text_field_controller.text.length - 1)) ==
              //           null) {
              //     text_field_controller.text = text_field_controller.text
              //         .substring(0, text_field_controller.text.length - 1);
              //   }
              //   text_field_controller.text += _text;
              // }
              // break;
            }
          });
        },
        child: Text(
          _text,
          style: btn_textstyle(_text_color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caclulator Nagibator"),
        centerTitle: true,
        leading: const Icon(Icons.calculate),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          //Sound Button
          IconButton(
              onPressed: () {
                setState(() {
                  is_snd_active = !is_snd_active;
                  play_sound();
                });
              },
              icon: Icon(is_snd_active ? Icons.music_note : Icons.music_off)),
        ],
      ),
      body: Center(
        child: background_paint(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      //height: 120,
                      width: 300,
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                        controller: text_field_controller,
                        decoration: const InputDecoration(
                          // ignore: unnecessary_const
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  // ignore: unnecessary_const
                                  const BorderRadius.all(Radius.circular(20))),
                          // ignore: unnecessary_const
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  // ignore: unnecessary_const
                                  const BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    //SizedBox(
                    //  child:
                    IconButton(
                        onPressed: () {
                          play_sound();
                          if (text_field_controller.text.length > 1) {
                            text_field_controller.text =
                                text_field_controller.text.substring(
                                    0, text_field_controller.text.length - 1);
                          } else {
                            text_field_controller.text = "0";
                          }
                        },
                        icon: Icon(
                          Icons.backspace,
                          color: Colors.grey,
                          size: 45,
                        )),
                    SizedBox(
                      width: 20,
                    )
                    //),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                ///BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn_spawn("AC", Colors.grey, Colors.black),
                    btn_spawn("(", Colors.yellow, Colors.black),
                    btn_spawn(")", Colors.yellow, Colors.black),
                    btn_spawn("^", Colors.yellow, Colors.black),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn_spawn("7", Colors.white, Colors.black),
                    btn_spawn("8", Colors.white, Colors.black),
                    btn_spawn("9", Colors.white, Colors.black),
                    btn_spawn("+", Colors.yellow, Colors.black),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn_spawn("4", Colors.white, Colors.black),
                    btn_spawn("5", Colors.white, Colors.black),
                    btn_spawn("6", Colors.white, Colors.black),
                    btn_spawn("-", Colors.yellow, Colors.black),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn_spawn("1", Colors.white, Colors.black),
                    btn_spawn("2", Colors.white, Colors.black),
                    btn_spawn("3", Colors.white, Colors.black),
                    btn_spawn("*", Colors.yellow, Colors.black),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn_spawn(".", Colors.grey, Colors.black),
                    btn_spawn("0", Colors.white, Colors.black),
                    btn_spawn("=", Colors.yellow, Colors.black),
                    btn_spawn("/", Colors.yellow, Colors.black),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void play_sound() {
    if (!is_snd_active) return;
    snd.play(AssetSource("click_snd.wav"));
  }
}
