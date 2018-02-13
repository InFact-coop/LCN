if (!navigator.mediaDevices) {
  alert("getUserMedia support required to use this page");
}

app.ports.prepareAudio.subscribe(function() {
  const audioChunks = [];
  let onDataAvailable = e => {
    audioChunks.push(e.data);
  };

  navigator.mediaDevices
    .getUserMedia({
      audio: true,
      video: false
    })
    .then(mediaStream => {
      const recorder = new MediaRecorder(mediaStream);
      recorder.ondataavailable = onDataAvailable;
      app.ports.recordStart.subscribe(function() {
        recorder.start();
        console.log(recorder.state);
        console.log("recorder started");
      });

      app.ports.recordStop.subscribe(function() {
        if (recorder) {
          recorder.stop();
          mediaStream.getTracks().map(function(track) {
            track.stop();
          });
          console.log(recorder.state);
          console.log("recorder stopped");
        }
      });

      recorder.onstop = e => {
        console.log("e: ", e);
        console.log("audioChunks: ", audioChunks);
        // TODO: check whether mp3 works
        const bigAudioBlob = new Blob(audioChunks, { type: "audio/mp3" });
        var audioUrl = window.URL.createObjectURL(bigAudioBlob);
        // TODO: make audio url port
        app.ports.audioUrl.send(audioUrl);

        let fd = new FormData();
        fd.append("recordingData", bigAudioBlob);
        fetch("/api/v1/audio-upload", {
          method: "POST",
          body: fd
        })
          .then(response => response.json())
          .then(response => console.log("Success", response))
          .catch(error => console.log("Error", error));
      };
    })
    .catch(function(err) {
      console.log("error", err);
      app.ports.recordError.send("Can't start audio!");
    });
});
