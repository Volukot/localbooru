import 'package:flutter/material.dart';
import 'package:localbooru/utils/listeners.dart';
import 'package:localbooru/api/preset/index.dart';

class DownloadProgressDialog extends StatefulWidget {
    const DownloadProgressDialog({super.key});

    @override
    State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}
class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(context) {
        return const AlertDialog(
            title: Text("Importing"),
            content: SizedBox(
                width: 500,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: LinearProgressIndicator(),
                )
            ),

        );
    }
}

// TODO: move this elsewhere
Future<VirtualPreset> importImageFromURL(String url) async {
    final uri = Uri.parse(url);
    
    importListener.updateImportStatus(import: true);

    final isCollection = await determineIfCollection(uri);

    Future<VirtualPreset> future;
    
    if(isCollection) {
        future = VirtualPresetCollection.urlToPreset(url);
    } else {
        future = PresetImage.urlToPreset(url);
    }

    return await future.whenComplete(() {
        importListener.clear();
    });
}

// .onError((error, stack) {
//         if(error.toString() == "Unknown file type" || error.toString() == "Not a URL") {
//             Future.delayed(const Duration(milliseconds: 1)).then((value) {
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unknown service or invalid image URL inserted")));
//             });
//         } else {
//             throw error!;
//         }
//     })