import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../data/localStroreg/localdataRepo.dart';
import '../data/remote/repostroy.dart';
import '../moudel/QusteionMoudel.dart';
import '../utils/Compants.dart';
import 'QusetionDetislScreen.dart';

class QuseteionScrreen extends StatefulWidget {
  const QuseteionScrreen({Key? key}) : super(key: key);

  @override
  State<QuseteionScrreen> createState() => _QuseteionScrreenState();
}

class _QuseteionScrreenState extends State<QuseteionScrreen> {
  //Steps To Check The Internt
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
  //End of Steps

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: FutureBuilder<QusteionMoudel>(
              future: Respostry.fetchQusteionMoudel(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Items> items = snapshot.data!.items!;

                  return LazyLoadScrollView(
                    isLoading: Respostry.isLoading.value,
                    onEndOfPage: () => Respostry.loadMore(),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return QustionIndex(items[index]);
                      },
                    ),
                  );
                }

                // snapshot.hasError mean is Internt are  is down
                if (snapshot.hasError) {
                  // print(snapshot.error.toString());
                  //We check Coonection Intenrnt
                  if (_connectionStatus != ConnectivityResult.wifi ||
                      _connectionStatus != ConnectivityResult.mobile ||
                      _connectionStatus != ConnectivityResult.ethernet) {
                    //Here We load our Data form SharedPreffnes
                    Respostry.loadSharedPrefs();
                    QusteionMoudel quteno = LoactDataRepo.qusteionMoudel;
                    if (quteno.items != null) {
                      return ListView.builder(
                        itemCount: quteno.items?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return QustionIndex(quteno.items![index]);
                        },
                      );
                    } else {
                      return Text('error');
                    }
                  }

                }

                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
