## Given a bitstream [A B C D .. etc]
## Returns
## A  B      Return
## 0  0     -3
## 0  1     -1
## 1  1     +1
## 1  0     +3
## for each pair of two input bits.
function ret = pam_gray (bitstream)
    if (mod(length(bitstream), 2) ~= 0)
        bitstream(end+1) = 0;
    end
    data = 2*bitstream(1:2:end) + bitstream(2:2:end);
    data(data==0) = -3;
    data(data==1) = -1;
    data(data==3) =  1;
    data(data==2) =  3;
    ret = data;
endfunction
