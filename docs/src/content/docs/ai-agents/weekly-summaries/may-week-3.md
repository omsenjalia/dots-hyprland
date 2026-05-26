---
title: "Weekly Summary: may week 3"
date: 2026-05-26
week_start: 2026-05-17
week_end: 2026-05-23
---

# Weekly Summary: may week 3

**Period:** 2026-05-17 to 2026-05-23

## Commits

### Commit: ce809512

commit ce809512100c267238d6f57bc52b73ff2e7e4f85
Author: Love, Trevor S <trevor.s.love@intel.com>
Date:   Fri May 22 11:34:10 2026 -0700

    fix: hypridle dispatch commands for Lua-based Hyprland

 dots/.config/hypr/hypridle.conf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

**Message:**

> fix: hypridle dispatch commands for Lua-based Hyprland
> 

---

### Commit: 6eaa869f

commit 6eaa869fac8dbd6af1dd8ecc8be93d2079e38a4d
Author: RamonBritoDev <mrwexx07@gmail.com>
Date:   Thu May 21 16:23:40 2026 +0000

    fix(qs): NotificationItem polish() loop on Qt 6.11
    
    summaryText.Layout.fillWidth depended on summaryRow.implicitWidth,
    its own parent RowLayout, creating a circular dependency:
    
      summaryText.Layout.fillWidth
        -> changes summaryText.width
        -> changes summaryRow.implicitWidth
        -> re-evaluates summaryText.Layout.fillWidth (loop)
    
    Qt 6.10 tolerated this through layout settling heuristics, but
    Qt 6.11.1 detects the loop and emits "ColumnLayout called polish()
    inside updatePolish() of ColumnLayout" warnings repeatedly, pinning
    CPU at 100% and freezing the sidebar/notification UI when opened.
    
    Use root.width (the stable width inherited from the parent ListView)

**Message:**

> fix(qs): NotificationItem polish() loop on Qt 6.11
> 
> summaryText.Layout.fillWidth depended on summaryRow.implicitWidth,
> its own parent RowLayout, creating a circular dependency:
> 
>   summaryText.Layout.fillWidth
>     -> changes summaryText.width
>     -> changes summaryRow.implicitWidth
>     -> re-evaluates summaryText.Layout.fillWidth (loop)
> 
> Qt 6.10 tolerated this through layout settling heuristics, but
> Qt 6.11.1 detects the loop and emits "ColumnLayout called polish()
> inside updatePolish() of ColumnLayout" warnings repeatedly, pinning
> CPU at 100% and freezing the sidebar/notification UI when opened.
> 
> Use root.width (the stable width inherited from the parent ListView)
> as the reference for the elision threshold instead of the recursive
> summaryRow.implicitWidth.
> 

---

### Commit: 8f9cf67b

commit 8f9cf67be7715010998e077ded8a339d539c1060
Author: Jihed Kdiss <jihedkdiss@outlook.com>
Date:   Thu May 21 14:16:22 2026 +0100

    fix(screenCorners): remove shadowing screen property to fix multi-monitor corner rendering

 dots/.config/quickshell/ii/modules/ii/screenCorners/ScreenCorners.qml | 1 -
 1 file changed, 1 deletion(-)

**Message:**

> fix(screenCorners): remove shadowing screen property to fix multi-monitor corner rendering

---

### Commit: 20d1ff06

commit 20d1ff065b1201d5130e994a7df53e2ddfdf6069
Author: Zhengjie Min <zjmin@umich.edu>
Date:   Wed May 20 11:38:00 2026 -0400

    style: space indent

 dots/.config/hypr/hyprland.lua | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

**Message:**

> style: space indent
> 

---

### Commit: 25fe0ab0

commit 25fe0ab01e8849698df0da4c4ca000807bf5a258
Author: Zhengjie Min <zjmin@umich.edu>
Date:   Wed May 20 11:32:13 2026 -0400

    fix(hyprland): restore nwg-display entry

 dots/.config/hypr/hyprland.lua | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

**Message:**

> fix(hyprland): restore nwg-display entry
> 

---

### Commit: 348e846b

commit 348e846b7bc2ad03b57d8305005b3ae8c1388f80
Author: github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>
Date:   Wed May 20 09:15:20 2026 +0000

    docs(changelog): add entry for 8ea1099

 .../docs/ai-agents/changelog/2026-05-20-8ea1099.md | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

**Message:**

> docs(changelog): add entry for 8ea1099
> 

---

### Commit: 8ea10992

commit 8ea1099229ba6ffbe9a23b0bc783b616a7a86985
Merge: f815755a c1b37bc4
Author: om <omsenjalia@gmail.com>
Date:   Wed May 20 14:45:09 2026 +0530

    Merge branch 'end-4:main' into main

 dots/.config/hypr/hyprland/env.lua                 |   3 +-
 dots/.config/hypr/hyprland/keybinds.lua            | 182 ++++++++++++---------
 .../modules/ii/cheatsheet/CheatsheetKeybinds.qml   |   7 +
 .../ii/cheatsheet/CheatsheetKeybindsCategory.qml   |  74 +++++++--
 dots/.config/quickshell/ii/services/Hyprsunset.qml |   1 -
 5 files changed, 175 insertions(+), 92 deletions(-)

**Message:**

> Merge branch 'end-4:main' into main
> 

---

### Commit: c1b37bc4

commit c1b37bc4676677f7eeebfb2cf6185b493e38d2cd
Merge: b470bf3f d4d78a5e
Author: Minh <97237370+end-4@users.noreply.github.com>
Date:   Mon May 18 23:40:22 2026 +0200

    fix(hyprsunset): remove vestigial Hyprland.dispatch broken under .lua schema (#3356)

 dots/.config/quickshell/ii/services/Hyprsunset.qml | 1 -
 1 file changed, 1 deletion(-)

**Message:**

> fix(hyprsunset): remove vestigial Hyprland.dispatch broken under .lua schema (#3356)

---

### Commit: b470bf3f

commit b470bf3fe8fb310b62a08458d22739ca1fa7618d
Merge: c0706258 d4e77791
Author: Minh <97237370+end-4@users.noreply.github.com>
Date:   Mon May 18 23:06:27 2026 +0200

    Fix: XDG_DATA_DIRS now expands correctly (fixes 3354) (#3358)

 dots/.config/hypr/hyprland/env.lua | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

**Message:**

> Fix: XDG_DATA_DIRS now expands correctly (fixes 3354) (#3358)

---

### Commit: d4e77791

commit d4e777911e32f8ebbf71c92ce5d0060163fb8a02
Author: GregorVal <106101599+GregorVal@users.noreply.github.com>
Date:   Sun May 17 14:46:26 2026 +0200

    Fix: XDG_DATA_DIRS now expands correctly
    
    Previously the environmental variable would become literally
    *:$XDG_DATA_DIRS
    Now the variable is expanded correctly

 dots/.config/hypr/hyprland/env.lua | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

**Message:**

> Fix: XDG_DATA_DIRS now expands correctly
> 
> Previously the environmental variable would become literally 
> *:$XDG_DATA_DIRS
> Now the variable is expanded correctly

---

