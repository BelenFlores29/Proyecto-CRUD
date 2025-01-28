using System;
using System.Web;
using System.Web.Services;
using SendGrid;
using SendGrid.Helpers.Mail;

namespace WebSiteExampleLI
{
    /// <summary>
    /// Descripción breve de EmailWS
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class EmailWS : System.Web.Services.WebService
    {
        private static readonly string apiKey = "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";
        private static readonly string adminEmail = "prefecot@gmail.com";

        /// <summary>
        /// Envía un correo al administrador cuando un alumno realiza una solicitud.
        /// </summary>
        /// <param name="estId">ID del estudiante (matrícula).</param>
        /// <param name="templateId">ID de la plantilla de correo para solicitudes.</param>
        [WebMethod]
        public void SendRequestEmail(int estId, string templateId)
        {
            if (estId == 0)
            {
                throw new ArgumentException("El ID del estudiante no es válido.");
            }

            var matricula = estId.ToString();

            var client = new SendGridClient(apiKey);
            var from = new EmailAddress("belenflores2909@gmail.com", "Escuela");
            var to = new EmailAddress(adminEmail, "Administrador");
            var subject = "Solicitud de inscripción";

            var dynamicTemplateData = new
            {
                Username = matricula,
            };

            var msg = new SendGridMessage();
            msg.SetFrom(from);
            msg.AddTo(to);
            msg.SetSubject(subject);
            msg.SetTemplateId(templateId);
            msg.SetTemplateData(dynamicTemplateData);

            try
            {
                var response = client.SendEmailAsync(msg).Result;  // Bloquea la ejecución hasta obtener la respuesta

                if (response.StatusCode != System.Net.HttpStatusCode.Accepted)
                {
                    var responseBody = response.Body.ReadAsStringAsync().Result;  // Espera la respuesta del cuerpo
                    throw new Exception($"Error al enviar el correo: {response.StatusCode}. Detalles: {responseBody}");
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error inesperado al enviar el correo: {ex.Message}");
            }
        }

        /// <summary>
        /// Envía un correo de notificación al alumno (manual desde el administrador).
        /// </summary>
        /// <param name="templateId">ID de la plantilla de correo para notificaciones.</param>
        /// <param name="studentEmail">Correo del alumno.</param>
        [WebMethod]
        public void SendNotificationEmail(string templateId, string studentEmail)
        {
            if (string.IsNullOrEmpty(studentEmail))
            {
                throw new ArgumentException("El correo del alumno no puede estar vacío.");
            }

            var client = new SendGridClient(apiKey);
            var from = new EmailAddress("prefecot@gmail.com", "Escuela");
            var to = new EmailAddress(studentEmail, "Alumno");
            var subject = "Notificación de inscripción";

            var msg = new SendGridMessage();
            msg.SetFrom(from);
            msg.AddTo(to);
            msg.SetSubject(subject);
            msg.SetTemplateId(templateId);

            try
            {
                var response = client.SendEmailAsync(msg).Result;  // Bloquea la ejecución hasta obtener la respuesta

                if (response.StatusCode != System.Net.HttpStatusCode.Accepted)
                {
                    var responseBody = response.Body.ReadAsStringAsync().Result;  // Espera la respuesta del cuerpo
                    throw new Exception($"Error al enviar el correo: {response.StatusCode}. Detalles: {responseBody}");
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Error inesperado al enviar el correo: {ex.Message}");
            }
        }
    }
}

