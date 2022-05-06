
import 'package:example/provider_sample/provider_sample_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderSamplePage extends StatelessWidget {
  const ProviderSamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("ProviderSamplePage");
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProviderSamplePage"),
      ),
      body: Text(context.read<ProviderSampleViewModel>().body ?? ""),
    );
  }
}