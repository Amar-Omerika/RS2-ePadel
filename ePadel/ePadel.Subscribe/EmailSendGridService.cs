using SendGrid;
using SendGrid.Helpers.Mail;

namespace ePadel.Subscribe
{
    public class EmailSendGridService
    {
        private readonly string _apiKey;
        private readonly SendGridClient _client;
        private readonly EmailAddress _fromAddress;

        public EmailSendGridService()
        {
            var encryptedApiKey = Environment.GetEnvironmentVariable("EncryptedApiKey") ?? "4afXjVLYhlXVf4hJHOSuhTcyV509+IxjKBuWXXvC6NW/GU+1AcYAc3Cow9HZ781RuamhUEU80QO2slWQ9aPA1MjcMU/tJM/p+rg5+Qkw+Dc=";
            var encryptionKey = Environment.GetEnvironmentVariable("EncryptionKey") ?? "Mc4idWDv7a9pnL8t";
            _apiKey = EncryptionHelper.DecryptString(encryptedApiKey, encryptionKey);
            _client = new SendGridClient(_apiKey);
            _fromAddress = new EmailAddress("amar.omerika@edu.fit.ba", "epadel");
        }
        public async Task Send(string subject, string body, string toAddress, string name)
        {
            var to = new EmailAddress(toAddress, name);
            var plainTextContent = "and easy to do anywhere, even with C#";
            var msg = MailHelper.CreateSingleEmail(_fromAddress, to, subject, plainTextContent, body);
            await _client.SendEmailAsync(msg).ConfigureAwait(false);
        }
    }
}