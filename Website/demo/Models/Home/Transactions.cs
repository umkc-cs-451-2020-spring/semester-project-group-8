using System;

namespace demo.Models
{
    public class Transactions
    {


        public int account_number { get; set; }

        public int transactionID { get; set; }

        public string processing_date { get; set; }

        public int balance { get; set; }

        public string deposit_withdrawal { get; set; }

        public double amount { get; set; }

        public string description { get; set; }


        public static void Initialize(IServiceProvider serviceProvider)
        {

        }
    }
}
