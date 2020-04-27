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
            string transactionQuery = "SELECT * FROM userTransactionData";
            SqlCommand transactionCommand = new SqlCommand(transactionQuery, conn);

            SqlDataReader reader = transactionCommand.ExecuteReader();

            var model = new List<Transactions>();

            while (reader.Read())
            {
                var transaction = new Transactions();
                transaction.account_number = Int32.Parse(reader[0].ToString());
                transaction.transactionID = Int32.Parse(reader[1].ToString());
                transaction.processing_date = reader[2].ToString();
                transaction.balance = Int32.Parse(reader[3].ToString());
                transaction.deposit_withdrawal = reader[4].ToString();
                transaction.amount = Int32.Parse(reader[5].ToString());
                transaction.description = reader[6].ToString();
                
                model.Add(transaction);

            }

            conn.Close();

            model.Sort((a, b) => b.processing_date.CompareTo(a.processing_date));
            return View(model);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
