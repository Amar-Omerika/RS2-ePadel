using ePadel.Model;


namespace ePadel.Services
{
    public interface INotificationProducer
    {
        public void SendingObject(RegistracijaNotifikacija obj);
    }
}