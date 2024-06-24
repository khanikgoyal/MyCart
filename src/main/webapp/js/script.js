function add_to_cart(pid, pname, price){
	let cart = localStorage.getItem("cart");
	if(cart==null){
		let products=[];
		let product={productId:pid, productName:pname, productQuantity:1, productPrice:price};
		products.push(product);
		localStorage.setItem("cart", JSON.stringify(products));
	}else{
		let pcart=JSON.parse(cart);
		
		let oldProduct=pcart.find((item)=>item.productId==pid);
		if(oldProduct){
			oldProduct.productQuantity+=1;
			pcart.map((item)=>{
				if(item.productId==oldProduct.productId){
					item.productQuantity=oldProduct.productQuantity;
				}
			})
			localStorage.setItem("cart",JSON.stringify(pcart));	  
			console.log("product QTY increased")
		}else{
			let product={productId:pid, productName:pname, productQuantity:1, productPrice:price};		
			pcart.push(product);
			localStorage.setItem("cart",JSON.stringify(pcart));	
			console.log("New product added");
		} 
	}
	updateCart();
}

//update cart

function updateCart(){
	let cartString=localStorage.getItem("cart");
	let cart=JSON.parse(cartString);
	if(cart==null || cart.length==0){
		//cart is empty
		console.log("Cart is empty !!");
		$(".cart-items").html("( 0 )");
		$(".cart-body").html("<h3>Cart does not have any items</h3>");
		$(".checkout-btn").addClass('disabled');
		
	}else{
		//there is something in cart
		console.log(cart); 
		$(".cart-items").html(`( ${cart.length} )`);
		
		let table=`
			<table class="table">
				<thead class="thread-light">
					<tr>
						<th>Item Name</th>
						<th>Price</th>
						<th>Quatity</th>
						<th>Total Price</th>
						<th>Action</th>
					</tr>
				</thead>
		`;
		let totalPrice=0;
		cart.map((item)=>{
			table+=`<tr>
			<td>${item.productName}</td>
			<td>${item.productPrice}</td>
			<td>${item.productQuantity}</td>
			<td>${item.productQuantity*item.productPrice}</td>
			<td><button class='btn btn-danger btn-sm'>Remove</button></td>
			</tr>
			`
			totalPrice+=item.productPrice*item.productQuantity;
			
		})
		
		table=table+`
		<tr><td colspan='5' class='text-right font-weight-bold'>Total Price : ${totalPrice}</td></tr>
		</table>`
		
		$(".cart-body").html(table );
	}	
}

$(document).ready(function() {
    updateCart();
});
