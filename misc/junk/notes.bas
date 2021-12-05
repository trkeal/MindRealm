350 IF c$ = " " AND CHR$(g(py, px)) = "ô" THEN GOSUB 420	'mp
351 IF c$ = " " AND CHR$(g(py, px)) = "ø" THEN GOSUB 430	'gold
352 IF c$ = " " AND CHR$(g(py, px)) = "ì" THEN GOSUB 440	'hp
353 IF c$ = " " AND CHR$(g(py, px)) = "ç" THEN GOSUB 450	'key/bomb/gain character
354 IF c$ = " " AND CHR$(g(py, px)) = "ñ" THEN GOSUB 460	'mystic orb

420 r = INT(RND(1) * 3) + 5: z(p0, 4) = z(p0, 4) + r: g(py, px) = ASC("Û"): GOSUB 220
421 r$ = STR$(r): r$ = "[Mp +" + RIGHT$(r$, LEN(r$) - 1) + "]"
429 RETURN
430 r = INT(RND(1) * 15) + 1: go = go + r: g(py, px) = ASC("Û"): GOSUB 220
431 r$ = STR$(r): r$ = "[Gold +" + RIGHT$(r$, LEN(r$) - 1) + "]"
439 RETURN
440 r = INT(RND(1) * 5) + 8: z(p0, 1) = z(p0, 1) + r: g(py, px) = ASC("Û"): GOSUB 220
441 r$ = STR$(r): r$ = "[Hp +" + RIGHT$(r$, LEN(r$) - 1) + "]"
449 RETURN

450 r = INT(RND(1) * 17) + 1
451 IF r >= 1 AND r <= 3 THEN r = INT(RND(1) * 4): z(p0, 2) = z(p0, 2) + r: z(p0, 3) = z(p0, 3) + 3 - r: i(p0, 2) = i(p0, 2) + r: i(p0, 3) = i(p0, 3) + 3 - r: r$ = STR$(r): r$ = "[Ap +" + RIGHT$(r$, LEN(r$) - 1) + "]": r1$ = STR$(3 - r): r$ = r$ + "[Dp +" + RIGHT$(r1$, LEN(r1$) - 1) + "]"
452 IF r >= 4 AND r <= 6 THEN r = INT(RND(1) * 3) + 1: z(p0, 2) = z(p0, 2) + r: i(p0, 2) = i(p0, 2) + r: r$ = STR$(r): r$ = "[Ap +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 4
453 IF r >= 7 AND r <= 9 THEN r = INT(RND(1) * 3) + 1: z(p0, 3) = z(p0, 3) + r: i(p0, 3) = i(p0, 3) + r: r$ = STR$(r): r$ = "[Dp +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 7
454 IF r >= 10 AND r <= 12 THEN r = 1: ky = ky + r: r$ = STR$(r): r$ = "[Key +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 10
455 IF r >= 13 AND r <= 15 THEN r = 1: bm = bm + r: r$ = STR$(r): r$ = "[Bomb +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 13
456 IF r >= 16 AND r <= 17 THEN GOSUB 1400: r = 16: IF rr = 0 THEN 450
458 g(py, px) = ASC("Û"): GOSUB 220
459 RETURN

460 r = INT(RND(1) * 5) + -2: z(p0, 4) = z(p0, 4) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 4) = i(p0, 4) + r:
461 r = INT(RND(1) * 5) + -2: go = go + r: g(py, px) = ASC("Û"): GOSUB 220: IF go < 0 THEN go = 0
462 r = INT(RND(1) * 5) + -2: z(p0, 1) = z(p0, 1) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 1) = i(p0, 1) + r
463 r = INT(RND(1) * 5) + -2: z(p0, 2) = z(p0, 2) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 2) = i(p0, 2) + r
464 r = INT(RND(1) * 5) + -2: z(p0, 3) = z(p0, 3) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 3) = i(p0, 3) + r
465 r$ = "[Mystic Orb]": r = INT(RND(1) * 7): IF r > 0 AND e(p0, r) = s(r) THEN 465
466 IF r > 0 AND k(p0, r) = 1 AND e(p0, r) < s(r) THEN r0 = INT(RND(1) * s(r)): r1 = INT(RND(1) * s(r)) + 1: IF r0 < e(p0, r) AND r1 > e(p0, r) THEN e(p0, r) = e(p0, r) + INT(RND(1) * 5) + 1: r$ = "[Mystic Orb: '" + sa$(r) + "' Increased]"
467 IF r > 0 AND k(p0, r) = 0 THEN k(p0, r) = 1: r$ = "[Mystic Orb: Learned '" + sa$(r) + "']"
468 IF e(p0, r) > s(r) THEN e(p0, r) = s(r)
469 RETURN

1400 'gain character
1401 rr = 0: FOR r = 1 TO ch: IF z(r, 1) > 0 THEN rr = rr + 1
1402 NEXT r
1403 IF rr = ch THEN RETURN
1404 r = ch - rr: IF r > 2 THEN r = 2
1405 rr = INT(RND(1) * r) + 1
1406 r$ = "[": FOR r = 1 TO rr: IF r > 1 THEN r$ = r$ + "+"
1407 r0 = INT(RND(1) * ch) + 1: IF z(r0, 1) > 0 THEN 1407
1411 FOR r1 = 1 TO 6: z(r0, r1) = i(r0, r1)
1412 IF k(r0, r1) > 0 AND e(r0, r1) > 10 THEN e(r0, r1) = 10
1413 NEXT r1: r$ = r$ + na$(r0): NEXT r: r$ = r$ + " joined!]"
1419 RETURN