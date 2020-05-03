using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using demo.Models;
using System.Data.SqlClient;

namespace demo.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }
        public IActionResult dashboard()
        {
            return View();
        }

        public IActionResult Home_page()
        {
            return View();
        }

        public IActionResult Alerts()
        {
            return View();
        }

        public IActionResult Transactions()
        {

            SqlConnection conn = new SqlConnection("Data Source=localhost;Initial Catalog=commerce;Integrated Security=True");

            conn.Open();
            string transactionQuery = "SELECT * FROM userTransactionData ORDER BY processing_date DESC";
            SqlCommand transactionCommand = new SqlCommand(transactionQuery, conn);

            SqlDataReader reader = transactionCommand.ExecuteReader();

            var model = new List<Transactions>();

            while (reader.Read())
            {
                var transaction = new Transactions();
                transaction.account_number = Int32.Parse(reader["account_number"].ToString());
                transaction.transactionID = Int32.Parse(reader["transactionID"].ToString());
                transaction.processing_date = reader["processing_date"].ToString();
                transaction.balance = double.Parse(reader["balance"].ToString());
                transaction.deposit_withdrawal = reader["deposit_withdrawal"].ToString();
                transaction.amount = double.Parse(reader["amount"].ToString());
                transaction.description = reader["description"].ToString();
                
                model.Add(transaction);

            }

            conn.Close();

            return View(model);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
