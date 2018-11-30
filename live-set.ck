// live-set.ck
// chuck script for ayayay live set
// by montoyamoraga
// november 2018


// integer for either using live input or samples
// 0 for sample, 1 for live input
0 => int ayLiveInput;

// declare sound buffer
SndBuf ayBuffer;
// retrieve filename for guitar sample
me.sourceDir() + "samples/guitar.wav" => string guitarSample;
<<< me.sourceDir() + "samples/guitar.wav" >>>;
// load file into sound buffer
guitarSample => ayBuffer.read;
// set parameters for sound buffer
0 => ayBuffer.pos;
1.0 => ayBuffer.gain;
1.0 => ayBuffer.rate;

// effects reference
// http://chuck.cs.princeton.edu/doc/program/ugen_full.html

// declare gain stage
Gain ayGain;
1.0 => ayGain.gain;

// declare delay effect
DelayL ayDelay;
//.delay - ( dur , READ/WRITE ) - length of delay
//.max - ( dur , READ/WRITE ) - max delay ( buffer size )
5 :: second =>ayDelay.max;
1 :: second =>ayDelay.delay;

// declare echo effect
Echo ayEcho;
// .delay - ( dur , READ/WRITE ) - length of echo
// .max - ( dur , READ/WRITE ) - max delay
// .mix - ( float , READ/WRITE ) - mix level ( wet/dry )
5 :: second => ayEcho.max;
1 :: second => ayEcho.delay;
0.7 => ayEcho.mix;


// make audio connections
// if ayLiveInput is 0 use sample
if (ayLiveInput == 0) {
    ayBuffer => ayGain;
// if ayLiveInput is 1 use live input
} else if (ayLiveInput == 1) {
    adc =>  ayGain;
}

// connect gain stage to delay and to echo
ayGain => ayDelay => ayEcho => dac;


// let time pass
while (true) {
    1 :: second => now;
}


