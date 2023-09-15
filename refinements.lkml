include: "/views/**/*.view.lkml"
# include: "//cortex-sap-operational/**/*.explore.lkml"

# #
# Use LookML refinements to refine views and explores defined in the remote project.
# Learn more at: https://docs.looker.com/data-modeling/learning-lookml/refinements
#
#
# For example we could add a new dimension to a view:
#     view: +flights {
#       dimension: air_carrier {
#         type: string
#         sql: ${TABLE}.air_carrier ;;
#       }
#     }
#
# Or apply a label to an explore:
#     explore: +aircraft {
#       label: "Aircraft Simplified"
#     }
#
view: +sales_orders {
  parameter: Currency_Required{
    type: string
    allowed_value: {
      label: "USD"
      value: "USD"
    }
    allowed_value: {
      label: "EUR"
      value: "EUR"
    }
    allowed_value: {
      label: "CAD"
      value: "CAD"
    }
    allowed_value: {
      label: "JPY"
      value: "JPY"
    }
    allowed_value: {
      label: "BRL"
      value: "BRL"
    }
    hidden: no
    default_value: "BRL"
  }
}

view: +data_intelligence_ar {


  parameter: Currency_Required{
    type: string
    allowed_value: {
      label: "USD"
      value: "USD"
    }
    allowed_value: {
      label: "EUR"
      value: "EUR"
    }
    allowed_value: {
      label: "CAD"
      value: "CAD"
    }
    allowed_value: {
      label: "JPY"
      value: "JPY"
    }
    allowed_value: {
      label: "BRL"
      value: "BRL"
    }
    default_value: "BRL"
  }
}


view: +data_intelligence_ar {
  measure: Total_DSO {
    type: number
    sql: floor(if(${Sales_Total_DSO}=0,0,(${AccountsRecievables_Total_DSO}/NULLIF(${Sales_Total_DSO},0))*{% parameter Day_Sales_Outstanding %}*30)) ;;
    #sql: floor(if(${Sales_Total_DSO}=0,0,(${AccountsRecievables_Total_DSO}/${Sales_Total_DSO})*date_diff(DATE_SUB(${Current_Fiscal_Date_date},INTERVAL {% parameter Day_Sales_Outstanding %} MONTH ),${Current},days))) ;;

    link: {
      label: "Day Sales Outstanding"
      url: "/dashboards/cortex_sap_operational::day_sales_outstanding?"
    }
  }

  measure: DSO{
    type: number
    sql: floor(if(${Sales_Total_DSO}=0,0,(${AccountsRecievables_Total_DSO}/NULLIF(${Sales_Total_DSO},0))*{% parameter Day_Sales_Outstanding %}*30)) ;;
  }

}
