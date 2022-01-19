## Allocation
- **To allocate memory to an object, we must use new()**. So the object is always allocated memory on heap.
  - ```
    public static void main(String[] args)
    {
        Test t; /isn't allocate memory yet'
         
        // Error here because t
        // is not initialized
        t.show();
    }
    ```
    
## De-allocation