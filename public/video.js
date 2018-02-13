if (!navigator.mediaDevices) {
  alert("getUserMedia support required to use this page");
}
let recorder;
let url;
let bigVideoBlob;

let testArr = [0, 1, 2, 3, 4, 5, 6];

app.ports.recordStart.subscribe(function() {
  if (recorder.state !== "recording") {
    recorder.start();
  }
  console.log(recorder.state);
  console.log("recorder started");
});

app.ports.prepareVideo.subscribe(function() {
  const videoChunks = [];
  let onDataAvailable = e => {
    videoChunks.push(e.data);
  };

  navigator.mediaDevices
    .getUserMedia({
      audio: true,
      video: {
        width: { ideal: 640 },
        height: { ideal: 360 }
      }
    })
    .then(mediaStream => {
      recorder = new MediaRecorder(mediaStream);
      recorder.ondataavailable = onDataAvailable;
      url = window.URL.createObjectURL(mediaStream);
      app.ports.liveVideoUrl.send(url);

      app.ports.recordStop.subscribe(function() {
        if (recorder.state !== "inactive") {
          console.log("recorder", recorder);
          recorder.stop();
        }
        mediaStream.getTracks().map(function(track) {
          track.stop();
          mediaStream.removeTrack(track);
        });
        console.log(recorder.state);
        console.log("recorder stopped");
      });

      recorder.onstop = e => {
        bigVideoBlob = new Blob(videoChunks, { type: "video/mp4" });
        console.log("e: ", e);
        console.log("videoChunks: ", videoChunks);
        var videoURL = window.URL.createObjectURL(bigVideoBlob);
        app.ports.recordedVideoUrl.send(videoURL);
      };
    })
    .catch(function(err) {
      console.log("error", err);
      app.ports.recordError.send("Can't start video!");
    });

  app.ports.uploadVideo.subscribe(function(questionNumber) {
    console.log("length", testArr.length);
    let fd = new FormData();
    fd.append("recordingData", bigVideoBlob);
    fd.append("question", questionNumber);
    if (questionNumber == "q1" && testArr.length == 7) {
      fetch("/api/v1/video-upload", {
        method: "POST",
        body: fd
      })
        .then(response => response.json())
        .then(response => {
          console.log("Success", response);
          if (response.q1) {
            app.ports.getQ1Url.send(response.q1);
          } else if (response.q2) {
            app.ports.getQ2Url.send(response.q2);
          } else {
            app.ports.getQ3Url.send(response.q3);
          }
        })
        .catch(error => console.log("Error", error));
      testArr.pop();
    } else if (questionNumber == "q2" && testArr.length == 6) {
      fetch("/api/v1/video-upload", {
        method: "POST",
        body: fd
      })
        .then(response => response.json())
        .then(response => {
          console.log("Success", response);
          if (response.q1) {
            app.ports.getQ1Url.send(response.q1);
          } else if (response.q2) {
            app.ports.getQ2Url.send(response.q2);
          } else {
            app.ports.getQ3Url.send(response.q3);
          }
        })
        .catch(error => console.log("Error", error));
      testArr.pop();
    } else if (questionNumber == "q3" && testArr.length == 5) {
      fetch("/api/v1/video-upload", {
        method: "POST",
        body: fd
      })
        .then(response => response.json())
        .then(response => {
          console.log("Success", response);
          if (response.q1) {
            app.ports.getQ1Url.send(response.q1);
          } else if (response.q2) {
            app.ports.getQ2Url.send(response.q2);
          } else {
            app.ports.getQ3Url.send(response.q3);
          }
        })
        .catch(error => console.log("Error", error));
      testArr.pop();
    }
  });
});
