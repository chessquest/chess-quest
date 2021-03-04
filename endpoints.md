<h1>:chess_pawn: Endpoints :chess_pawn: </h1>
<hr>
<h1><span style="color:red">Quests</span></h1>
<hr>

### Quest Index

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests`

Params: `:user_id`

Optional Params: `:status`

Response:

```json
{
  "data":[
    {
      "id":"2",
      "type":"quest",
      "attributes":{
        "status":"in_progress",
        "user_id":1
      },
      "relationships":{
        "games":{
          "data":[
            {
              "id":"1",
              "type":"game"
            }
          ]
        }
      }
    }
  ],
  "included":[
    {
      "id":"1",
      "type":"game",
      "attributes":{
        "status":"won",
        "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPP5/2BQK3 w kq - 0 1",
        "current_fen":"8/6Qk/8/P7/3Bp3/7p/8/4K3 b - - 15 35"
      },
      "relationships":{
        "quest":{
          "data":{
            "id":"2",
            "type":"quest"
          }
        }
      }
    }
  ]
}
```


### Quest Show

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id`

Params: `:quest_id`

Response:

```json
{
  "data":{
    "id":"1",
    "type":"quest",
    "attributes":{
      "status":"in_progress",
      "user_id":2
    },
    "relationships":{
      "games":{
        "data":[
          {
            "id":"2",
            "type":"game"
          }
        ]
      }
    }
  },
  "included":[
    {
      "id":"2",
      "type":"game",
      "attributes":{
        "status":"won",
        "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen":"8/8/4Q1P1/5k2/2Q5/N1P5/P4PpP/R1B1KBNR b KQ - 3 30"
      },
      "relationships":{
        "quest":{
          "data":{
            "id":"1",
            "type":"quest"
          }
        }
      }
    }
  ]
}
```


### Quest Create

Path: `POST https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests`

Params: `:user_id`

Response:

```json
{
  "data": {
    "id": "11",
    "type": "quest",
    "attributes": {
      "status": "in_progress",
      "user_id": 1
    },
    "relationships": {
      "games": {
        "data": []
      }
    }
  }
}
```

### Quest Update

Path: `PATCH https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id`

Params: `:user_id, status`

Response:

```json
{
  "data": {
    "id": "11",
    "type": "quest",
    "attributes": {
      "status": "completed",
      "user_id": 1
    },
    "relationships": {
      "games": {
        "data": []
      }
    }
  },
  "included": []
}
```

<h1><span style="color:red">Games</span></h1>
<hr>

### Games Index

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id/games`

Params: `:user_id, :quest_id`

Response:

```json
{
  "data":[
    {
      "id":"2",
      "type":"game",
      "attributes":{
        "status":"won",
        "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen":"8/8/4Q1P1/5k2/2Q5/N1P5/P4PpP/R1B1KBNR b KQ - 3 30"
      },
      "relationships":{
        "quest":{
          "data":{
            "id":"1",
            "type":"quest"
          }
        }
      }
    },
    {
      "id":"3",
      "type":"game",
      "attributes":{
        "status":"lost",
        "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RN1QK2R w KQkq - 0 1",
        "current_fen":"8/4N3/1Q5K/8/P7/3Q4/8/2k5 b - - 24 88"
      },
      "relationships":{
        "quest":{
          "data":{
            "id":"1",
            "type":"quest"
          }
        }
      }
    },
    {
      "id":"23",
      "type":"game",
      "attributes":{
        "status":"in_progress",
        "starting_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen":"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
      },
      "relationships":{
        "quest":{
          "data":{
            "id":"1",
            "type":"quest"
          }
        }
      }
    }
  ]
}
```

### Games Create

Path: `POST https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/games`

Params: `:user_id, 'find_player'`

Response:

```json
{
  "data": {
    "id": "24",
    "type": "game",
    "attributes": {
      "status": "in_progress",
      "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    },
    "relationships": {
      "quest": {
        "data": {
          "id": "2",
          "type": "quest"
        }
      }
    }
  }
}
```

### Games Update

Path: `PATCH https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id/games/:game_id`

Params: `:user_id, :quest_id, :game_id, :current_fen`

Response:

```json
{
  "data": {
    "id": "24",
    "type": "game",
    "attributes": {
      "status": "in_progress",
      "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    },
    "relationships": {
      "quest": {
        "data": {
          "id": "2",
          "type": "quest"
        }
      }
    }
  }
}
```

<h1><span style="color:red">Stats</span></h1>
<hr>

### Return top 3 quests across all users based on win streak

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/top_quests`

Params: NA

Response:

```json
{
  "data": [
    {
      "id": null,
      "type": "quest_stat",
      "attributes": {
        "user_id": 1,
        "streak": 4,
        "quest_id": 2
      },
      "relationships": {
        "games": {
          "data": [
            {
              "id": "1",
              "type": "game"
            },
            {
              "id": "4",
              "type": "game"
            },
            {
              "id": "16",
              "type": "game"
            },
            {
              "id": "5",
              "type": "game"
            },
            {
              "id": "24",
              "type": "game"
            },
            {
              "id": "6",
              "type": "game"
            }
          ]
        }
      }
    },
    {
      "id": null,
      "type": "quest_stat",
      "attributes": {
        "user_id": 4,
        "streak": 3,
        "quest_id": 7
      },
      "relationships": {
        "games": {
          "data": [
            {
              "id": "17",
              "type": "game"
            },
            {
              "id": "14",
              "type": "game"
            },
            {
              "id": "15",
              "type": "game"
            },
            {
              "id": "13",
              "type": "game"
            }
          ]
        }
      }
    },
    {
      "id": null,
      "type": "quest_stat",
      "attributes": {
        "user_id": 2,
        "streak": 2,
        "quest_id": 1
      },
      "relationships": {
        "games": {
          "data": [
            {
              "id": "2",
              "type": "game"
            },
            {
              "id": "3",
              "type": "game"
            },
            {
              "id": "23",
              "type": "game"
            },
            {
              "id": "22",
              "type": "game"
            }
          ]
        }
      }
    }
  ]
}
```

### Users current quest win streak

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/win_streak`

Params: `:user_id`

Response:

```json
{
  "data": {
    "id": null,
    "type": "user_stat",
    "attributes": {
      "streak": 4,
      "quest_id": 2
    },
    "relationships": {
      "games": {
        "data": [
          {
            "id": "1",
            "type": "game"
          },
          {
            "id": "4",
            "type": "game"
          },
          {
            "id": "16",
            "type": "game"
          },
          {
            "id": "5",
            "type": "game"
          },
          {
            "id": "24",
            "type": "game"
          },
          {
            "id": "6",
            "type": "game"
          }
        ]
      }
    }
  }
}
```
