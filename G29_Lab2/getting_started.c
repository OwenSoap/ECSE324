int main (){
	int a[5] = {1,30,3,4,5};
		int max_val;
		// Let the result to be the first value and then compare each element in the array with the result
		// If greater then replace the result with greater one
		max_val = a[0];
		int i;
		for(i = 0; i<5; i++){
			if(a[i] > max_val){
				max_val = a[i];
			}
		}
		return max_val;
}
