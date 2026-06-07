-- Question 1
select top 5 a.CustomerID, a.Name, sum(b.TotalAmount) as TotalAmount
from Customer a
left join SalesOrder b
on a.CustomerID = b.CustomerID
group by a.CustomerID, a.Name
order by  sum(b.TotalAmount) desc

-- Question 2
select a.SupplierID, a.Name, count(distinct c.ProductID) as ProductCount
from Supplier a
left join purchaseorder b
on a.supplierid = b.supplierid
left join purchaseorderdetail c
on b.orderid = c.orderid
group by a.SupplierID, a.Name
having count(distinct c.ProductID) > 10 

-- Question 5
select a.orderid, b.name as customername, d.name as productname, e.name as categoryname, g.name as supplier, c.quantity
from salesorder a
left join customer b 
on a.customerid = b.customerid
left join salesorderdetail c 
on a.orderid = c.orderid
left join product d
on c.productid = d.productid
left join category e 
on d.categoryid = e.categoryid
left join purchaseorder f
on a.orderid = f.orderid
left join supplier g
on f.supplierid = g.supplierid

-- Question 6
select a.shipmentid, d.name as warehousename, e.name as managername, f.name as productname, a.quantity
from shipmentdetail a
left join shipment b
on a.shipmentid = b.shipmentid
left join warehouse c
on b.warehouseid = c.warehouseid
left join location d 
on c.locationid = d.locationid
left join department e
on d.locationid = e.locationid
left join product f
on a.productid = f.productid