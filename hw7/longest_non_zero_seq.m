function[longestSeqLen] = longest_non_zero_seq(row_vector)
length = size(row_vector,2);
seqLen = 0;
longestSeqLen = 0;
for n=1:length
    if row_vector(1,n) == 1
        seqLen = seqLen +1;
    else
        if seqLen > longestSeqLen
            longestSeqLen = seqLen;
        end
        seqLen=0;
    end
end
if seqLen~=0
    for n=1:length
        if row_vector(1,n) == 0
            break;
        end
        seqLen=seqLen+1;
    end
    if seqLen > longestSeqLen
        longestSeqLen = seqLen;
    end
end
end
