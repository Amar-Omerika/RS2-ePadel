using EasyNetQ;
using ePadel.Model;
using ePadel.Subscribe;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;


static IHostBuilder CreateHostBuilder() =>
    Host.CreateDefaultBuilder().ConfigureServices((hostContext, services) =>
    {
        services.AddHostedService<RabbitMQHostedService>();
    });

CreateHostBuilder().Build().Run();
public class RabbitMQHostedService : IHostedService
{
    private IBus _bus;
    private EmailService _service;
    private EmailSendGridService _sendGridService;


    public RabbitMQHostedService()
    {
        _service = new EmailService();
        _sendGridService = new EmailSendGridService();
        _bus = RabbitHutch.CreateBus("host=localhost");
        while (true)
        {
            try
            {
                _bus.PubSub.Subscribe<RegistracijaNotifikacija>("Nova_Registracija", HandleTextMessage);
                Console.WriteLine("Subscribe successful,listening for messages.");
                break;
            }
            catch
            {
                Console.WriteLine("Subscribe failed,retrying...");
                Thread.Sleep(5000);
            }
        }
    }
    public Task StartAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        _bus.Dispose();
        //console log "Dispoing"
        Console.WriteLine("Stop async");
        return Task.CompletedTask;
    }
    private Task HandleTextMessage(RegistracijaNotifikacija entity)
    {
        Console.WriteLine($"Registracija zaprimljena: {entity?.RegistracijaNotifikacijaId}, PorukaDobrodoslice: {entity?.PorukaDobrodoslice}, Email: {entity?.Email}");
        _sendGridService.Send("Registracija zaprimljena", $"Dobrodosli {entity.PorukaDobrodoslice}.", entity.Email, entity.Email);
        _service.SendEmailAsync("amaaromerika00@gmail.com", "Nova registracija na ePadelu!", $"Poruka dobrodoslice {entity.PorukaDobrodoslice}.");
        return Task.CompletedTask;
    }
}