local logger = require("logger")
require("ChallengeStage")

-- Challenge Mode is a particular play through of the challenge mode in the game, it contains all the settings for the mode.
ChallengeMode =
  class(
  function(self, difficulty)
    self.currentStageIndex = 0
    self.nextStageIndex = self.currentStageIndex + 1
    self.stages = {}
    self.difficultyName = loc("challenge_difficulty_" .. difficulty)
    self.continues = 0
    local stageCount = 10
    local secondsToppedOutToLoseBase = 1
    local secondsToppedOutToLoseIncrement = 0.1
    local lineClearGPMBase = 4
    local lineClearGPMIncrement = 0.4
    local lineHeightToKill = 5
    local panelLevel = 10

    if difficulty == 1 then
      stageCount = 4
      secondsToppedOutToLoseBase = 0.78
      secondsToppedOutToLoseIncrement = 0.78
      lineClearGPMBase = 1.5
      lineClearGPMIncrement = 1.5
      panelLevel = 1
    elseif difficulty == 2 then
      stageCount = 4
      secondsToppedOutToLoseBase = 1.04
      secondsToppedOutToLoseIncrement = 1.21
      lineClearGPMBase = 4.5
      lineClearGPMIncrement = 1.5
      panelLevel = 2
    elseif difficulty == 3 then
      stageCount = 6
      secondsToppedOutToLoseBase = 1.56
      secondsToppedOutToLoseIncrement = 1.09
      lineClearGPMBase = 6.75
      lineClearGPMIncrement = 1.05
      panelLevel = 3
      lineHeightToKill = 5
    elseif difficulty == 4 then
      stageCount = 6
      secondsToppedOutToLoseBase = 2.34
      secondsToppedOutToLoseIncrement = 1.64
      lineClearGPMBase = 9
      lineClearGPMIncrement = 1
      panelLevel = 4
      lineHeightToKill = 5
    elseif difficulty == 5 then
      stageCount = 8
      secondsToppedOutToLoseBase = 3.51
      secondsToppedOutToLoseIncrement = 1.75
      lineClearGPMBase = 10.5
      lineClearGPMIncrement = 0.78
      panelLevel = 5
    elseif difficulty == 6 then
      stageCount = 8
      secondsToppedOutToLoseBase = 5.27
      secondsToppedOutToLoseIncrement = 2.63
      lineClearGPMBase = 12
      lineClearGPMIncrement = 0.85
      panelLevel = 6
    elseif difficulty == 7 then
      stageCount = 10
      secondsToppedOutToLoseBase = 7.9
      secondsToppedOutToLoseIncrement = 3.07
      lineClearGPMBase = 13.5
      lineClearGPMIncrement = 0.72
      panelLevel = 7
    elseif difficulty == 8 then
      stageCount = 10
      secondsToppedOutToLoseBase = 11.85
      secondsToppedOutToLoseIncrement = 4.61
      lineClearGPMBase = 16.5
      lineClearGPMIncrement = 0.77
      panelLevel = 8
    elseif difficulty == 9 then
      stageCount = 10
      secondsToppedOutToLoseBase = 17.78
      secondsToppedOutToLoseIncrement = 6.91
      lineClearGPMBase = 18
      lineClearGPMIncrement = 0.72
      panelLevel = 9
    elseif difficulty == 10 then
      stageCount = 10
      secondsToppedOutToLoseBase = 26.66
      secondsToppedOutToLoseIncrement = 10.37
      lineClearGPMBase = 18
      lineClearGPMIncrement = 0.72
      panelLevel = 10
    elseif difficulty == 11 then
      stageCount = 6
      secondsToppedOutToLoseBase = 40
      secondsToppedOutToLoseIncrement = 16
      lineClearGPMBase = 19.5
      lineClearGPMIncrement = 0.72
      panelLevel = 11
    elseif difficulty == 12 then
      stageCount = 6
      secondsToppedOutToLoseBase = 40
      secondsToppedOutToLoseIncrement = 16
      lineClearGPMBase = 22.75
      lineClearGPMIncrement = 1.45
      panelLevel = 13
    elseif difficulty == 13 then
      stageCount = 6
      secondsToppedOutToLoseBase = 40
      secondsToppedOutToLoseIncrement = 16
      lineClearGPMBase = 22.75
      lineClearGPMIncrement = 1.05
      panelLevel = 14
    elseif difficulty == 14 then
      stageCount = 6
      secondsToppedOutToLoseBase = 40
      secondsToppedOutToLoseIncrement = 16
      lineClearGPMBase = 22.75
      lineClearGPMIncrement = 0.65
      panelLevel = 15
    end

    for stageIndex = 1, stageCount, 1 do
      local incrementMultiplier = stageIndex - 1
      local attackSettings = self:attackFile(difficulty, stageIndex)
      local secondsToppedOutToLose = secondsToppedOutToLoseBase + secondsToppedOutToLoseIncrement * incrementMultiplier
      local lineClearGPM = lineClearGPMBase + lineClearGPMIncrement * incrementMultiplier
      self.stages[#self.stages+1] = ChallengeStage(stageIndex, secondsToppedOutToLose, lineClearGPM, lineHeightToKill, panelLevel, attackSettings)
    end
    
    self.stageTimeQuads = {}
    self.totalTimeQuads = {}
  end
)

function ChallengeMode:attackFilePath(difficulty, stageIndex)
  for i = stageIndex, 1, -1 do
    local path = "default_data/training/challenge-" .. difficulty .. "-" .. i .. ".json"
    if love.filesystem.getInfo(path) then
      return path
    end
  end

  return nil
end

function ChallengeMode:attackFile(difficulty, stageIndex)
  local attackFile = readAttackFile(self:attackFilePath(difficulty, stageIndex))
  assert(attackFile ~= nil, "could not find attack file for challenge mode")
  return attackFile
end

function ChallengeMode:beginStage()
  self.currentStageIndex = self.nextStageIndex
end

function ChallengeMode:recordStageResult(gameResult, gameLength)
  local lastStageIndex = self.currentStageIndex

  if gameResult > 0 then
    self.nextStageIndex = self.currentStageIndex + 1
  elseif gameResult < 0 then
    self.continues = self.continues + 1
  end

  local challengeStage = self.stages[lastStageIndex]
  challengeStage.expendedTime = gameLength + challengeStage.expendedTime
end

local stageQuads = {}

function ChallengeMode.render(self)
  self:drawTimeSplits()

  local drawX = canvas_width / 2
  local drawY = 440
  local limit = 150
  gprintf(loc("difficulty"), drawX - limit/2, drawY, limit, "center", nil, nil, 10)
  gprintf(self.difficultyName, drawX - limit/2, drawY + 26, limit, "center", nil, nil, 6)

  drawY = 520
  gprintf("Stage", drawX - limit/2, drawY, limit, "center", nil, nil, 10)
  GraphicsUtil.draw_number(self.currentStageIndex, themes[config.theme].images.IMG_number_atlas_2P, stageQuads, drawX, drawY + 26, themes[config.theme].win_Scale, "center")

  drawY = 600
  gprintf("Continues", drawX - limit/2, drawY, limit, "center", nil, nil, 10)
  gprintf(self.continues, drawX - limit/2, drawY + 26, limit, "center", nil, nil, 10)
end


function ChallengeMode:drawTimeSplits()
  local totalTime = 0
  local xPosition = 1180
  local yPosition = 120
  local yOffset = 30
  local row = 0
  local padding = 6
  local width = 180
  local height = yOffset * (#self.stages + 1) + padding * 2

  -- Background
  grectangle_color("fill", (xPosition - width/2) / GFX_SCALE , yPosition / GFX_SCALE, width/GFX_SCALE, height/GFX_SCALE, 0, 0, 0, 0.5)

  yPosition = yPosition + padding

  for i = 1, self.currentStageIndex do
    if self.stageTimeQuads[i] == nil then
      self.stageTimeQuads[i] = {}
    end
    local time = self.stages[i].expendedTime
    local currentStageTime = time
    local isCurrentStage = i == self.currentStageIndex
    if isCurrentStage and GAME.match.P1:game_ended() == false then
      currentStageTime = currentStageTime + GAME.match.P1.game_stopwatch
    end
    totalTime = totalTime + currentStageTime

    if isCurrentStage then
      set_color(0.8,0.8,1,1)
    end
    GraphicsUtil.draw_time(frames_to_time_string(currentStageTime, true), self.stageTimeQuads[i], xPosition, yPosition + yOffset * row, themes[config.theme].time_Scale)
    if isCurrentStage then
      set_color(1,1,1,1)
    end

    row = row + 1
  end

  set_color(1,1,0.8,1)
  GraphicsUtil.draw_time(frames_to_time_string(totalTime, true), self.totalTimeQuads, xPosition, yPosition + yOffset * row, themes[config.theme].time_Scale)
  set_color(1,1,1,1)
end
