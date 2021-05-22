part of 'widgets.dart';

class UploadPhotoDialog extends StatelessWidget {
  final Function camera;
  final Function gallery;

  UploadPhotoDialog({this.camera, this.gallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          ListTile(
            leading: Icon(MdiIcons.camera, color: Colors.black),
            title: Text('Camera', style: blackFontStyle3),
            onTap: camera,
          ),
          ListTile(
            leading: Icon(MdiIcons.image, color: Colors.black),
            title: Text('Gallery', style: blackFontStyle3),
            onTap: gallery,
          )
        ],
      ),
    );
  }
}
