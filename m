Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5ACA05F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1PQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:16:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38515 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1PQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:16:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so2958812lji.5;
        Wed, 28 Aug 2019 08:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlqlSKXNJJ07XfI4S7mW9mSwnhaxvAZoQgELf1mwsKs=;
        b=V26WpzqaxKjhjxCfcouj/hdZsEpoT8eOaHwXFYV8cid5Tch+/HHP4xBfKQVzDlbAca
         /v5jmhLyZIhORg5SFh5w/JxpK3I6Ghre9Qv+kZuUuEXxx2q3KoNmclcpNONcnTPyHC9L
         FH2jQyLrQGhMclpoogsvLgXSA14Mr9XPCXZq+ZMtqkoIMR1fZ692rgl5C3fCzs3kexDb
         l+Qr4qczQWgICnMo7+OIOd+NdCz0TFzP/QmI+wWLu3F5G8xi/1EfCJm/3LFAsFYA07Ag
         IUhvAU/alVEJOSJGlOOcBnkKOtdL/OpeZWUlO2cZ4QI54pKZovDL8l8JjLY0UgcJ5u5J
         jFYg==
X-Gm-Message-State: APjAAAWSNXY5GtLtZ77ps+Ba9PKYs5GA9Tw6PLx6hDaKXKp6QRL2irY8
        l5wDwSQ3RjvMtxi3C9i7ZWM=
X-Google-Smtp-Source: APXvYqyvuc6YlbmuScPpT6Kjinof/Kkjxr4hE9SV4vuK4roOdHEQhwBuZt9x6HZWM1VZ2SqQj88UhQ==
X-Received: by 2002:a2e:5c5:: with SMTP id 188mr2426853ljf.166.1567005370954;
        Wed, 28 Aug 2019 08:16:10 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id b27sm661139ljb.11.2019.08.28.08.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:16:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i2zg6-0008Lh-PZ; Wed, 28 Aug 2019 17:16:07 +0200
Date:   Wed, 28 Aug 2019 17:16:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 4/6] USB: serial: f81232: Add tx_empty function
Message-ID: <20190828151606.GK13017@localhost>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-5-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559789656-15847-5-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:54:14AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Add tx_empty() function for F81232 & F81534A series.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index e9470fb0d691..7d1ec8f9d168 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -850,6 +850,24 @@ static void f81232_dtr_rts(struct usb_serial_port *port, int on)
>  		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
>  }
>  
> +static bool f81232_tx_empty(struct usb_serial_port *port)
> +{
> +	int status;
> +	u8 tmp;
> +	u8 both_empty = UART_LSR_TEMT | UART_LSR_THRE;

Doesn't TEMT being set imply that THRE is set? So you only need to check
the former?

> +
> +	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
> +	if (status) {
> +		dev_err(&port->dev, "get LSR status failed: %d\n", status);
> +		return false;
> +	}
> +
> +	if ((tmp & both_empty) != both_empty)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int f81232_carrier_raised(struct usb_serial_port *port)
>  {
>  	u8 msr;
> @@ -1279,6 +1297,7 @@ static struct usb_serial_driver f81232_device = {
>  	.tiocmget =		f81232_tiocmget,
>  	.tiocmset =		f81232_tiocmset,
>  	.tiocmiwait =		usb_serial_generic_tiocmiwait,
> +	.tx_empty =		f81232_tx_empty,
>  	.process_read_urb =	f81232_read_urb_proxy,
>  	.read_int_callback =	f81232_read_int_callback,
>  	.port_probe =		f81232_port_probe,

Johan
