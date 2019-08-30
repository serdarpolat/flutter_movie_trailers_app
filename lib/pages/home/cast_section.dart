import 'package:flutter/material.dart';
import 'package:movie_traliers/model/credits_model.dart';
import 'package:movie_traliers/ui/theme_ui.dart';

class CastSection extends StatefulWidget {
  final AsyncSnapshot<CreditsModel> snapshotCredit;

  const CastSection({Key key, this.snapshotCredit}) : super(key: key);
  @override
  _CastSectionState createState() => _CastSectionState();
}

class _CastSectionState extends State<CastSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: widget.snapshotCredit.data.cast.length > 6
            ? 6
            : widget.snapshotCredit.data.cast.length,
        itemBuilder: (context, index) {
          var data = widget.snapshotCredit.data.cast[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
              ),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: data.profilePath != null
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          data.profilePath),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24,
                            ),
                            child: Placeholder(
                              color: bgColor.withOpacity(0.5),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.name,
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'as ' + data.character,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
