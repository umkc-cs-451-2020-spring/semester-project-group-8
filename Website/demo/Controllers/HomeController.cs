using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using demo.Models;

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

        public IActionResult Transactions()
        {
            var model = new List<Transactions>();

            var transaction1 = new Transactions();
            transaction1.transactionID = 1234;
            transaction1.account_number = 1;
            transaction1.amount = 2000;
            transaction1.processing_date = "12/12/2020";
            transaction1.deposit_withdrawal = "Deposit";
            transaction1.description = "Initial deposit";
            transaction1.balance = 2000;

            var transaction2 = new Transactions();
            transaction2.transactionID = 1235;
            transaction2.account_number = 1;
            transaction2.amount = -500;
            transaction2.processing_date = "12/14/2020";
            transaction2.deposit_withdrawal = "Withdrawal";
            transaction2.description = "Bill Payment";
            transaction2.balance = 1500;

            model.Add(transaction1);
            model.Add(transaction2);

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
