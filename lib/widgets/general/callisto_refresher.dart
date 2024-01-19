import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jupiter_frontend/services/api_manager.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';

class CPullDownRefresh extends StatefulWidget {
  Widget child;
  CPullDownRefresh({super.key, required this.child});

  @override
  State<CPullDownRefresh> createState() => _CPullDownRefreshState();
}

class _CPullDownRefreshState extends State<CPullDownRefresh> {

  Future<void> _fetchData() async {
    var apiMgrInstance = await CApiManager.getInstance();
    Response data = await apiMgrInstance.getJupiterData(CSharedPrefs().osis!, CSharedPrefs().password!);
    await CDbManager.getInstance().storeApiResponse(data.body);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: widget.child,
      onRefresh: _fetchData,
    );
  }
}