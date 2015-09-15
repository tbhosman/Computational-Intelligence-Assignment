function y_L3_dec = bin2dec(y_L3_bin,len_in)

y_L3_dec = zeros(len_in,1);
for z=1:len_in
   if (y_L3_bin(z,3) == 1) %kijken of de binaire waarde oneven is
       if (y_L3_bin(z,2) == 1) %kijken of het tweede bit 1 is
            if (y_L3_bin(z,1) == 1)
                y_L3_dec(z) = 7; %111
            else
                y_L3_dec(z) = 3; %011
            end
       else %2e bit is 0
           if(y_L3_bin(z,1) == 1)
                y_L3_dec(z) = 5; %101
           else
               y_L3_dec(z) = 1;     %001
           end
       end
       
   else %LSB (bit 3) is 0
       if (y_L3_bin(z,2) == 1) %kijken of het tweede bit 1 is
            if (y_L3_bin(z,1) == 1)
                y_L3_dec(z) = 6; %110
            else
                y_L3_dec(z) = 2; %010
            end
       else %2e bit is 0
           if(y_L3_bin(z,1) == 1)
                y_L3_dec(z) = 4; %100
           else
               y_L3_dec(z) = 0;     %100
           end
       end
       
   end
end

end