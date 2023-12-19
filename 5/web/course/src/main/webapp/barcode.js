function order_by_occurrence(arr) {
    var counts = {};
    arr.forEach(function(value){
        if(!counts[value]) {
            counts[value] = 0;
        }
        counts[value]++;
    });

    return Object.keys(counts).sort(function(curKey,nextKey) {
        return counts[curKey] < counts[nextKey];
    });
}

function startScanner() {
    Quagga.init({
        inputStream: {
            name: "Live",
            type: "LiveStream",
            target: document.querySelector('#scanner-container'),
            constraints: {
                aspectRatio: 4/3,
                facingMode: "environment"
            }
        },
        numOfWorkers: 8,
        frequency: 'full',
        locator: {
            patchSize: 'medium',
            halfSample: true,
        },
        decoder: {
            readers: [
                //"code_128_reader",
                "ean_reader",
                "ean_8_reader"
                //"code_39_reader",
                //"code_39_vin_reader",
                //"codabar_reader",
                //"upc_reader",
                //"upc_e_reader",
                //"i2of5_reader"
            ],
            debug: {
                showCanvas: true,
                showPatches: true,
                showFoundPatches: true,
                showSkeleton: true,
                showLabels: true,
                showPatchLabels: true,
                showRemainingPatchLabels: true,
                boxFromPatches: {
                    showTransformed: true,
                    showTransformedBox: true,
                    showBB: true
                }
            }
        },

    }, function (err) {
        if (err) { console.log(err); return }
        Quagga.initialized = true;
        Quagga.start();
    });

    Quagga.onProcessed(function (result) {
        var drawingCtx = Quagga.canvas.ctx.overlay,
            drawingCanvas = Quagga.canvas.dom.overlay;

        if (result) {
            if (result.boxes) {
                drawingCtx.clearRect(0, 0, parseInt(drawingCanvas.getAttribute("width")), parseInt(drawingCanvas.getAttribute("height")));
                result.boxes.filter(function (box) {
                    return box !== result.box;
                }).forEach(function (box) {
                    Quagga.ImageDebug.drawPath(box, {x: 0, y: 1}, drawingCtx, {color: "green", lineWidth: 2});
                });
            }

            if (result.box) {
                Quagga.ImageDebug.drawPath(result.box, {x: 0, y: 1}, drawingCtx, {color: "#00F", lineWidth: 2});
            }

            if (result.codeResult && result.codeResult.code) {
                Quagga.ImageDebug.drawPath(result.line, {x: 'x', y: 'y'}, drawingCtx, {color: 'red', lineWidth: 3});
            }
        }
    });

    var last_result = [];
    if (Quagga.initialized == undefined) {
        Quagga.onDetected(function(result) {
            var last_code = result.codeResult.code;
            last_result.push(last_code);
            if (last_result.length > 30) {
                code = order_by_occurrence(last_result)[0];
                last_result = [];
                // Quagga.stop();
                document.getElementById("barcode").value = code;
                document.getElementById("barcode-submit").click();
            }
        });
    }
}

