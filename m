Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505C516F8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBZIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:05:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37603 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgBZIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:05:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so1968767ljm.4;
        Wed, 26 Feb 2020 00:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yKvVSicnRjGL1KBR6OA7vuLTKFiFx2PtDbuSAdj12/E=;
        b=ccAHqfwxytj3lNoBs6NBqWkrY7cQJN4MpDoDgQ1nI+sUi/ZJyGw1h1fGMsVgK3TTLr
         P+u6sPsrecETJFW4hbw3lzJk1FBYjpeqi+Wrz7q9uf01kCPQygsZpIpVwC3jIRntLypv
         d8UaCT4iBsgBxAgt7v6Ko7KPRzYjTuuNa1UbFMaYDZwUGbqxDWUbaLkUHpQP+zPRrVVq
         NHdTRv9slJ/O1IDK+tOv17WkX4v9M0MemQBplpuFXQYeqig/JtcbqRiAUhR+/tACERDq
         oYWiOoCsFO9jf5KCMIE/pYslEW7Fn0xa9hByVziyV9YsM6mot7gf41CmF7S5eWVl7smf
         WA/w==
X-Gm-Message-State: APjAAAVn4OrSLWGQ9N0MEBnL5CEgbo68v2X2XGrDyRdI6HY4Cf3nEozq
        oowwbUFhutfSu5c0dDsV7Vf9Nv3x
X-Google-Smtp-Source: APXvYqxtBp00ozcwsH0h6RkFNguOuXbrCq3p9SMa4uqnZ0wQB9w9DHyXdONrvcFY0NUSwaXfHsFfqw==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr2166288ljg.144.1582704300911;
        Wed, 26 Feb 2020 00:05:00 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id a3sm570720lfo.70.2020.02.26.00.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:05:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6rgh-0001U3-EC; Wed, 26 Feb 2020 09:04:59 +0100
Date:   Wed, 26 Feb 2020 09:04:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] USB: core: Fix build warning in
 usb_get_configuration()
Message-ID: <20200226080459.GU32540@localhost>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:15:22PM +0800, Tiezhu Yang wrote:
> There is no functional issue, just fix the following build warning:
> 
>   CC      drivers/usb/core/config.o
> drivers/usb/core/config.c: In function ‘usb_get_configuration’:
> drivers/usb/core/config.c:868:6: warning: ‘result’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   int result;
>       ^

What compiler are you using? The warning is clearly bogus and it hasn't
been seen with any recent gcc at least.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/usb/core/config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index b7918f6..bb63ee0 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -865,7 +865,7 @@ int usb_get_configuration(struct usb_device *dev)
>  	unsigned int cfgno, length;
>  	unsigned char *bigbuffer;
>  	struct usb_config_descriptor *desc;
> -	int result;
> +	int result = 0;
>  
>  	if (ncfg > USB_MAXCONFIG) {
>  		dev_warn(ddev, "too many configurations: %d, "

Johan
