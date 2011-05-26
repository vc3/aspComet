﻿namespace AspComet.MessageHandlers
{
    public class ExceptionHandler : IMessageHandler
    {
        public string ErrorMessage { get; private set; }

        public ExceptionHandler(string errorMessage)
        {
            this.ErrorMessage = errorMessage;
        }

        public MessageHandlerResult HandleMessage(Message request)
        {
            return new MessageHandlerResult
            {
                Message = new Message
                {
                    id = request.id,
                    channel = request.channel,
                    clientId = request.clientId,
                    error = this.ErrorMessage
                },
                CanTreatAsLongPoll = false
            };
        }
    }
}