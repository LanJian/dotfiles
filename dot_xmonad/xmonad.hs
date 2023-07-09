import qualified Data.Map as M
import Data.Ratio ((%))
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Actions.TopicSpace
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Accordion
import XMonad.Layout.Column
import XMonad.Layout.Combo
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.PerWorkspace
import XMonad.Prompt
import XMonad.Prompt.AppendFile
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.StackSet as W
import System.IO

myTopics :: [Topic]
myTopics =
    [ "web"
    , "code"
    , "cli-1"
    , "cli-2"
    , "cli-3"
    , "cli-4"
    , "music"
    , "slack"
    , "personal"
    ]

myTopicConfig :: TopicConfig
myTopicConfig = defaultTopicConfig
    { topicDirs = M.fromList $
        [ ("web", "w/code")
        ]
    , defaultTopic = "work"
    , defaultTopicAction = const $ spawn "gnome-terminal"
    , topicActions = M.fromList $
        [ ("web", spawn "firefox")
        , ("code", spawn "gnome-terminal")
        ]
    }

spawnShell :: X ()
spawnShell = currentTopicDir myTopicConfig >>= spawnShellIn

spawnShellIn :: Dir -> X ()
spawnShellIn dir = spawn $ "gnome-terminal --working-directory=" ++ dir

layout = onWorkspace "web" (noBorders Full ||| tiled ||| Mirror tiled ||| OneBig (3/4) (3/4)) $
         onWorkspace "code" (noBorders Full ||| tiled ||| Mirror tiled ||| Grid ||| Accordion) $
         onWorkspace "cli" primaryCli $
         onWorkspace "cssh" (Grid ||| tiled ||| Mirror tiled ||| noBorders Full) $
         onWorkspace "chat" (withIM (1%7) (Role "buddy_list") Grid ||| Full ||| tiled ||| Mirror tiled) $
         def
    where
        def = tiled ||| Mirror tiled ||| noBorders Full ||| Grid ||| Accordion
        primaryCli = Mirror cliLayout ||| tiled ||| noBorders Full ||| Grid ||| Accordion
        tiled = Tall nmaster delta ratio
        cliLayout = Tall cliNMaster delta cliRatio
        nmaster = 1
        ratio = 1/2
        cliNMaster = 2
        cliRatio = 2/3
        delta = 3/100

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
        ([ ((modm .|. shiftMask, xK_g), windowPromptGoto defaultXPConfig { autoComplete = Just 500000 } )
        , ((modm .|. shiftMask, xK_b), windowPromptBring defaultXPConfig { autoComplete = Just 500000 } )
        , ((modm .|. controlMask, xK_x), shellPrompt defaultXPConfig)
        , ((modm .|. controlMask, xK_semicolon), spawn "$HOME/.scripts/turn_off_screen")
        , ((modm .|. controlMask, xK_l), spawn "xscreensaver-command -lock")
        , ((modm, xK_p), spawn "rofi -combi-modi window,drun -show combi -modi combi -show-icons")
        , ((modm .|. shiftMask, xK_p), spawn "$HOME/.scripts/passmenu pass")
        , ((modm .|. shiftMask, xK_o), spawn "$HOME/.scripts/passmenu otp")
        , ((modm .|. shiftMask, xK_bracketleft), spawn "$HOME/.scripts/passmenu login")
        , ((modm .|. shiftMask, xK_backslash), spawn "$HOME/.scripts/passmenu login")
        , ((modm .|. shiftMask, xK_s), spawn "$HOME/.scripts/screenshot")
        , ((modm .|. shiftMask, xK_t), spawn "$HOME/.scripts/iso_date")
        , ((modm, xK_a), currentTopicAction myTopicConfig)
        , ((modm, xK_g), promptedGoto)
        , ((modm .|. shiftMask, xK_g), promptedGoto)
        , ((0, 0x1008FF12), spawn "amixer -D pulse set Master toggle")
        , ((0, 0x1008FF11), spawn "amixer set Master 5%-")
        , ((0, 0x1008FF13), spawn "amixer set Master 5%+")
        ]
        ++
        [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]])


goto :: Topic -> X ()
goto = switchTopic myTopicConfig

promptedGoto :: X ()
promptedGoto = workspacePrompt defaultXPConfig goto

promptedShift :: X ()
promptedShift = workspacePrompt defaultXPConfig $ windows . W.shift

spawnToWorkspace :: String -> String -> X()
spawnToWorkspace program workspace = spawn program >> (windows $ W.greedyView workspace)

newKeys x = myKeys x `M.union` keys defaultConfig x

bar = "xmobar"

--unused
barPP = xmobarPP { ppCurrent = xmobarColor "green" "" .shorten 100 }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

main :: IO ()
main = do
    checkTopicConfig myTopics myTopicConfig
    xmproc <- spawnPipe "xmobar $HOME/.xmobarrc"
    --xmonad $ ewmh def
    xmonad $ ewmh def
        { terminal = "gnome-terminal"
        , workspaces = myTopics
        , borderWidth = 4
        , focusedBorderColor = "#CB07B0"
        , normalBorderColor = "#333333"
        , layoutHook = avoidStruts $ layout
        , handleEventHook = docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "orange" "" .shorten 100
            , ppCurrent = xmobarColor "orange" "" .wrap "[" "]"
            }
        , keys = newKeys
        , modMask = mod1Mask
        , startupHook = return ()
        }

