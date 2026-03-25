# Endless, Beloved

> *"You woke between worlds. Three voices called your name — or what used to be your name. The cards remember. They always do."*

A dark fantasy tarot visual novel for Android. Three fractured souls. Nine endings. An infinite cycle.

---

## Project Structure

```
endless_beloved/
├── .github/workflows/build.yml   ← GitHub Actions APK builder
├── project.godot                 ← Godot 4.2 project file
├── export_presets.cfg            ← Android export config
│
├── scripts/
│   ├── core/
│   │   ├── Main.gd              ← Entry point
│   │   ├── GameState.gd         ← Autoload: all persistent data
│   │   ├── SceneManager.gd      ← Autoload: scene transitions
│   │   ├── AudioManager.gd      ← Autoload: music + SFX
│   │   ├── CardManager.gd       ← Autoload: tarot deck + draws
│   │   └── DialogueSystem.gd    ← Autoload: story parser + delivery
│   ├── ui/
│   │   ├── TitleScreen.gd
│   │   ├── HomeScreen.gd        ← Altar home screen
│   │   ├── AvatarCustomise.gd   ← Player avatar editor
│   │   ├── CharacterSetup.gd    ← Name + pronoun selection
│   │   ├── CardDrawUI.gd        ← Swipe-to-draw card mechanic
│   │   ├── DialogueBox.gd       ← Typewriter dialogue display
│   │   ├── LiminalTower.gd      ← Main game location
│   │   └── Journal.gd           ← Lore + progress tracker
│   └── minigames/
│       ├── MinigameBase.gd      ← Base class for all minigames
│       ├── CardMemoryGame.gd    ← Memory match (Oracle affinity)
│       ├── FortuneTelling.gd    ← Read for NPCs (Apprentice affinity)
│       └── RitualSpread.gd      ← Arrange card spreads (Angel affinity)
│
├── data/
│   ├── story/
│   │   └── chapter_01.json      ← Chapter 1 dialogue tree
│   └── cards/                   ← (card data in CardManager.gd)
│
└── assets/
    ├── images/
    │   ├── backgrounds/         ← Tower room backgrounds
    │   ├── characters/          ← Character portraits (name_variant_expression.png)
    │   ├── cards/               ← Tarot card art (card_id.png)
    │   └── ui/                  ← UI elements, avatar parts
    └── audio/
        ├── music/               ← .ogg music tracks
        └── sfx/                 ← .ogg sound effects
```

---

## Getting Started

### Prerequisites
- [Godot 4.2](https://godotengine.org/download/) — open the project in the editor to work locally
- A GitHub account — for the cloud APK build

### Build APK from your phone (no computer needed)

1. **Create a GitHub repository** (github.com → New repository)
2. **Upload all project files** using the GitHub mobile app or browser
3. **Push to `main`** — GitHub Actions triggers automatically
4. **Download the APK**:
   - Go to your repo → Actions tab
   - Click the latest workflow run
   - Scroll to "Artifacts" → download `EndlessBeloved-APK`
5. **Install on Android**: Enable *Install unknown apps* in Settings, then open the APK

---

## Autoloads (Register These in Godot)

In Godot: **Project → Project Settings → Autoload**, add:

| Name | Path |
|------|------|
| `GameState` | `res://scripts/core/GameState.gd` |
| `SceneManager` | `res://scripts/core/SceneManager.gd` |
| `AudioManager` | `res://scripts/core/AudioManager.gd` |
| `CardManager` | `res://scripts/core/CardManager.gd` |
| `DialogueSystem` | `res://scripts/core/DialogueSystem.gd` |

---

## Adding Art Assets

### Character portraits
Name format: `[character_id]_[variant]_[expression].png`
- character_id: `angel`, `oracle`, `apprentice`
- variant: `feminine`, `masculine`, `nonbinary`
- expression: `neutral`, `happy`, `sad`, `angry`, `surprised`, `thoughtful`, `loving`, `fearful`

Example: `angel_feminine_thoughtful.png`

### Card art
Name format: `[card_id].png` (matching the `id` field in CardManager.gd)
Example: `fool.png`, `judgement.png`, `back.png`

### Backgrounds
One per room: `tower_entrance.png`, `tower_library.png`, etc.

---

## Adding Story Content

Story is written in JSON files in `data/story/`. Each file = one chapter.

### Node types

```json
{ "type": "line",   "speaker": "oracle", "text": "...", "next": "next_node_id" }
{ "type": "choice", "choices": [{ "text": "...", "next": "...", "affinity": {"oracle": 5} }] }
{ "type": "branch", "branches": [{ "condition": "flag:met_oracle", "next": "..." }], "default": "..." }
{ "type": "card_draw", "forced_card": "judgement", "next": "..." }
{ "type": "affinity", "changes": {"angel": -5}, "next": "..." }
{ "type": "flag",   "name": "met_oracle", "value": true, "next": "..." }
{ "type": "end",    "next_scene": "liminal_tower" }
```

### Condition syntax (for branches + choice conditions)
- `flag:flag_name` — flag is set
- `not_flag:flag_name` — flag is not set  
- `affinity:character_id:min_value` — affinity >= min
- `tier:character_id:tier_name` — affinity tier (guarded/opening/intimate/beloved)
- `chapter:N` — current chapter >= N
- `cycle:N` — current cycle >= N

### Dialogue tokens (auto-replaced)
- `{name}` → player name
- `{they}` / `{them}` / `{their}` → player pronouns
- `{angel}` / `{oracle}` / `{apprentice}` → character names (gender-variant aware)

---

## Adding More Romance Routes

The architecture is built for expansion. To add a new love interest:

1. Add their character ID to `GameState.affinity`, `character_variants`, `CHARACTER_NAMES`
2. Add their card association to `CardManager.MAJOR_ARCANA`
3. Create portrait assets following the naming convention
4. Write their story nodes in the appropriate chapter JSON files
5. Add a room in `LiminalTower.ROOMS` where they appear

---

## Adding Minigames

1. Create a new script extending `MinigameBase`
2. Override `_setup()`, set `minigame_id`, `max_score`, `affinity_rewards`
3. Call `_on_complete(score)` when the minigame ends
4. Create a scene with your script attached
5. Add a navigation point to the tower (or home screen) to reach it

---

## Roadmap

- [ ] **Phase 1** — Prototype: core systems + Chapter 1 playable
- [ ] **Phase 2** — Act I: Chapters 1–3, all three characters, placeholder art
- [ ] **Phase 3** — Full game: all 10 chapters, 9 endings, cycle system
- [ ] **Phase 4** — Polish: final art, audio, Google Play submission
- [ ] **Future** — Additional romance routes, expanded minigames, voice acting

---

*Endless, Beloved is a game about the impossibility of loving something that is also in the process of becoming.*
