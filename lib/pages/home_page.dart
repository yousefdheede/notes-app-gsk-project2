import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/models/controllers/note_controller.dart';
import 'package:note_app/main.dart';
import 'package:note_app/pages/add_note_page.dart';
import 'package:note_app/provider/theme_provider.dart';
import 'package:note_app/ui/styles/colors.dart';
import 'package:note_app/ui/styles/text_styles.dart';
import 'package:note_app/widgets/icon_button.dart';
import 'package:note_app/widgets/note_tile.dart';

class HomePage extends StatelessWidget {
  final _notesController = Get.put(NoteController());

  final _tileCounts = [
    [2, 2],
    [2, 2],
    [4, 2],
    [2, 3],
    [2, 2],
    [2, 3],
    [2, 2],
  ];
  final _tileTypes = [
    TileType.Square,
    TileType.Square,
    TileType.HorRect,
    TileType.VerRect,
    TileType.Square,
    TileType.VerRect,
    TileType.Square,
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(
              const AddNotePage(
                note: null,
              ),
              transition: Transition.downToUp,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            const SizedBox(
              height: 16,
            ),
            _body(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "MY DIARI",
            style: titleTextStyle.copyWith(
                fontSize: 32, color: Color.fromARGB(255, 2, 167, 243)),
          ),
          MyIconButton(
            onTap: () {},
            icon: Icons.search,
          ),
          MyIconButton(
            icon: Icons.light_mode,
            onTap: () {
              if (MyThemes.lightTheme == true) {
                MyThemes.darkTheme;
              } else if (MyThemes.darkTheme == true) {
                MyThemes.lightTheme;
              }
            },
          ),
        ],
      ),
    );
  }

  _body() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        if (_notesController.noteList.isNotEmpty) {
          return StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                for (int i = 0; i < _notesController.noteList.length; i++)
                  StaggeredGridTile.count(
                      crossAxisCellCount: _tileCounts[i % 7][0],
                      mainAxisCellCount: _tileCounts[i % 7][1],
                      child: NoteTile(
                        index: i,
                        note: _notesController.noteList[i],
                        tileType: _tileTypes[i % 7],
                      ))
              ]);
        } else {
          return Center(
            child: Text("Empty", style: titleTextStyle),
          );
        }
      }),
    ));
  }
}
