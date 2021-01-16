import serial           # import the module
import time
ComPort = serial.Serial(port='COM7') # open COM24
ComPort.baudrate = 9600 # set Baud rate to 9600
ComPort.bytesize = 8    # Number of data bits = 8
ComPort.parity   = 'N'  # No parity
ComPort.stopbits = 1    # Number of Stop bits = 1
# Write character 'A' to serial port
#data=bytearray(b'A')
print ("if you want piano tone press 1 and if you want pure sine press 2"),
x=input()
if(x=='2'):
    print ("if you want chirp effect press 1 else press 2"),
    y=input()
    if(y=='1'):
        print ("Enter the note you want to play: c-small octave for A2 press'z',B2 press'x',C2 press'c',D2 press'v',E2 press'b',F2 press'n',G2 press'm':  C'1 line octave for A3 press'a',B3 press's',C3 press'd',D3 press'f',E3 press'g',F3 press'h',G3 press'j'    : C''2 line octave for A4 press'q',B4 press'w',C4 press'e',D4 press'r',E4 press't',F4 press'y',G4 press'u' "),
        z=input()
        if z=='z':
            m=64
        elif z=='x':
            m=65
        elif z=='c':
            m=66
        elif z=='v':
            m=67
        elif z=='b':
            m=68
        elif z=='n':
            m=69
        elif z=='m':
            m=70
        elif z=='a':
            m=71
        elif z=='s':
            m=72
        elif z=='d':
            m=73
        elif z=='f':
            m=74
        elif z=='g':
            m=75
        elif z=='h':
            m=76
        elif z=='j':
            m=77
        elif z=='q':
            m=78
        elif z=='w':
            m=79
        elif z=='e':
            m=80
        elif z=='r':
            m=81
        elif z=='t':
            m=82
        elif z=='y':
            m=83
        elif z=='u':
            m=84
        else:
            print ("Invalid note pressed"),
    elif(y=='2'):
        
        print ("Enter the note you want to play: c-small octave for A2 press'z',B2 press'x',C2 press'c',D2 press'v',E2 press'b',F2 press'n',G2 press'm':  C'1 line octave for A3 press'a',B3 press's',C3 press'd',D3 press'f',E3 press'g',F3 press'h',G3 press'j'    : C''2 line octave for A4 press'q',B4 press'w',C4 press'e',D4 press'r',E4 press't',F4 press'y',G4 press'u' "),
        p=input()
        if p=='z':
            m=0
        elif p=='x':
            m=1
        elif p=='c':
            m=2
        elif p=='v':
            m=3
        elif p=='b':
            m=4
        elif p=='n':
            m=5
        elif p=='m':
            m=6
        elif p=='a':
            m=7
        elif p=='s':
            m=8
        elif p=='d':
            m=9
        elif p=='f':
            m=10
        elif p=='g':
            m=11
        elif p=='h':
            m=12
        elif p=='j':
            m=13
        elif p=='q':
            m=14
        elif p=='w':
            m=15
        elif p=='e':
            m=16
        elif p=='r':
            m=17
        elif p=='t':
            m=18
        elif p=='y':
            m=19
        elif p=='u':
            m=20
        else:
            print ("Invalid note pressed"),
    else:
        print ("Invalid number entered"),
        
elif(x=='1'):
    
    
    print ("Enter the note you want to play: c-small octave for A2 press'z',B2 press'x',C2 press'c',D2 press'v',E2 press'b',F2 press'n',G2 press'm':  C'1 line octave for A3 press'a',B3 press's',C3 press'd',D3 press'f',E3 press'g',F3 press'h',G3 press'j'    : C''2 line octave for A4 press'q',B4 press'w',C4 press'e',D4 press'r',E4 press't',F4 press'y',G4 press'u' "),
    q=input()
    
    if q=='z':
            m=128
    elif q=='x':
            m=129
    elif q=='c':
            m=130
    elif q=='v':
            m=131
    elif q=='b':
            m=132
    elif q=='n':
            m=133
    elif q=='m':
            m=134
    elif q=='a':
            m=135
    elif q=='s':
            m=136
    elif q=='d':
            m=137
    elif q=='f':
            m=138
    elif q=='g':
            m=139
    elif q=='h':
            m=140
    elif q=='j':
            m=141
    elif q=='q':
            m=142
    elif q=='w':
            m=143
    elif q=='e':
            m=144
    elif q=='r':
            m=145
    elif q=='t':
            m=146
    elif q=='y':
            m=147
    elif q=='u':
            m=148
    else:
        print ("Invalid note pressed"),
else:
    print ("Invalid number entered"),
    
    
ot= ComPort.write(bytes(chr(int(m)),encoding='utf8'))
#ot= ComPort.write(bytes(chr(int(m))),encoding='utf8')    #for sending data to FPGA

print('Options updated on fpga, push start to generate. Observe the output on ila');

#it=(ComPort.read(1))                #for receiving data from FPGA

#print ("data received from FPGA:"),
#print (it.encode('hex'))
    

ComPort.close()         # Close the Com port
