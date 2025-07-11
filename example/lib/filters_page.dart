import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_filters/video_filters.dart';
import 'package:video_filters/video_filters_api.g.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _api = VideoFiltersApi();
  // final _api = VideoFilters();

  double exposure = 0.0;
  double contrast = 1.0;
  double saturation = 1.0;
  double temperature = 6500.0;
  double tint = 0.0;

  String? lutCubePath;
  String? haldPngPath;

  Future<void> _pickVideo() async {
    log('video path result:');
    try{
      final result = await FilePicker.platform.pickFiles(type: FileType.video);
      log('video path result: ${result}');
      if (result != null && result.files.single.path != null) {
        final path = result.files.single.path!;
        log('video path: ${path}');
        await VideoFilters.loadVideo(path);
        log('JNFDSAJKBNDKJSN');
        // await _api.loadVideo(path);
        await VideoFilters.play();
        // await _api.play();
      }
    }catch(e){
      log('error: $e');
    }
  }

  Future<void> _pickCubeLUT() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cube'],
    );
    if (result != null && result.files.single.path != null) {
      lutCubePath = result.files.single.path!;
      // await .setLutCubePath(lutCubePath!);
    await VideoFilters.setCubeLutPath(lutCubePath!);
    }
  }

  Future<void> _pickHaldLUT() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      haldPngPath = result.files.single.path!;
      await _api.setHaldPngPath(haldPngPath!);
    }
  }

  Future<void> _applyFilters() async {
    await _api.updateFilters(
      VideoFilterConfig(
        exposure: exposure,
        contrast: contrast,
        saturation: saturation,
        temperature: temperature,
        tint: tint,
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double min,
    double max,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return Column(
      children: [
        Text('$label: ${value.toStringAsFixed(2)}'),
        Slider(value: value, min: min, max: max, onChanged: onChanged),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Filter Tester')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              width: double.infinity,
              child: UiKitView(
                viewType: 'video_filter_view',
                onPlatformViewCreated: (v){},
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickVideo,
                  child: const Text('Load Video'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _api.play(),
                  child: const Text('Play'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _api.pause(),
                  child: const Text('Pause'),
                ),
              ],
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _pickCubeLUT,
              child: const Text('Pick .cube LUT'),
            ),
            ElevatedButton(
              onPressed: _pickHaldLUT,
              child: const Text('Pick HALD PNG'),
            ),
            const Divider(),
            _buildSlider(
              'Exposure',
              -2.0,
              2.0,
              exposure,
              (v) => setState(() => exposure = v),
            ),
            _buildSlider(
              'Contrast',
              0.5,
              2.0,
              contrast,
              (v) => setState(() => contrast = v),
            ),
            _buildSlider(
              'Saturation',
              0.0,
              2.0,
              saturation,
              (v) => setState(() => saturation = v),
            ),
            _buildSlider(
              'Temperature',
              1000,
              10000,
              temperature,
              (v) => setState(() => temperature = v),
            ),
            _buildSlider(
              'Tint',
              -200,
              200,
              tint,
              (v) => setState(() => tint = v),
            ),
            ElevatedButton(
              onPressed: _applyFilters,
              child: const Text('Apply Filters'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
