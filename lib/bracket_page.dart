import 'package:example/bracket_widget.dart';
import 'package:example/player_widget.dart';
import 'package:example/round_response.dart';
import 'package:flutter/material.dart';

class BracketPage extends StatefulWidget {
  const BracketPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BracketPage();
  }
}

class _BracketPage extends State<BracketPage> {
  List<List<Team>> teamList = [];

  @override
  void initState() {
    teamList = RoundResponse.fromRawJson("""{
    "teams": [
    [
    {
    "id": 86147,
    "name": "1. alpha_01",
    "match_id": 1,
    "score": 0
    },
    {
    "id": 86148,
    "name": "2. alpha_02",
    "match_id": 1,
    "score": 0
    }
    ],
    [
    {
    "id": 86149,
    "name": "3. osinski.hailey",
    "match_id": 2,
    "score": 0
    },
    {
    "id": null,
    "name": null,
    "match_id": 2,
    "score": 0
    }
    ],
    [
    {
    "id": 86201,
    "name": "5. alpha_04",
    "match_id": 3,
    "score": 0
    },
        {
        "id": 86275,
        "name": "6. alpha_05",
        "match_id": 3,
        "score": 0
        }
        ],
        [
        {
        "id": 86303,
        "name": "7. alpha_06",
        "match_id": 4,
        "score": 0
        },
        {
        "id": null,
        "name": null,
        "match_id": 4,
        "score": 0
        }
        ],
         [
        {
        "id": 86303,
        "name": "7. alpha_06",
        "match_id": 4,
        "score": 0
        },
        {
        "id": null,
        "name": null,
        "match_id": 4,
        "score": 0
        }
        ],
         [
        {
        "id": 86303,
        "name": "7. alpha_06",
        "match_id": 4,
        "score": 0
        },
        {
        "id": null,
        "name": null,
        "match_id": 4,
        "score": 0
        }
        ],
         [
        {
        "id": 86303,
        "name": "7. alpha_06",
        "match_id": 4,
        "score": 0
        },
        {
        "id": null,
        "name": null,
        "match_id": 4,
        "score": 0
        }
        ]


        ]
    }""").teams ?? [];
    for (int i = 0; i < (31 - 7); i++) {
      teamList.add(teamList[0]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BracketWidget<Team>(teamList, 32, (value) {
        return PlayerWidget(
          onTap: () {},
          name: value.name,
          score: value.score.toString(),
          id: value.id.toString(),
        );
      }),
    );
  }
}
