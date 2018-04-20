(in-package :aws.cosmos)

;;;;; AWS> (aws :ec2 :describe-route-tables)
;;;;; Command⇒ aws ec2 describe-route-tables
(defvar *sample-ec2_describe-route-tables*
  '(:|RouteTables|
    ((:|Routes| ((:|Origin| ""
                  :|State| ""
                  :|DestinationCidrBlock| ""
                  :|GatewayId| "")
                 (:|Origin| ""
                  :|State| ""
                  :|DestinationCidrBlock| ""
                  :|GatewayId| ""))
      :|Tags| NIL
      :|PropagatingVgws| NIL
      :|VpcId| ""
      :|RouteTableId| ""
      :|Associations| ((:|RouteTableId| ""
                        :|Main| T
                        :|RouteTableAssociationId| ""))))))

(defvar *columns_ec2_route-table*
  '((:code :|Tags|            :slot Tags            :set-value set-value-simple)
    (:code :|PropagatingVgws| :slot PropagatingVgws :set-value set-value-simple)
    (:code :|VpcId|           :slot VpcId           :set-value set-value-simple)
    (:code :|RouteTableId|    :slot RouteTableId    :set-value set-value-simple)
    (:code :|Routes|          :slot nil             :set-value set-value-ignore)
    (:code :|Associations|    :slot nil             :set-value set-value-ignore)))
