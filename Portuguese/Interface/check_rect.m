function [new_W,new_L] = check_rect(L,W)

L = L*100;
W = W*100;
op1 = mod(L,W);
op2 = mod(W,L);
if (L<W)
    op = W;
    W = L;
    L = op;
end

if (op1 ~= 0 && op2 ~= 0)
    op = 1;
    if (L>W)
        while(op~=0)
            W = W + 1;
            op = rem(L,W);
        end
    else
        while(op~=0)
            L = L + 0.1;
            op = rem(W,L);
        end
    end
end
new_L = L/100;
new_W = W/100;
end