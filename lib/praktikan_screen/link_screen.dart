import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/praktikan_screen/pelaksanaan_screen.dart';
import 'package:smartcare_web/praktikan_screen/riwayat_nilai_screen.dart';
import 'package:video_player/video_player.dart';
// import 'package:web_socket_channel/io.dart';
import 'daftar_praktikum_screen.dart';
import 'package:chewie/chewie.dart';
import 'dart:async';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

class LinkScreen extends StatefulWidget {
  const LinkScreen({Key? key}) : super(key: key);

  @override
  _LinkScreenState createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  late CameraController controller;
  late List<CameraDescription> _cameras;
  late VideoPlayerController videoPlayerController;
  // late ChewieController chewieController;

  bool isPin1 = false;
  bool isPin2 = false;
  bool isPin3 = false;
  bool isPin4 = false;
  bool isPin5 = false;
  bool isPin6 = false;
  bool isPin7 = false;
  bool isPin8 = false;
  bool isPin9 = false;
  bool isPin10 = false;
  bool isPin11 = false;
  bool isPin12 = false;
  bool isPin13 = false;
  bool isPin14 = false;
  bool isPin15 = false;
  bool isPin16 = false;
  bool isPin17 = false;
  bool isPin18 = false;
  bool isPin19 = false;
  bool isPin20 = false;
  bool isPin21 = false;
  bool isPin22 = false;
  bool isPin23 = false;
  bool isPin24 = false;
  final urlGPIO = 'http://192.168.18.223:8000/gpio';

  // void streamVideo() {
  //   final videoElement = VideoElement();
  //   const videoUrl =
  //       'http://192.168.18.223:8000/video_feed'; // Update with the correct URL

  //   videoElement.src = videoUrl;
  //   videoElement.autoplay = true;
  //   videoElement.controls = true;

  //   document.body?.children.add(videoElement);
  // }

  void turnOnGPIO({required String led}) async {
    final url = urlGPIO;
    final headers = {'Content-Type': 'application/json'};
    final body = '{"action": "on", "led": "$led"}';

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('GPIO turned on successfully');
    } else {
      print('Failed to turn on GPIO');
    }
  }

  void turnOffGPIO({required String led}) async {
    final url = urlGPIO;
    final headers = {'Content-Type': 'application/json'};
    final body = '{"action": "off", "led": "$led"}';

    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      print('GPIO turned off successfully');
    } else {
      print('Failed to turn off GPIO');
    }
  }

  @override
  void initState() {
    super.initState();

    // Obtain available camera on raspberry pi.
    // Initialize the videoPlayerController and chewieController here
    videoPlayerController = VideoPlayerController.network(
      'http://192.168.18.223:8000/video_feed',
    )..initialize().then((_) {
        setState(() {}); // Ensure the widget rebuilds after initialization
      });

    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   autoPlay: true,
    //   looping: true,
    // );

    // Obtain a list of the available cameras on the device.
    availableCameras().then((cameras) {
      setState(() {
        _cameras = cameras;
        controller = CameraController(_cameras[0], ResolutionPreset.max);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        }).catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    videoPlayerController.dispose();
    // chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain a list of the available cameras on the device.
    final cameras = availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ProjectColors.darkBlack,
        actions: [
          MaterialButton(
            child: Image.asset(
              'lib/assets/logo its.png',
              scale: 0.5,
              width: 50,
            ),
            onPressed: () {
              Get.to(const LinkScreen());
            },
          ),
          const SizedBox(
            width: 20,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/logoptki.png',
              scale: 0.5,
              width: 200,
            ),
            onPressed: () {
              Get.to(const LinkScreen());
            },
          ),
          const SizedBox(
            width: 100,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Daftar Praktikum.png',
              scale: 0.5,
              width: 100,
            ),
            onPressed: () {
              Get.to(const DaftarPraktikumScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Pelaksanaan.png',
              scale: 0.5,
              width: 80,
            ),
            onPressed: () {
              Get.to(const PelaksanaanScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Riwayat Nilai.png',
              scale: 0.5,
              width: 80,
            ),
            onPressed: () {
              Get.to(const RiwayatNilaiScreen());
            },
          ),
          const SizedBox(
            width: 200,
          ),
          const SizedBox(
            width: 100,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    color: Colors.teal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(""),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin1,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin1 = val;
                            });

                            final led =
                                "4"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin2,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin2 = val;
                            });

                            final led =
                                "17"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin3,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin3 = val;
                            });

                            final led =
                                "22"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin4,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin4 = val;
                            });

                            final led =
                                "13"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin5,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin5 = val;
                            });

                            final led =
                                "19"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin6,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin6 = val;
                            });

                            final led =
                                "6"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin7,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin7 = val;
                            });

                            final led =
                                "13"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin8,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin8 = val;
                            });

                            final led =
                                "8"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 100,
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                        height: 200,
                        width: 500,
                        color: Colors.tealAccent,
                        child: VideoPlayer(videoPlayerController)
                        // videoPlayerController.value.isInitialized
                        // ? AspectRatio(
                        //     aspectRatio:
                        //         videoPlayerController.value.aspectRatio,
                        //     child: VideoPlayer(videoPlayerController),
                        //   )
                        // : const CircularProgressIndicator(),
                        ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(s
                  //           builder: (context) =>  VideoPlayerScreen(),
                  //       );
                  //     },

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 500,
                    height: 215,
                    color: Colors.tealAccent,
                    child: (!controller.value.isInitialized)
                        ? Container()
                        : CameraPreview(controller),
                  ),

                  // CustomButton(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  //   color: ProjectColors.blue,
                  //   child: const Text(
                  //     "Send",
                  //     style: TextStyle(fontSize: 12),
                  //   ),
                  //   onTap: () {
                  //     // Navigator.push(
                  //     // context,
                  //     // MaterialPageRoute(
                  //     // builder: (context) => GPIO_Screen()));
                  //   },
                  // )
                ],
              ),
              const SizedBox(
                width: 100,
              ),
              Stack(
                children: [
                  Container(
                    width: 150,
                    color: Colors.teal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(""),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin9,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin9 = val;
                            });

                            final led =
                                "9"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin10,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin10 = val;
                            });

                            final led =
                                "10"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin11,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin11 = val;
                            });

                            final led =
                                "11"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin12,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin12 = val;
                            });

                            final led =
                                "12"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin13,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin13 = val;
                            });

                            final led =
                                "13"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin14,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin14 = val;
                            });

                            final led =
                                "14"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin15,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin15 = val;
                            });

                            final led =
                                "15"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: AnimatedToggleSwitch<bool>.dual(
                          current: isPin16,
                          first: false,
                          second: true,
                          dif: 2.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 35,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) async {
                            setState(() {
                              isPin16 = val;
                            });

                            final led =
                                "16"; // Replace with the desired LED value

                            if (val) {
                              turnOnGPIO(led: led);
                            } else {
                              turnOffGPIO(led: led);
                            }

                            await Future.delayed(const Duration(seconds: 2));
                          },
                          colorBuilder: (val) =>
                              val ? Colors.green : Colors.red,
                          iconBuilder: (val) => val
                              ? const Text(
                                  'ON',
                                  style: TextStyle(color: Colors.white),
                                )
                              : const Text(
                                  'OFF',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Video Player'),
      // ),
      body: Flexible(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse('http://192.168.18.223:8000/video_feed')),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}

// class MyWebSocketScreen extends StatefulWidget {
//   @override
//   _MyWebSocketScreenState createState() => _MyWebSocketScreenState();
// }

// class _MyWebSocketScreenState extends State<MyWebSocketScreen> {
//   final channel = IOWebSocketChannel.connect('wss://your-websocket-url');

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 200,
//         width: 500,
//         color: Colors.tealAccent,
//         child: StreamBuilder(
//           stream: channel.stream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               // Display WebSocket data
//               return Text(snapshot.data.toString());
//             } else if (snapshot.hasError) {
//               // Handle WebSocket error
//               return Text('Error: ${snapshot.error}');
//             } else {
//               // WebSocket connection is being established
//               return Text('Connecting...');
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }
// }
