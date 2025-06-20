--Debug
if arg[2] == "debug" then
    lldebugger = require("lldebugger")
    lldebugger.start()
end
function love.load()
    Object = {}
    Enemis = {}
    Ball = {}
    BallGlace = {}
    Missions = {
        { name = "Tuer 10 ennemis:200T",                                  done = false },
        { name = "Construire 5 tourelles:400T",                           done = false },
        { name = "Finir la vague 3:500T",                                 done = false },
        { name = "Ne perdre aucune vie:1500T",                            done = false },
        { name = "Atteindre 10000$:3000T",                                done = false },
        { name = "Débloquer le niveau 4:600T",                            done = false },
        { name = "Ne pas poser de bombe ou de mitraillette:1000T",        done = false },
        { name = "Gagner un niveau sans poser plus de 3 tourelles:2000T", done = false },
        { name = "Avoir uniquement des tourelles canon ou glace:2100T",   done = false },
        { name = "Terminer un niveau avec 1 PV restant:1300T",            done = false }
    }
    Recompenses = {
        { name = "" },
        { name = "Mini jeux" },
        { name = "Musique Exclusive" },
        { name = "Basketball" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
        { name = "" },
    }
    MG = {
        { name = "Basketball" }
    }
    EnnemisKilled = 0
    Y_Of_Enemis = 800
    Money = 200
    PV = 20
    SpeedOfEnemis = 150
    IsCreativeMode = false
    Mode = "Canon"
    CurrentWave = 0
    WaveInProgress = false
    TimeBeforeNextWave = 5
    MaxEnnemisPerWave = 10
    Boss = false
    WinTheBoss = false
    XofBoss = 700
    YofBoss = 700
    PV_Of_Boss = 40
    TimerOfVisible = 3
    CooldownShoot = 6.5
    BossisFrezzing = false
    CurrentScreen = "Home"
    Levels_Unlocked = 1
    Level = 1
    Starting = true
    Size_Of_Finger = 0.08
    TutorialScreen = "1"
    Code = ""
    Hello_Jeremy = false
    PrintDebug = false
    Mission7var2 = true
    Mission8 = false
    Mission9 = true
    ExclusiveMusictrueorfalse = false
    TimerOfStepOfEnemis = 3
    Trophee = 0
    T = 0
    XofPDT = 0
    YofMG = 0
    XofNet = 80
    Yofbasketball = 150
    BasketballShoot = false
    --Victory variables
    Victory = false
    VictoryTimer = 0
    VictoryFontSize = 20
    Confetti = {}
    VictoryDuration = 5        -- seconds
    math.randomseed(os.time()) -- Truc qui sert à faire un nombre aléatoire à chaque fois que j'utilise math.random(x,x)
    CanonImage = love.graphics.newImage("Pixel Heart.png")
    Heart = love.graphics.newImage("Canon.png")
    HomeImage = love.graphics.newImage("Home.png")
    CadenasImage = love.graphics.newImage("Cadenas.png")
    FingerImage = love.graphics.newImage("Finger Pointing.png")
    BackgroundLevel4 = love.graphics.newImage("Backgroundlevel4.png")
    BackgroundLevel3 = love.graphics.newImage("Backgroundlevel3.jpg")
    BackgroundLevel2 = love.graphics.newImage("Backgroundlevel2.jpg")
    BackgroundLevel1 = love.graphics.newImage("Backgroundlevel1.jpg")
    TropheeImage = love.graphics.newImage("trophée.png")
    BasketballImage = love.graphics.newImage("Basketball.png")
    NetImage = love.graphics.newImage("Net.png")
    ShootSound = love.audio.newSource("assets/mixkit-short-laser-gun-shot-1670.wav", "stream")
    GameOverSound = love.audio.newSource("assets/mixkit-sad-game-over-trombone-471.wav", "stream")
    BuzzSound = love.audio.newSource("assets/mixkit-wrong-electricity-buzz-955.wav", "stream")
    PrincipalMusic = love.audio.newSource("assets/mixkit-games-music-706.mp3", "stream")
    ExclusiveMusic = love.audio.newSource("assets/Exclusive music.mp3", "stream")
    AlertSound = love.audio.newSource("assets/mixkit-signal-alert-771.wav", "stream")
    HomeMusic = love.audio.newSource(
        "assets/One Man Symphony - In The Blink Of An Eye (Free) - 04 In The Blink Of An Eye (Action 04).mp3", "stream")
    VolumeOfEffects = 0.5
    VolumeOfMusic = 0.7
    PrincipalMusic:setVolume(VolumeOfMusic) -- Volume entre 0.0 (muet) et 1.0 (volume max)
    HomeMusic:setVolume(VolumeOfMusic)
    ExclusiveMusic:setVolume(VolumeOfMusic)
    ShootSound:setVolume(VolumeOfEffects)
    GameOverSound:setVolume(VolumeOfEffects)
    BuzzSound:setVolume(VolumeOfEffects)
    AlertSound:setVolume(VolumeOfEffects)
    HomeMusic:play()
    Font = love.graphics.newFont(35)     -- 35 est la taille en pixels
    Font2 = love.graphics.newFont(200)   -- 200 est la taille en pixels
    Font3 = love.graphics.newFont(55)    -- 50 est la taille en pixels
    FontMini = love.graphics.newFont(28) -- 28 est la taille en pixels
    love.graphics.setFont(Font)
end

function Within(SelfX, SelfY, x, y, w, h)
    return x > SelfX and x < (SelfX + w) and
        y > SelfY and y < (SelfY + h)
end

function love.textinput(t)
    if PrintDebug then
        print("Code:" .. Code)
    end
    TutorialScreen = ""
    Size_Of_Finger = 0.1
    if Tutorial then
        TutorialScreen = TutorialScreen .. t
    end
    if not Hello_Jeremy then
        Code = Code .. t
    end
    if Code == "2299" then
        Hello_Jeremy = true
        Code = ""
    end
    if Hello_Jeremy and t == "1" then
        Money = 10000
    elseif Hello_Jeremy and t == "2" then
        PV = 150
    elseif Hello_Jeremy and t == "3" then
        Hello_Jeremy = false
        TutorialScreen = "0"
        Tutorial = false
        Starting = false
    elseif Hello_Jeremy and t == "4" then
        PrintDebug = true
    elseif Hello_Jeremy and t == "5" then
        PrintDebug = false
    elseif Hello_Jeremy and t == "6" then
        Levels_Unlocked = 100
    end
end

function Start_New_Wave()
    TimeBeforeNextWave = 5
    WaveInProgress = true
    SpeedOfEnemis = SpeedOfEnemis + 20
    CurrentWave = CurrentWave + 1
    if CurrentWave ~= 1 then
        Money = Money + 60
    end
    Y_Of_Enemis = math.random(750, 715)
    if Level == 3 or Level == 4 then
        if CurrentWave ~= 4 then
            MaxEnnemisPerWave = MaxEnnemisPerWave + 10
        else
            MaxEnnemisPerWave = 0
        end
    elseif Level == 1 or Level == 2 then
        if CurrentWave ~= 3 then
            MaxEnnemisPerWave = MaxEnnemisPerWave + 10
        else
            MaxEnnemisPerWave = 0
        end
    end
end

function UpdateMissions()
    if EnnemisKilled >= 10 and Missions[1].done == false then
        Missions[1].done = true
        Trophee = Trophee + 200
    end
    if #Object >= 5 and Missions[2].done == false then
        Missions[2].done = true
        Trophee = Trophee + 400
    end
    if CurrentWave == 4 and Missions[3].done == false then
        Missions[3].done = true
        Trophee = Trophee + 500
    end
    if PV == 20 and CurrentWave == 4 and Level == 1 and Missions[4].done == false then
        Missions[4].done = true
        Trophee = Trophee + 1500
    end
    if PV == 20 and CurrentWave == 4 and Level == 2 and Missions[4].done == false then
        Missions[4].done = true
        Trophee = Trophee + 1500
    end
    if PV == 20 and CurrentWave == 5 and Level == 3 and Missions[4].done == false then
        Missions[4].done = true
        Trophee = Trophee + 1500
    end
    if PV == 20 and CurrentWave == 5 and Level == 4 and Missions[4].done == false then
        Missions[4].done = true
        Trophee = Trophee + 1500
    end
    if Money == 10000 and Missions[5].done == false then
        Missions[5].done = true
        Trophee = Trophee + 3000
    end
    if Levels_Unlocked >= 4 and Missions[6].done == false then
        Missions[6].done = true
        Trophee = Trophee + 600
    end
    if Mission7var2 and CurrentWave == 4 and Missions[7].done == false then
        Missions[7].done = true
        Trophee = Trophee + 1000
    end
    if Mission8 and CurrentWave == 4 and Missions[8].done == false then
        Missions[8].done = true
        Trophee = Trophee + 500
    end
    if Mission9 and CurrentWave == 4 and Missions[9].done == false then
        Missions[9].done = true
        Trophee = Trophee + 2100
    end
    if PV == 1 and CurrentWave == 4 and Level == 1 and Missions[10].done == false or PV == 1 and CurrentWave == 4 and Level == 2 and Missions[10].done == false then
        Missions[10].done = true
        Trophee = Trophee + 1300
    end
    if PV == 1 and CurrentWave == 5 and Level == 3 and Missions[10].done == false or PV == 1 and CurrentWave == 4 and Level == 4 and Missions[10].done == false then
        Missions[10].done = true
        Trophee = Trophee + 1300
    end
end

function AllMissionsCompleted()
    for _, mission in ipairs(Missions) do
        if not mission.done then
            return false
        end
    end
    return true
end

function TriggerVictory()
    Victory = true
    VictoryTimer = 0
    VictoryFontSize = 20
    Confetti = {}
    for i = 1, 100 do
        table.insert(Confetti, {
            x = math.random(0, 1500),
            y = math.random(-800, 0),
            speed = math.random(100, 300),
            color = { math.random(), math.random(), math.random() }
        })
    end
end

function love.update(dt)
    if VictoryTimer >= VictoryDuration then
        Victory = false
    end
    if Victory then
        VictoryTimer = VictoryTimer + dt
        VictoryFontSize = 20 + math.sin(VictoryTimer * 5) * 10

        for _, confetti in ipairs(Confetti) do
            confetti.y = confetti.y + confetti.speed * dt
            if confetti.y > 800 then
                confetti.y = -math.random(50, 200)
                confetti.x = math.random(0, 1500)
            end
        end

        -- End the victory animation after the duration
        if VictoryTimer >= VictoryDuration then
            Victory = false
        end
    end
    if #Object <= 3 then
        Mission8 = true
    end
    T = T + dt
    if PV == 0 then
        return
    end
    if CurrentScreen == "MiniGames1" then
        if not BasketballShoot and XofNet <= 100 then
            PON = 1
        elseif not BasketballShoot and XofNet >= 1400 then
            PON = 2
        elseif BasketballShoot then
            PON = 3
        end
        if PON == 1 then
            XofNet = XofNet + 23
        elseif PON == 2 then
            XofNet = XofNet - 23
        elseif PON == 3 then
            Yofbasketball = Yofbasketball + 20
            if Yofbasketball >= 725 and XofNet >= 450 and XofNet <= 550 then
                PON = 1
                CurrentScreen = "Palais des trophée"
                Yofbasketball = 150
                XofNet = 80
                BasketballShoot = false
                TriggerVictory()
            elseif Yofbasketball >= 800 then
                PON = 1
                CurrentScreen = "Palais des trophée"
                Yofbasketball = 150
                XofNet = 80
                BasketballShoot = false
            end
        end
    end
    if CurrentScreen == "Game" and not IsCreativeMode then
        UpdateMissions()
    end
    if CurrentScreen == "Palais des trophée" then
        if love.keyboard.isDown("right") then
            XofPDT = XofPDT - 35
        elseif love.keyboard.isDown("left") then
            XofPDT = XofPDT + 35
        end
    end
    if CurrentScreen == "MiniGames" then
        if love.keyboard.isDown("up") then
            YofMG = YofMG - 20
        elseif love.keyboard.isDown("down") then
            YofMG = YofMG + 20
        end
    end
    if not Hello_Jeremy then
        PrincipalMusic:setVolume(VolumeOfMusic)
        HomeMusic:setVolume(VolumeOfMusic)
        ExclusiveMusic:setVolume(VolumeOfMusic)
        ShootSound:setVolume(VolumeOfEffects)
        GameOverSound:setVolume(VolumeOfEffects)
        BuzzSound:setVolume(VolumeOfEffects)
        AlertSound:setVolume(VolumeOfEffects)
        if YofBoss <= 0 then
            PV = PV - PV
        end
        if #Enemis ~= 0 and Money ~= 0 and Level == 3 then
            Money = Money - 0.1
        end
        if PV_Of_Boss <= 0 then -- Le boss est mort
            Money = Money + 440
            PV_Of_Boss = 80
            WinTheBoss = true
            Levels_Unlocked = Levels_Unlocked + 1
            Boss = false
            Start_New_Wave()
        end
        if WinTheBoss then
            TimerOfVisible = TimerOfVisible - dt
            if TimerOfVisible <= 0 then
                WinTheBoss = false
            end
        end

        if PrintDebug then
            print("currentWave:" .. CurrentWave)
        end

        if CurrentWave == 3 and Level == 1 or Level == 2 then
            MaxEnnemisPerWave = 0
            Boss = true
            AlertSound:play()
        end

        if CurrentWave == 4 and Level == 3 or Level == 4 then
            MaxEnnemisPerWave = 0
            Boss = true
            AlertSound:play()
        end
        if CurrentWave >= 0 and CurrentWave ~= 3 and Level == 2 or Level == 4 then --je sais c'est pas propre mais il y avait un bug tellement agaçant que je n'ai pas pu m'en empêcher...
            Boss = false
        end
        -- Ajouter des ennemis jusqu'à en avoir 7
        if not Boss then
            if #Enemis == 0 then
                WaveInProgress = false
                TimeBeforeNextWave = TimeBeforeNextWave - dt
                if math.ceil(TimeBeforeNextWave) <= 0 then
                    Start_New_Wave()
                    if Level == 1 or Level == 3 or Level == 4 then
                        while #Enemis < MaxEnnemisPerWave do
                            table.insert(Enemis, { y = Y_Of_Enemis, x = 700, s = 150 })
                            Y_Of_Enemis = Y_Of_Enemis + math.random(50, 85)
                        end
                    elseif Level == 2 then
                        while #Enemis < MaxEnnemisPerWave do
                            table.insert(Enemis, { y = Y_Of_Enemis, x = 700, s = SpeedOfEnemis + math.random(-100, 150) })
                            Y_Of_Enemis = Y_Of_Enemis + math.random(50, 85)
                        end
                    end
                end
            end
        end
        -- Mise à jour des ennemis
        for i = #Enemis, 1, -1 do
            local ennemi = Enemis[i]
            if not ennemi.isFrezzing then
                ennemi.y = ennemi.y - ennemi.s * dt
            else
                ennemi.y = ennemi.y - (ennemi.s * 0.25) * dt -- ralenti pendant gel
                ennemi.cooldown = (ennemi.cooldown or 0) - dt
                if ennemi.cooldown <= 0 then
                    ennemi.isFrezzing = false
                end
            end
            if ennemi.y <= 50 then
                table.remove(Enemis, i)
                if not IsCreativeMode then
                    PV = PV - 1
                end
            end
        end
        --Mise à jour du Boss
        if Boss then
            if not BossisFrezzing then
                YofBoss = YofBoss - 25 * dt
            elseif BossisFrezzing then
                YofBoss = YofBoss - (25 * 0.25) * dt
                BossCooldown = (BossCooldown or 0) - dt
                if BossCooldown <= 0 then
                    BossisFrezzing = false
                end
            end
            --Attaque du Boss
            CooldownShoot = (CooldownShoot or 0) - dt
            if CooldownShoot <= 0 then
                for i = 1, (#Object / 2) do
                    table.remove(Object, math.random(1, #Object))
                    CooldownShoot = 6.5
                end
            end
        end

        -- Tirer des balles avec cooldown par canon
        for _, canon in ipairs(Object) do
            if canon.m == "Glace" then
                goto skip
            end
            if canon.m == "Mitraillette" then
                if canon.shoot == 15 then
                    canon.shoot = 0
                    canon.cooldown = 3
                end
                canon.cooldown = (canon.cooldown or 0) - dt
                if not Boss and CurrentScreen == "Game" then
                    for _, ennemi in ipairs(Enemis) do
                        if math.abs(ennemi.y - canon.y) <= 100 then
                            if canon.cooldown <= 0 then
                                table.insert(Ball, { y = canon.y, x = canon.x, type = canon.m })
                                ShootSound:stop()
                                ShootSound:play()
                                canon.cooldown = 0.3
                                if canon.shoot == nil then
                                    canon.shoot = 0
                                else
                                    canon.shoot = canon.shoot + 1
                                end
                            end
                        end
                    end
                elseif Boss and CurrentScreen == "Game" then
                    if math.abs(YofBoss - canon.y) <= 100 then
                        if canon.cooldown <= 0 then
                            table.insert(Ball, { y = canon.y, x = canon.x, type = "Mitraillette" })
                            ShootSound:stop()
                            ShootSound:play()
                            canon.cooldown = 0.3
                            if canon.shoot == nil then
                                canon.shoot = 0
                            else
                                canon.shoot = canon.shoot + 1
                            end
                        end
                    end
                end
            end
            if canon.m == "Bombe" then
                canon.cooldown = (canon.cooldown or 0) - dt
                if not Boss and CurrentScreen == "Game" then
                    for _, ennemi in ipairs(Enemis) do
                        if math.abs(ennemi.y - canon.y) <= 10 then
                            if canon.cooldown <= 0 then
                                table.insert(Ball, { y = canon.y, x = canon.x, type = "Bombe" })
                                ShootSound:stop()
                                ShootSound:play()
                                canon.cooldown = 7
                            end
                        end
                    end
                elseif Boss and CurrentScreen == "Game" then
                    if math.abs(YofBoss - canon.y) <= 100 then
                        if canon.cooldown <= 0 then
                            table.insert(Ball, { y = canon.y, x = canon.x, type = "Bombe" })
                            ShootSound:stop()
                            ShootSound:play()
                            canon.cooldown = 7
                        end
                    end
                end
            end
            canon.cooldown = (canon.cooldown or 0) - dt
            if not Boss and CurrentScreen == "Game" then
                if canon.m == "Canon" then
                    for _, ennemi in ipairs(Enemis) do
                        if math.abs(ennemi.y - canon.y) <= 10 then
                            if (canon.cooldown == nil or canon.cooldown <= 0) then
                                table.insert(Ball, { y = canon.y, x = canon.x })
                                ShootSound:stop()
                                ShootSound:play()
                                canon.cooldown = 1
                            end
                        end
                    end
                end
            elseif Boss and CurrentScreen == "Game" then
                if canon.m == "Canon" then
                    if math.abs(YofBoss - canon.y) <= 100 then
                        if (canon.cooldown == nil or canon.cooldown <= 0) then
                            table.insert(Ball, { y = canon.y, x = canon.x })
                            ShootSound:stop()
                            ShootSound:play()
                            canon.cooldown = 1
                        end
                    end
                end
            end
            ::skip::
        end
        -- Tirer des ballesGlace avec cooldown par canon
        for _, canon in ipairs(Object) do
            if canon.m == "Canon" or canon.m == "Mitraillette" or canon.m == "Bombe" then
                goto skip
            end
            if canon.m == "Téléporteur" then
                canon.cooldown = (canon.cooldown or 0) - dt
                if not Boss and CurrentScreen == "Game" then
                    for _, ennemi in ipairs(Enemis) do
                        if math.abs(ennemi.y - canon.y) <= 10 then
                            if canon.cooldown <= 0 then
                                table.insert(BallGlace, { y = canon.y, x = canon.x, type = "Téléporteur" })
                                ShootSound:stop()
                                ShootSound:play()
                                canon.cooldown = 3.5
                            end
                        end
                    end
                elseif Boss and CurrentScreen == "Game" then
                    if math.abs(YofBoss - canon.y) <= 100 then
                        if canon.cooldown <= 0 then
                            table.insert(BallGlace, { y = canon.y, x = canon.x, type = canon.m })
                            ShootSound:stop()
                            ShootSound:play()
                            canon.cooldown = 11
                        end
                    end
                end
            else
                if not Boss and CurrentScreen == "Game" then
                    for _, ennemi in ipairs(Enemis) do
                        if math.abs(ennemi.y - canon.y) <= 10 then
                            if canon.cooldown <= 0 then
                                table.insert(BallGlace, { y = canon.y, x = canon.x, type = "Glace" })
                                ShootSound:stop()
                                ShootSound:play()
                                canon.cooldown = 1
                            end
                        end
                    end
                elseif Boss and CurrentScreen == "Game" then
                    if math.abs(YofBoss - canon.y) <= 100 then
                        canon.cooldown = (canon.cooldown or 0) - dt
                        if canon.cooldown == nil then
                            canon.cooldown = 0
                        end
                        if canon.cooldown <= 0 then
                            table.insert(BallGlace, { y = canon.y, x = canon.x, type = "Glace" })
                            ShootSound:stop()
                            ShootSound:play()
                            canon.cooldown = 3
                        end
                    end
                end
            end
            canon.cooldown = (canon.cooldown or 0) - dt
            ::skip::
        end

        -- Mise à jour des balles
        for i = #Ball, 1, -1 do
            local ball = Ball[i]
            ball.x = ball.x + 750 * dt
            for j = #Enemis, 1, -1 do
                local ennemi = Enemis[j]
                if not Boss then
                    if ball.type == "Bombe" then
                        if math.abs(ball.x - ennemi.x) <= 25 and math.abs(ball.y - ennemi.y) <= 150 then
                            table.remove(Ball, i)
                            EnnemisKilled = EnnemisKilled + 1
                            table.remove(Enemis, j)
                            if not IsCreativeMode then
                                Money = Money + 10
                            end
                        end
                    else
                        if math.abs(ball.x - ennemi.x) <= 35 and math.abs(ball.y - ennemi.y) <= 25 then
                            table.remove(Ball, i)
                            EnnemisKilled = EnnemisKilled + 1
                            table.remove(Enemis, j)
                            if not IsCreativeMode then
                                Money = Money + 10
                                break
                            end
                        end
                    end
                end
            end
        end
        --Quand c'est le boss
        if Boss then
            for i = #Ball, 1, -1 do
                local ball = Ball[i]
                if ball.type == "Bombe" then
                    if math.abs(ball.y - YofBoss) <= 150 and math.abs(ball.x - XofBoss) <= 50 then
                        table.remove(Ball, i)
                        PV_Of_Boss = PV_Of_Boss - 5
                        if not IsCreativeMode then
                            Money = Money + 10
                        end
                    end
                else
                    if math.abs(ball.x - XofBoss) <= 50 and math.abs(ball.y - YofBoss) <= 150 then
                        table.remove(Ball, i)
                        if ball.type == "Mitraillette" then
                            PV_Of_Boss = PV_Of_Boss - 0.35
                        else
                            PV_Of_Boss = PV_Of_Boss - 1
                        end
                        if not IsCreativeMode then
                            Money = Money + 10
                            break
                        end
                    end
                end
            end
        end
        -- Mise à jour des balls-glaces
        for i = #BallGlace, 1, -1 do
            local ballGlace = BallGlace[i]
            ballGlace.x = ballGlace.x - 750 * dt
            if not Boss then
                if ballGlace.type == "Glace" then
                    for j = #Enemis, 1, -1 do
                        local ennemi = Enemis[j]
                        if math.abs(ballGlace.x - ennemi.x) <= 35 and math.abs(ballGlace.y - ennemi.y) <= 25 then
                            table.remove(BallGlace, i)
                            ennemi.isFrezzing = true
                            ennemi.cooldown = 3
                            break
                        end
                    end
                elseif ballGlace.type == "Téléporteur" then
                    for j = #Enemis, 1, -1 do
                        local ennemi = Enemis[j]
                        if math.abs(ballGlace.x - ennemi.x) <= 35 and math.abs(ballGlace.y - ennemi.y) <= 25 then
                            table.remove(BallGlace, i)
                            ennemi.cooldown = 8
                            ennemi.y = ennemi.y + 200
                            break
                        end
                    end
                end
            elseif Boss then
                if ballGlace.type == "Glace" then
                    if math.abs(ballGlace.x - XofBoss) <= 10 and math.abs(ballGlace.y - YofBoss) <= 110 then
                        table.remove(BallGlace, i)
                        BossisFrezzing = true
                        BossCooldown = .5
                        break
                    end
                elseif ballGlace.type == "Téléporteur" then
                    if math.abs(ballGlace.x - XofBoss) <= 25 and math.abs(ballGlace.y - YofBoss) <= 175 then
                        table.remove(BallGlace, i)
                        BossCooldown = 8
                        YofBoss = YofBoss + 200
                        break
                    end
                end
            end
        end
    end
end

-- Fonction appelée quand on clique
function love.mousepressed(x, y, button)
    if PrintDebug then
        print("if you d'ont have this message went you click:Errors")
        print("Button:" .. button)
    end
    if not Hello_Jeremy then
        if button == 1 then
            print("XofNet:" .. XofNet)
            if CurrentScreen == "MiniGames1" then
                BasketballShoot = true
            end
            if PrintDebug then
                print("Starting:" .. tostring(Starting))
            end
            if not Starting then
                if Within(600, 150, x, y, 200, 1500) and PV > 0 then --Bouton de la glace
                    if Within(550, 625, x, y, 150, 150) then
                        if Money >= 0 then
                            Mode = "Glace"
                        end
                    end
                    if Within(750, 625, x, y, 150, 150) and Level ~= 4 then --Bouton de la bombe
                        if Money > 0 then
                            Mode = "Bombe"
                        end
                    end
                    if Within(550, 300, x, y, 300, 100) and CurrentScreen == "Home" and not Tutorial then
                        HomeMusic:stop()
                        CurrentScreen = "Game"
                        Mission7var2 = true
                        if not ExclusiveMusictrueorfalse then
                            PrincipalMusic:play()
                        else
                            ExclusiveMusic:play()
                        end
                        Object = {}
                        Enemis = {}
                        Ball = {}
                        BallGlace = {}
                        Y_Of_Enemis = 800
                        Money = 200
                        PV = 20
                        SpeedOfEnemis = 150
                        IsCreativeMode = false
                        Mode = "Canon"
                        CurrentWave = 0
                        WaveInProgress = false
                        TimeBeforeNextWave = 5
                        MaxEnnemisPerWave = 10
                        Boss = false
                        WinTheBoss = false
                        XofBoss = 700
                        YofBoss = 700
                        if Level == 1 then
                            PV_Of_Boss = 40
                        elseif Level == 2 then
                            PV_Of_Boss = 80
                        elseif Level == 3 then
                            PV_Of_Boss = 150
                        elseif Level == 4 then
                            PV_Of_Boss = 200
                        end
                        TimerOfVisible = 3
                        CooldownShoot = 6.5
                        BossisFrezzing = false
                        love.graphics.setFont(Font)
                    elseif Within(550, 500, x, y, 300, 100) and CurrentScreen == "Home" and not Tutorial then
                        CurrentScreen = "Game"
                        Mission7var2 = true
                        HomeMusic:stop()
                        if not ExclusiveMusictrueorfalse then
                            PrincipalMusic:play()
                        else
                            ExclusiveMusic:play()
                        end
                        Object = {}
                        Enemis = {}
                        Ball = {}
                        BallGlace = {}
                        Y_Of_Enemis = 800
                        Money = 200
                        PV = 20
                        SpeedOfEnemis = 150
                        IsCreativeMode = true
                        Mode = "Canon"
                        CurrentWave = 0
                        WaveInProgress = false
                        TimeBeforeNextWave = 5
                        MaxEnnemisPerWave = 10
                        Boss = false
                        WinTheBoss = false
                        XofBoss = 700
                        YofBoss = 700
                        if Level == 1 then
                            PV_Of_Boss = 40
                        elseif Level == 2 then
                            PV_Of_Boss = 80
                        elseif Level == 3 then
                            PV_Of_Boss = 200
                        end
                        TimerOfVisible = 3
                        CooldownShoot = 6.5
                        BossisFrezzing = false
                        love.graphics.setFont(Font)
                    end
                    if Within(550, 700, x, y, 300, 100) and CurrentScreen == "Home" and not Tutorial then
                        CurrentScreen = "Levels"
                    end
                    if Within(700, 300, x, y, 20, 20) and CurrentScreen == "Settings" then
                        VolumeOfEffects = VolumeOfEffects - 0.1
                    end
                    if Within(700, 500, x, y, 20, 20) and CurrentScreen == "Settings" then
                        VolumeOfMusic = VolumeOfMusic - 0.1
                    end
                    return
                end
                if not Within(0, 600, x, y, 1500, 200) and not Within(150, 150, x, y, 200, 100) and not Within(510, 5, x, y, 400, 100) then
                    if Money > 0 and not IsCreativeMode and CurrentScreen == "Game" then
                        if Mode == "Glace" then
                            if Money - 50 >= 0 then
                                Money = Money - 50
                                table.insert(Object, { x = x, y = y, m = Mode })
                            elseif CurrentScreen == "Game" then
                                BuzzSound:stop()
                                BuzzSound:play()
                            end
                        elseif Mode == "Canon" then
                            if Money - 100 >= 0 and CurrentScreen == "Game" then
                                Money = Money - 100
                                table.insert(Object, { x = x, y = y, m = Mode })
                            elseif CurrentScreen == "Game" then
                                BuzzSound:stop()
                                BuzzSound:play()
                            end
                        elseif Mode == "Mitraillette" then
                            if Money - 175 >= 0 and CurrentScreen == "Game" then
                                Mission9 = false
                                Mission7var2 = false
                                Money = Money - 175
                                table.insert(Object, { x = x, y = y, m = Mode })
                            elseif CurrentScreen == "Game" then
                                BuzzSound:stop()
                                BuzzSound:play()
                            end
                        elseif Mode == "Bombe" then
                            if Money - 225 >= 0 and CurrentScreen == "Game" then
                                Mission9 = false
                                Mission7var2 = false
                                Money = Money - 225
                                table.insert(Object, { x = x, y = y, m = Mode })
                            elseif CurrentScreen == "Game" then
                                BuzzSound:stop()
                                BuzzSound:play()
                            end
                        elseif Mode == "Téléporteur" then
                            if Money - 125 >= 0 and CurrentScreen == "Game" then
                                Mission9 = false
                                Money = Money - 125
                                table.insert(Object, { x = x, y = y, m = Mode })
                            elseif CurrentScreen == "Game" then
                                BuzzSound:stop()
                                BuzzSound:play()
                            end
                        end
                    elseif IsCreativeMode and CurrentScreen == "Game" then
                        table.insert(Object, { x = x, y = y, m = Mode })
                    elseif CurrentScreen == "Game" then
                        BuzzSound:stop()
                        BuzzSound:play()
                    end
                end
                -- Mitraillette : x = 150
                -- Canon       : x = 350
                -- Glace       : x = 550
                -- Bombe       : x = 750
                if Within(150, 625, x, y, 150, 150) and Level ~= 4 then
                    if Money > 0 then
                        Mode = "Mitraillette"
                    end
                end
                if Within(350, 625, x, y, 150, 150) then
                    Mode = "Canon"
                end
                if Within(550, 625, x, y, 150, 150) then
                    Mode = "Glace"
                end
                if Within(750, 625, x, y, 150, 150) and Level ~= 4 then
                    Mode = "Bombe"
                end
                if Within(950, 625, x, y, 150, 150) then
                    if Levels_Unlocked >= 2 then
                        Mode = "Téléporteur"
                    end
                end
                if Within(510, 5, x, y, 400, 100) and PV > 0 and not IsCreativeMode then
                    IsCreativeMode = true
                    Object = {}
                    Enemis = {}
                    Ball = {}
                    BallGlace = {}
                    Y_Of_Enemis = 800
                    Money = 200
                    PV = 20
                    SpeedOfEnemis = 150
                    Mode = "Canon"
                    CurrentWave = 0
                    WaveInProgress = false
                    TimeBeforeNextWave = 5
                    MaxEnnemisPerWave = 10
                    love.graphics.setFont(Font)
                elseif IsCreativeMode and Within(510, 5, x, y, 400, 100) and PV > 0 then
                    IsCreativeMode = false
                    Object = {}
                    Enemis = {}
                    Ball = {}
                    BallGlace = {}
                    Y_Of_Enemis = 800
                    Money = 200
                    PV = 20
                    SpeedOfEnemis = 150
                    Mode = "Canon"
                    CurrentWave = 0
                    WaveInProgress = false
                    TimeBeforeNextWave = 5
                    MaxEnnemisPerWave = 10
                    love.graphics.setFont(Font)
                end
                if Within(400, 400, x, y, 555, 250) and PV == 0 then --Bouton retry
                    Object = {}
                    Enemis = {}
                    Ball = {}
                    BallGlace = {}
                    Y_Of_Enemis = 800
                    Money = 200
                    PV = 20
                    SpeedOfEnemis = 150
                    IsCreativeMode = false
                    Mode = "Canon"
                    CurrentWave = 0
                    WaveInProgress = false
                    TimeBeforeNextWave = 5
                    MaxEnnemisPerWave = 10
                    Boss = false
                    WinTheBoss = false
                    XofBoss = 700
                    YofBoss = 700
                    if Level == 1 then
                        PV_Of_Boss = 40
                    elseif Level == 2 then
                        PV_Of_Boss = 80
                    elseif Level == 3 then
                        PV_Of_Boss = 200
                    end
                    TimerOfVisible = 3
                    CooldownShoot = 6.5
                    BossisFrezzing = false
                    love.graphics.setFont(Font)
                end
                if Within(1200, 10, x, y, 100, 100) then
                    CurrentScreen = "Home"
                    HomeMusic:play()
                elseif Within(10, 300, x, y, 400, 100) and CurrentScreen == "Home" then
                    CurrentScreen = "Settings"
                elseif Within(10, 700, x, y, 300, 100) then
                    MissionsScreen = true
                elseif not Within(500, 225, x, y, 1000, 600) and MissionsScreen == true then
                    MissionsScreen = false
                elseif VolumeOfEffects < 0.9 and CurrentScreen == "Settings" and Within(790, 300, x, y, 20, 20) then
                    VolumeOfEffects = VolumeOfEffects + 0.1
                elseif VolumeOfMusic < 0.9 and CurrentScreen == "Settings" and Within(800, 500, x, y, 20, 20) then
                    VolumeOfMusic = VolumeOfMusic + 0.1
                elseif CurrentScreen == "Settings" and Within(10, 350, x, y, 200, 100) and Trophee >= 3000 then
                    ExclusiveMusictrueorfalse = true
                elseif CurrentScreen == "Settings" and Within(10, 500, x, y, 200, 100) then
                    ExclusiveMusictrueorfalse = false
                elseif Within(500, 300, x, y, 200, 100) and CurrentScreen == "Levels" then
                    Level = 1
                elseif Within(1000, 300, x, y, 200, 100) and CurrentScreen == "Levels" and Levels_Unlocked >= 2 then
                    Level = 2
                elseif Within(500, 600, x, y, 200, 100) and CurrentScreen == "Levels" and Levels_Unlocked >= 3 then
                    Level = 3
                elseif Within(1000, 600, x, y, 200, 100) and CurrentScreen == "Levels" and Levels_Unlocked >= 4 then
                    Level = 4
                elseif Within(100, 100, x, y, 200, 100) and CurrentScreen == "Palais des trophée" and Trophee >= 0 then --pas 0:2000
                    CurrentScreen = "MiniGames"
                elseif Within(200, 400 + YofMG, x, y, 1100, 200) and CurrentScreen == "MiniGames" and Trophee >= 0 then --pas 0:2000
                    CurrentScreen = "MiniGames1"
                end
            else
                if Within(175, 350, x, y, 200, 100) then
                    Starting = false
                    CurrentScreen = "Home"
                elseif Within(775, 350, x, y, 200, 100) then
                    Starting = false
                    Tutorial = true
                    CurrentScreen = "Home"
                end
            end

            if Within(10, 440, x, y, 300, 50) and CurrentScreen == "Home" and not Tutorial then
                CurrentScreen = "Palais des trophée"
            end
        elseif button == 2 then
            if not Starting then
                for i, canon in ipairs(Object) do
                    if Within(canon.x - 25, canon.y - 25, x, y, 50, 50) then
                        table.remove(Object, i)
                        if canon.m == "Glace" then
                            Money = Money + 25
                        elseif canon.m == "Canon" then
                            Money = Money + 50
                        elseif canon.m == "Mitraillette" then
                            Money = Money + 88
                        elseif canon.m == "Bombe" then
                            Money = Money + 113
                        elseif canon.m == "Téléporteur" then
                            Money = Money + 63
                        end
                    end
                end
            end
        end
    end
end

-- Fonction d'affichage
function love.draw()
    if not Hello_Jeremy then
        if not Starting then
            --all rectangles
            if CurrentScreen == "Home" then
                love.graphics.setBackgroundColor(1, 1, 1)
            elseif CurrentScreen == "Game" then
                love.graphics.draw(BackgroundLevel1, 0, 0, 0, 2.1)
                if Level == 1 then
                    love.graphics.draw(BackgroundLevel1, 0, 0, 0, 2.1)
                elseif Level == 2 then
                    love.graphics.setBackgroundColor(0, 0, 0)
                    love.graphics.draw(BackgroundLevel2, 0, 0, 0, 2.35)
                elseif Level == 3 then
                    love.graphics.setBackgroundColor(0, 0, 0)
                    love.graphics.draw(BackgroundLevel3, 0, 0, 0, 2.5)
                elseif Level == 4 then
                    love.graphics.setBackgroundColor(0, 0, 0)
                    love.graphics.draw(BackgroundLevel4, 0, 0, 0, 1.5)
                end
            elseif CurrentScreen == "Palais des trophée" then
                love.graphics.setBackgroundColor(0, 0, 0)
                love.graphics.setColor(1, 1, 1)
                if Trophee >= 0 then --pas 0:2000
                    love.graphics.rectangle("fill", 100, 100, 200, 50)
                    love.graphics.setColor(0, 1, 0)
                    love.graphics.setFont(Font)
                    love.graphics.print("Minijeux", 110, 110)
                end
                love.graphics.setFont(Font)
                love.graphics.setColor(1, 1, 1)
                love.graphics.line(0, 400, 1500, 400)
                for i = 1, 10, 1 do
                    love.graphics.line(300 * i + XofPDT, 325, 300 * i + XofPDT, 475)
                    love.graphics.print(Recompenses[i].name, i * 300 - 70 + XofPDT, 500)
                    love.graphics.print(i * 1000 .. " Trophées", 300 * i - 30 + XofPDT, 300)
                end
            elseif CurrentScreen == "MiniGames" then
                love.graphics.setBackgroundColor(math.sin(T), 1, math.cos(T))
                for i = 1, #MG, 1 do
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.setFont(Font2)
                    love.graphics.rectangle("fill", 200, 400 * i + YofMG, 1100, 300 * i - 100)
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.print(MG[i].name, 250, 300 * i + 100 + YofMG)
                end
            elseif CurrentScreen == "MiniGames1" then
                love.graphics.setBackgroundColor(1, 1, 1)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(BasketballImage, 675, Yofbasketball, 0, 0.07)
                love.graphics.draw(NetImage, XofNet, 600, 0, 0.2)
            elseif CurrentScreen == "Levels" then
                if Levels_Unlocked >= 1 then
                    love.graphics.setFont(Font)
                    love.graphics.setColor(0, 1, 0)
                    love.graphics.rectangle("fill", 500, 300, 200, 100)
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.print("Niveau1", 520, 320)
                    if Levels_Unlocked >= 2 then
                        love.graphics.setFont(Font)
                        love.graphics.setColor(0, 1, 0)
                        love.graphics.rectangle("fill", 1000, 300, 200, 100)
                        love.graphics.setColor(1, 1, 1)
                        love.graphics.print("Niveau2", 1020, 320)
                        if Levels_Unlocked >= 3 then
                            love.graphics.setFont(Font)
                            love.graphics.setColor(0, 1, 0)
                            love.graphics.rectangle("fill", 500, 600, 200, 100)
                            love.graphics.setColor(1, 1, 1)
                            love.graphics.print("Niveau3", 520, 620)
                            if Levels_Unlocked >= 4 then
                                love.graphics.setFont(Font)
                                love.graphics.setColor(0, 1, 0)
                                love.graphics.rectangle("fill", 1000, 600, 200, 100)
                                love.graphics.setColor(1, 1, 1)
                                love.graphics.print("Niveau4", 1020, 620)
                            end
                        end
                    end
                end
            end
            if CurrentScreen == "Game" then
                HomeMusic:stop()
                if not ExclusiveMusictrueorfalse then
                    PrincipalMusic:play()
                else
                    ExclusiveMusic:play()
                end
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", 1200, 10, 100, 100)
                love.graphics.draw(HomeImage, 1200, 10, 0, 0.1, 0.1)
                love.graphics.rectangle("fill", 600, 50, 200, 550)
                love.graphics.rectangle("fill", 0, 600, 1500, 200)
                love.graphics.setColor(0.5, 0.5, 0.5) -- Mitraillette
                love.graphics.rectangle("fill", 150, 625, 150, 150)
                love.graphics.setColor(1, 1, 1)
                love.graphics.setFont(FontMini)
                love.graphics.print("Mitraillette", 155, 660)
                love.graphics.setColor(1, 0, 0) -- Canon
                love.graphics.rectangle("fill", 350, 625, 150, 150)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Canon", 380, 660)
                love.graphics.setColor(0, 1, 1) -- Glace
                love.graphics.rectangle("fill", 550, 625, 150, 150)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Glace", 580, 660)
                love.graphics.setColor(0.6, 0, 0) -- Bombe
                love.graphics.rectangle("fill", 750, 625, 150, 150)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Bombe", 780, 660)
                love.graphics.setColor(0.5, 0, 1) -- Téléporteur
                love.graphics.rectangle("fill", 950, 625, 150, 150)
                if Levels_Unlocked >= 2 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.print("Téléporteur", 955, 660)
                end
                if WinTheBoss then
                    love.graphics.setColor(1, 0, 1)
                    love.graphics.setFont(Font)
                    love.graphics.print("Bravo vous avez battu", 600, 300)
                    love.graphics.print("      le boss!", 600, 375)
                    love.graphics.setFont(FontMini)
                    love.graphics.print("Vous avez reçu 500$", 600, 450)
                    love.graphics.setFont(Font)
                end
                if not IsCreativeMode then
                    love.graphics.setColor(0, 1, 0)
                    love.graphics.rectangle("fill", 150, 150, 200, 100)
                    love.graphics.setColor(1, 1, 0)
                    love.graphics.print("Money$$$", 150, 150)
                    love.graphics.print(math.floor(Money), 175, 200)
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.draw(CanonImage, 965, 100, 0, 0.1, 0.1)
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.print(PV, 1000, 200)
                elseif IsCreativeMode then
                    love.graphics.setColor(1, 0, 1)
                    love.graphics.print("MODE CRÉATIF ACTIVÉ", 150, 120)
                end
                if not IsCreativeMode then
                    love.graphics.setFont(Font3)
                    love.graphics.print("Vague:" .. CurrentWave, 40, 0)
                    if not WaveInProgress then
                        love.graphics.setFont(Font)
                        love.graphics.print("Temps restant avant", 40, 60)
                        love.graphics.print("la prochaine vague:" .. math.ceil(TimeBeforeNextWave) .. "s", 40, 100)
                    end
                end
                if Mode == "Canon" then
                    love.graphics.setColor(1, 0, 0)
                elseif Mode == "Glace" then
                    love.graphics.setColor(0, 1, 1)
                elseif Mode == "Mitraillette" then
                    love.graphics.setColor(0.5, 0.5, 0.5)
                elseif Mode == "Bombe" then
                    love.graphics.setColor(0.6, 0, 0)
                elseif Mode == "Téléporteur" then
                    love.graphics.setColor(0.5, 0, 1)
                end
                for _, ennemi in ipairs(Enemis) do
                    if ennemi.y <= 550 then
                        if Level == 1 then
                            love.graphics.setColor(0, 1, 0)
                            love.graphics.circle("fill", ennemi.x, ennemi.y, 25)
                        elseif Level == 2 then
                            love.graphics.setColor(1, 0, 0)
                            love.graphics.circle("fill", ennemi.x, ennemi.y, 25)
                        elseif Level == 3 then
                            love.graphics.setColor(0, 0, 1)
                            love.graphics.circle("fill", ennemi.x, ennemi.y, 30)
                        elseif Level == 4 then
                            love.graphics.setColor(1, 0, 1)
                            love.graphics.circle("fill", ennemi.x, ennemi.y, 30)
                        end
                    end
                end
                for _, ball in ipairs(Ball) do
                    if ball.y <= 550 then
                        love.graphics.setColor(1, 1, 0)
                        if ball.type == "Bombe" then
                            love.graphics.circle("fill", ball.x, ball.y, 75)
                        end
                        love.graphics.circle("fill", ball.x, ball.y, 25)
                    end
                end
                for _, BallGlace in ipairs(BallGlace) do
                    if BallGlace.y <= 550 then
                        love.graphics.setColor(0, 0, 1)
                        love.graphics.circle("fill", BallGlace.x, BallGlace.y, 25)
                    end
                end
                for _, canon in ipairs(Object) do
                    if canon.m == "Canon" then
                        love.graphics.setColor(1, 0, 0)
                    end
                    if canon.m == "Glace" then
                        love.graphics.setColor(0, 1, 1)
                    end
                    if canon.m == "Mitraillette" then
                        love.graphics.setColor(0.5, 0.5, 0.5)
                    end
                    if canon.m == "Bombe" then
                        love.graphics.setColor(0.6, 0, 0)
                    end
                    if canon.m == "Téléporteur" then
                        love.graphics.setColor(0.5, 0, 1)
                    end
                    if not Within(600, 50, canon.x, canon.y, 200, 500) then
                        if canon.m == "Bombe" or canon.m == "Mitraillette" or canon.m == "Canon" then
                            love.graphics.draw(Heart, canon.x - 150, canon.y - 180, 0, 0.6)
                        elseif canon.m == "Glace" or canon.m == "Téléporteur" then
                            love.graphics.draw(Heart, canon.x + 150, canon.y + 180, 110, 0.6)
                        end
                    end
                end
                if Boss then
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.circle("fill", XofBoss, YofBoss, 100)
                    love.graphics.setColor(0, 1, 0)
                    love.graphics.print(PV_Of_Boss, 650, YofBoss - 150)
                end
                if Levels_Unlocked < 2 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.setFont(Font)
                    love.graphics.print("??????", 960, 680)
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.draw(CadenasImage, 920, 585, 0, 0.2, 0.2) -- les coordonnées
                end
                love.graphics.setColor(0, 1, 0)
                love.graphics.rectangle("fill", 510, 5, 400, 100)
                love.graphics.setColor(1, 1, 1)
                love.graphics.setFont(Font3)
                love.graphics.print("Mode Créatif", 530, 10)
                love.graphics.setFont(Font)
                if PV == 0 then
                    ShootSound:stop()
                    GameOverSound:play()
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("fill", 0, 0, 1500, 800)
                    love.graphics.setColor(1, 0, 0)
                    love.graphics.setFont(Font2)
                    love.graphics.print("Game Over...", 50, 150)
                    love.graphics.rectangle("fill", 400, 400, 555, 250)
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.print("Retry", 400, 400)
                end
            elseif CurrentScreen == "Levels" then
                love.graphics.draw(HomeImage, 1200, 10, 0, 0.1, 0.1)
            elseif CurrentScreen == "Home" then
                ExclusiveMusic:stop()
                PrincipalMusic:stop()
                HomeMusic:play()
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 550, 300, 300, 100)
                love.graphics.setFont(Font3)
                love.graphics.setColor(0, 1, 0)
                love.graphics.print("Jouer", 610, 325)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 10, 300, 400, 100)
                love.graphics.setFont(Font3)
                love.graphics.setColor(0, 1, 0)
                love.graphics.print("Paramètres", 70, 325)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 550, 500, 300, 100)
                love.graphics.setColor(0, 1, 0)
                love.graphics.setFont(Font)
                love.graphics.print("Mode Créatif", 610, 525)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 550, 700, 300, 100)
                love.graphics.setColor(0, 1, 0)
                love.graphics.setFont(Font3)
                love.graphics.print("Levels", 610, 725)
                love.graphics.setFont(Font)
                love.graphics.print("The official game of", 610, 10)
                love.graphics.setFont(Font2)
                love.graphics.print("   Tower Defense", -180, 50)
                love.graphics.setFont(Font3)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 10, 700, 300, 100)
                love.graphics.setColor(0, 1, 0)
                love.graphics.print("Missions", 70, 725)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("fill", 10, 500, 400, 125)
                love.graphics.setColor(0, 1, 0)
                if Trophee >= 10000 then
                    love.graphics.setColor(math.sin(T), 1, math.cos(T))
                end
                love.graphics.print("Trophées", 70, 515)
                love.graphics.print(Trophee, 70, 560)
                love.graphics.rectangle("fill", 10, 440, 300, 50)
                love.graphics.setFont(FontMini)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print("Palais des trophée", 40, 450)
                if MissionsScreen == true then
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("fill", 500, 225, 1000, 600)
                    love.graphics.setFont(Font)
                    love.graphics.print("Missions", 50, 700)
                    for i, mission in ipairs(Missions) do
                        local status = mission.done and "[✓]" or "[ ]"
                        love.graphics.setFont(FontMini)
                        love.graphics.setColor(0, 1, 0)
                        love.graphics.print(status .. " " .. mission.name, 500, 200 + i * 30)
                    end
                end
            elseif CurrentScreen == "Settings" then
                love.graphics.draw(HomeImage, 1200, 10, 0, 0.1, 0.1)
                love.graphics.setFont(Font3)
                love.graphics.print("Sons(effets)", 700, 200)
                love.graphics.rectangle("line", 700, 300, 20, 20)
                love.graphics.rectangle("line", 800, 300, 20, 20)
                love.graphics.print("-", 700, 275)
                love.graphics.setFont(FontMini)
                love.graphics.print("+", 797, 293)
                love.graphics.setFont(Font3)
                love.graphics.print("Sons(musique)", 700, 400)
                love.graphics.rectangle("line", 700, 500, 20, 20)
                love.graphics.rectangle("line", 800, 500, 20, 20)
                love.graphics.print("-", 700, 475)
                love.graphics.setFont(FontMini)
                love.graphics.print("+", 797, 493)
                if Trophee >= 3000 then
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("fill", 10, 350, 500, 100)
                    love.graphics.setColor(math.sin(T), 1, math.cos(T))
                    love.graphics.setFont(Font)
                    love.graphics.print("Musique exclusive", 50, 390)
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("fill", 10, 500, 500, 100)
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.print("Musique normale", 50, 550)
                end
                love.graphics.setColor(0, 0, 0)
                love.graphics.print(
                    "VolumeOfEffects" .. ":" .. VolumeOfEffects .. "VolumeOfMusic" .. ":" .. VolumeOfMusic,
                    300,
                    100) --debug
            end

            if PrintDebug then
                print("TutorialScreen:" .. TutorialScreen)
            end
            if Level == 4 and CurrentWave == 1 then
                love.graphics.setFont(FontMini)
                love.graphics.setColor(1, 0, 0)
                love.graphics.print("Bris mécanique:certaines tourelles sont surglucidés!", 30, 400)
                love.graphics.setFont(Font2)
                love.graphics.print("x", 150, 625)
                love.graphics.print("x", 750, 625)
                love.graphics.setFont(Font)
                love.graphics.setColor(1, 1, 1)
            end
            if Tutorial and TutorialScreen == "1" then
                CurrentScreen = "Home"
                love.graphics.setColor(0, 0, 0)
                love.graphics.draw(FingerImage, 200, 350, -100, Size_Of_Finger)
                if Size_Of_Finger >= 0.2 then
                    Size_Of_Finger = Size_Of_Finger - 0.001
                elseif Size_Of_Finger <= 0.17 then
                    Size_Of_Finger = Size_Of_Finger + 0.001
                end
            elseif Tutorial and TutorialScreen == "2" then
                CurrentScreen = "Settings"
                love.graphics.setFont(Font2)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print("Paramètres", 200, 500)
                love.graphics.setColor(0, 1, 0)
            elseif TutorialScreen == "3" then
                CurrentScreen = "Home"
                love.graphics.setColor(0, 0, 0)
                love.graphics.draw(FingerImage, 850, 750, -90, Size_Of_Finger)
                if Size_Of_Finger >= 0.2 then
                    Size_Of_Finger = Size_Of_Finger - 0.001
                elseif Size_Of_Finger <= 0.17 then
                    Size_Of_Finger = Size_Of_Finger + 0.001
                end
            elseif TutorialScreen == "4" then
                CurrentScreen = "Levels"
                love.graphics.setFont(Font2)
                love.graphics.setColor(0, 0, 0)
                love.graphics.print("niveaux", 200, 500)
                love.graphics.setColor(0, 1, 0)
            elseif TutorialScreen == "5" then
                CurrentScreen = "Home"
                love.graphics.setColor(0, 0, 0)
                love.graphics.draw(FingerImage, 850, 400, -90, Size_Of_Finger)
                if Size_Of_Finger >= 0.2 then
                    Size_Of_Finger = Size_Of_Finger - 0.001
                elseif Size_Of_Finger <= 0.17 then
                    Size_Of_Finger = Size_Of_Finger + 0.001
                end
                love.graphics.setColor(0, 1, 0)
            elseif TutorialScreen == "6" and PV > 0 then
                CurrentScreen = "Game"
                Mission7var2 = true
                love.graphics.setColor(1, 0, 0, 0.5)
                love.graphics.rectangle("fill", 0, 0, 600, 600)
                love.graphics.setColor(1, 0, 0)
                love.graphics.print("Attaque", 350, 400)
                love.graphics.setColor(0, 1, 0, 0.5)
                love.graphics.rectangle("fill", 800, 0, 700, 600)
                love.graphics.setColor(0, 1, 0)
                love.graphics.print("Contrôle", 850, 400)
                love.graphics.print("Contrôle", 555, 615)
                love.graphics.print("Contrôle", 955, 615)
                love.graphics.print("Attaque", 155, 615)
                love.graphics.print("Attaque", 355, 615)
                love.graphics.print("Attaque", 755, 615)
            elseif TutorialScreen == "7" and PV > 0 then
                CurrentScreen = "Home"
                Tutorial = false
                Starting = false
                TutorialScreen = 0
            end
        else
            love.graphics.setColor(0, 1, 0)
            love.graphics.setFont(Font)
            love.graphics.print("The official game of", 610, 10)
            love.graphics.setFont(Font2)
            love.graphics.print("   Tower Defense", -180, 50)
            love.graphics.setFont(Font)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 175, 350, 200, 100)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Débuter", 200, 400)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 775, 350, 200, 100)
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Débuter", 780, 385)
            love.graphics.print("le tutoriel", 780, 415)
        end
    elseif Hello_Jeremy then
        love.graphics.setFont(Font)
        ExclusiveMusic:stop()
        PrincipalMusic:stop()
        HomeMusic:stop()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Hello_ Jeremy_ What_ Do_ You_ Want?", 400, 400)
        love.graphics.setFont(FontMini)
        love.graphics.print(
            "1.Have 10000$    2.Have 150PV    3.Exit out secret room    4.Activate_Debug    5.Desactive_Debug", 30, 500)
        love.graphics.print("6.UnlockedAllLevels", 30, 550)
    end
    if Victory then
        for _, confetti in ipairs(Confetti) do
            love.graphics.setColor(confetti.color)
            love.graphics.rectangle("fill", confetti.x, confetti.y, 5, 10)
        end

        love.graphics.setColor(1, 1, 0)
        love.graphics.setFont(love.graphics.newFont(VictoryFontSize))
        love.graphics.printf("VICTORY!", 0, 300, 1500, "center")
        love.graphics.setFont(Font) -- Reset your custom font
    end
end

--Debug
local love_errorhandler = love.errorhandler
function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end

--erreurs
--Détecter le clic sur le bouton Mode Creatif et jouer dans menu
--aucune erreurs😁
--pas 0:2000
