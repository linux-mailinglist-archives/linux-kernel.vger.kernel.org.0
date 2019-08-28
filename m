Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E869A0571
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 16:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfH1O6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 10:58:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42980 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1O6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:58:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id u13so2425753lfm.9;
        Wed, 28 Aug 2019 07:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YmNYpAsozJM2W+xkUeMpjHRI0FhBBXfioemVsH1jkE=;
        b=CkUnyDTf0PR8jDJmjzytcNQo/lK8kgBmdKVH48EVICyn73UNcYsShdWqmfdiFIZHTA
         wLkRqsqLVGrrDwacCP2LjIPjc4ahe2qif2MMJRdOUV6EMv1PxflOWhrFr91d2rMyVBpE
         L9NMaWsZ5zMZIkR3DkuzbxDP5hv543St7M5MvbdgNTk7BRROd3KN4Er6llHXja96DLpZ
         mBU0RfQNohVkcemDZqk+Ua/k7p1CWiqLk0JI9SGhEg3GPawNTE0tgqczs3M4p/dMq05Y
         6bg+qyx2X9I9QOGTTSLwvWTRl+sTeI/b29biNt9/M3WncLOZVosHWHydZsm0RbyNserE
         GFlw==
X-Gm-Message-State: APjAAAUf4kquvpesjgOuToyl/GIT233mPZV7uBZP2TGFFtnF2SUZ09HN
        PyU5efcEm6tccJb+uHHsF558sKj0ca4=
X-Google-Smtp-Source: APXvYqzpJU9WDE6PBAh2E+k7LHNv2Od8m+RkZewIUdP7zo/2L3bY1LPCle2Z8Fcl6zZEPnKWV0162w==
X-Received: by 2002:ac2:4835:: with SMTP id 21mr2854924lft.121.1567004315207;
        Wed, 28 Aug 2019 07:58:35 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id u14sm662869ljd.14.2019.08.28.07.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:58:34 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1i2zP5-0008E8-DI; Wed, 28 Aug 2019 16:58:31 +0200
Date:   Wed, 28 Aug 2019 16:58:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 2/6] USB: serial: f81232: Force F81534A with RS232 mode
Message-ID: <20190828145831.GI13017@localhost>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1559789656-15847-3-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559789656-15847-3-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:54:12AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Force F81534A series UARTs with RS232 mode in port_probe().

Please expand on why you need this here.

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 84efcc66aa56..75dfc0b9ef30 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -83,12 +83,22 @@ MODULE_DEVICE_TABLE(usb, id_table);
>  #define F81232_F81232_TYPE		1
>  #define F81232_F81534A_TYPE		2
>  
> +/* Serial port self GPIO control, 2bytes [control&output data][input data] */
> +#define F81534A_GPIO_REG		0x10e
> +#define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
> +#define F81534A_GPIO_MODE1_DIR		BIT(5)
> +#define F81534A_GPIO_MODE0_DIR		BIT(4)
> +#define F81534A_GPIO_MODE2_OUTPUT	BIT(2)
> +#define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
> +#define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
> +
>  struct f81232_private {
>  	struct mutex lock;
>  	u8 modem_control;
>  	u8 modem_status;
>  	u8 shadow_lcr;
>  	u8 device_type;
> +	u8 gpio_mode;

Why store the mode? Are you going to use it later?

>  	speed_t baud_base;
>  	struct work_struct lsr_work;
>  	struct work_struct interrupt_work;
> @@ -871,6 +881,11 @@ static int f81232_port_probe(struct usb_serial_port *port)
>  	switch (priv->device_type) {
>  	case F81232_F81534A_TYPE:
>  		priv->process_read_urb = f81534a_process_read_urb;
> +		priv->gpio_mode = F81534A_GPIO_MODE2_DIR;
> +
> +		/* tri-state with pull-high, default RS232 Mode */
> +		status = f81232_set_register(port, F81534A_GPIO_REG,
> +					priv->gpio_mode);
>  		break;
>  
>  	case F81232_F81232_TYPE:

Johan
