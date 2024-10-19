Everything seems fixed as far as I can tell. Need to test the server-side things again.

VERY IMPORTANT: This build is based on an older version of stable, so it is not up-to-date with
the current version of stable (May 2024 at the time of uploading this).

The laundry list of changes off the top of my head:

Client-Side Changes
==========
+ Levels on both classic and modern levels have been rebalanced so they scale in difficulty properly. Level 8 on this build is the closest to level 10 on the normal build.
+ Four new levels have been added, called the Chaos Modes. The Chaos Modes basically replace EX Mode; games on these levels will be much shorter compared to the normal levels.
+ Garbage margin has been implemented in versus modes. The more garbage a player has built up in their queue, the less stop and shake time they get.
+ 'Speed margin' has been implemented into Endless; higher speed equates to less stop time.
+ The garbage system has been changed.
+ Rise speed formula has been changed.
+ (WIP) There are two scoring systems in place; one for Endless, and another for everything else.
+ Challenge Mode has been revamped.
+ (WIP) Changed the analytics that are displayed. These are the analytics that are displayed from top to bottom:
  * Garbage Lines Sent
  * Garbage Lines Cleared
  * Efficiency
  * Garbage in Queue
  * Garbage Lines per Minute
  * Garbage Pieces per Minute
  * Garbage Lines Cleared per Minute
  * Actions per Minute
+ Shock panels can spawn from garbage.
+ 'Wiggling' is no longer a thing.
+ Stealth bridging is now a thing. hello modoki lol
+ Shake animation intensity has been reduced to roughly 75%. This will be removed as adjusting this is now an option in the newer version.
+ Health regeneration has been turned off.
+ 'MergeComboMetalQueue' in training files works differently now; the game will queue garbage in a more 'classic' fashion when this is set to 'true'.

Other things I'm planning to implement:
Allow colorless panels to be cleared by regular panels. Colorless panels being cleared will turn into air, but colorless panels cannot clear garbage. This will take some time to figure out how to implement it properly since all garbage has the same ID as colorless.

Server-Side Changes
==========
+ My ranking system has been implented. This is a very recent addition, and it still needs to be tested.
+ Matches no longer have to be played on the same level for it to be ranked. My ranking system does take into account level differences.
+ Touch is allowed to play ranked.

Other things I plan to implment:
All matches within range of each other will be ranked.
