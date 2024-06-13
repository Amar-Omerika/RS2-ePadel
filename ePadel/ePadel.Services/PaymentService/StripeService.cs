using Microsoft.Extensions.Configuration;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ePadel.Services.PaymentService
{
    public class StripeService
    {
        private readonly string apiKey;
        public StripeService(IConfiguration configuration)
        {
            apiKey = configuration["StripeSettings:ApiKey"] ?? Environment.GetEnvironmentVariable("STRIPE_API_KEY");
        }
        public string PlatiTermin(int iznos, string opis)
        {
            StripeConfiguration.ApiKey = apiKey;
            var options = new PaymentIntentCreateOptions
            {
                Amount = iznos * 100,
                Currency = "BAM",
                Description = opis,
                //PaymentMethod = "pm_card_visa",
            };
            var service = new PaymentIntentService();
            var paymentIntent = service.Create(options);

            return paymentIntent.ClientSecret;
        }
    }
}
