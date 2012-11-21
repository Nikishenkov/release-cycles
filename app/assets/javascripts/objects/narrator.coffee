class window.Narrator
  @play: (action, cb = null) ->
    track = "#{action.toLowerCase()}.mp3"
    Crafty.audio.play(track, 1, Settings.get("narratorVolume"))
    Crafty.audio.sounds[track].obj.addEventListener("ended", cb) if cb

class window.SFX
  @play: (action) ->
    track = "#{action.toLowerCase()}.wav"
    Crafty.audio.play(track, 1, Settings.get("sfxVolume"))