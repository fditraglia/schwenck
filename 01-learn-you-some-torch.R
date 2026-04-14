library(torch)

#--------- 

# Create a tensor with a single element, 1
t1 <- torch_tensor(1)

t1$dtype # it's a float!
t1$device # on the CPU
t1$shape # dimensions

t2 <- t1$to(dtype = torch_int()) # convert to int
t2$dtype

t2 <- t1$to(device = 'mps') # move to GPU (for Mac use mps, else cuda)
t2$device # not sure about index=0 here...

rm(t1, t2)

#----------- 

# Specify the type; otherwise torch uses the highest precision type
torch_tensor(1:5, dtype = torch_float())

torch_tensor(1:5, dtype = torch_float(), device = 'mps') # on the GPU

# Those were vectors; now a matrix
torch_tensor(matrix(1:9, ncol = 3)) # fills in R's usual order

torch_tensor(matrix(1:9, ncol = 3, byrow = TRUE)) # by row 

#-----------

# Arrays are *different* in torch than in R

myarray <- array(1:24, dim = c(4, 3, 2))
myarray # R stacks / slices along the *last* dim 

torch_tensor(myarray) # torch stacks / slices along the *first* dim

rm(myarray)

#-----------

torch_randn(3, 3) # indep standard normals

torch_rand(3, 3) # indep uniforms

torch_zeros(2, 5) # zeros

torch_ones(2, 2) # ones

torch_eye(5) # identity matrix

torch_diag(1:3) # diagonal matrix

#-----------

# tensors are like arrays: they must contain data of the same type but
# unlike R arrays they can only store *numeric* data

state.abb
typeof(state.abb)
torch_tensor(state.abb) # error!

# convert to factor; internally stored as numeric
mystates <- as.factor(state.abb)
torch_tensor(mystates)

rm(mystates)

#-----------

# torch converts NA to nan 
torch_tensor(c(1, NA, 2, 3))

# certain torch functions can cope with nans
torch_nanquantile(c(1, NA, 2, 3), q = 0.5) # median

#-----------

# Let's add two tensors
t1 <- torch_tensor(1:2)
t2 <- torch_tensor(3:4)

# all three are equivalent: neither t1 nor t2 is modified
torch_add(t1, t2)
t1$add(t2)
t2$add(t1)

