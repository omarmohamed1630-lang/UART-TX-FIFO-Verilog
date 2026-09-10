module max_consecutive;
  
  int arr[];
  int count;
  int max;
  
    initial begin

        arr = new[10];
        arr = '{1, 1, 0, 1, 1, 1, 0, 0, 0, 1};
        max = 0;
        count = 0;

        foreach (arr[i]) begin
            if (arr[i] == 1) begin
                count = count + 1;
                if (count > max) begin
                    max = count;
                end
            end 

            else begin
                count = 0;
            end
        end
    
    $display("Max consecutive : %0d", max);

  end





endmodule



module second_max;

int arr[] = '{45 , 34 , 67 , 89 , 78};

int max1;
itn max2;

initial begin

    ma1 = 0;
    max2 = 0;

    foreach (arr[i]) begin
        if (arr[i] > max1) begin
            max2 = max1;
            max1 = arr[i];

        end

        else if (arr[i] > max2 && arr[i] != max1) begin
            max2 = arr[i];
        end
    end

    $display("Second max: %0d", max2);

    

end

endmodule


module frequency_count;

int arr[] = '{8,3,3,4,5,6,3,5,4,6,8,7,6,4,3,5,6};


initial begin





end





endmodule