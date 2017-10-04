function [repeated_vector]=for_each(row_vector,times_to_repeat)
    repeated_rows=repmat(row_vector,times_to_repeat,1);
    repeated_vector=repeated_rows(:)';
end