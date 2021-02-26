<h1>:chess_pawn: Endpoints :chess_pawn: </h1>
<hr>
<h1><span style="color:red">Quests</span></h1>
<hr>

### Quest Index

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests`

Params: `:user_id`

Response:

```json
{
  "data": [
    {
      "id": "1",
      "type": "quest",
      "attributes": {
        "status": "in progress",
        "user_id": "12"
      }
    },
    {
      "id": "2",
      "type": "quest",
      "attributes": {
        "status": "completed",
        "user_id": "12"
      }
    },
    {
      "id": "3",
      "type": "quest",
      "attributes": {
        "status": "completed",
        "user_id": "12"
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
  "data": {
    "id": "1",
    "type": "quest",
    "attributes": {
      "status": "in progress",
      "user_id": "12"
    }
  }
}
```


### Quest Create

Path: `POST https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests`

Params: `:user_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "quest",
    "attributes": {
      "user_id": "12"
    }
  }
}
```

### Quest Update

Path: `PATCH https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests`

Params: `:user_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "quest",
    "attributes": {
      "status": "completed"
    }
  }
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
  "data": [
    {
      "id": "1",
      "type": "game",
      "attributes": {
        "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/P2PPP3PP/KBNR w KQkq - 0 1",
        "status": "in progress"
        "user_id": "12",
        "quest_id": "1"
      }
    },
    {
      "id": "2",
      "type": "game",
      "attributes": {
        "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/P2PPP3PP/KBNR w KQkq - 0 1",
        "status": "in progress"
        "user_id": "12",
        "quest_id": "1"
      }
    },
    {
      "id": "3",
      "type": "game",
      "attributes": {
        "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
        "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/P2PPP3PP/KBNR w KQkq - 0 1",
        "status": "in progress"
        "user_id": "12",
        "quest_id": "1"
      }
    }
  ]
}
```


### Games Show

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id/games/:game_id`

Params: `:user_id, :quest_id, :game_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "game",
    "attributes": {
      "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/P2PPP3PP/KBNR w KQkq - 0 1",
      "status": "in progress"
      "user_id": "12",
      "quest_id": "1"
    }
  }
}
```

### Games Create

Path: `POST https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id/games`

Params: `:user_id, :quest_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "game",
    "attributes": {
      "starting_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "user_id": "12",
      "quest_id": "1"
    }
  }
}
```

### Games Update

Path: `PATCH https://chess-quest-api.herokuapp.com/api/v1/users/:user_id/quests/:quest_id/games/:game_id`

Params: `:user_id, :quest_id, :game_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "game",
    "attributes": {
      "current_fen": "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",
      "status": "won"
      "user_id": "12",
      "quest_id": "1"
    }
  }
}
```

<h1><span style="color:red">Stats</span></h1>
<hr>

### User Stats across all games / quests

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/stats/users/:user_id`

Params: `:user_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "user_stats",
    "attributes": {
      "streak": "6",
      "win_loss": "6:1",
      "total_quests": "2"
    }
  }
}
```

### Stats for a single quest

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/stats/quest/:quest_id

Params: `:quest_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "quest_stats",
    "attributes": {
      "quest_id": "2",
      "streak": "3",
      "win_loss": "3:1"
    }
  }
}
```

### User Stats across single game

Path: `GET https://chess-quest-api.herokuapp.com/api/v1/stats/games/:game_id`

Params: `:game_id`

Response:

```json
{
  "data": {
    "id": "1",
    "type": "game_stats",
    "attributes": {
      "win": "true"
    }
  }
}
```
