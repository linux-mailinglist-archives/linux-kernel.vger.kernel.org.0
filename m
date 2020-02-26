Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC461702C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgBZPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:40:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgBZPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:40:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so3653892wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B52/TzLFaZ8ELTIpZ/2PQuvnXdlCL7Qyj/3+GDpbM98=;
        b=aLK6sFkLCKZDv+4r78ATZHhLeXxZmMm4tfcUeHBksjhvUxB4GDL09kT6PvaIc5m3vB
         +V8MqGfsdyk2Ggc+D0toIGzmxLfBMYQzFdrIoTZBjj8KCqJqTTSEdo/8i+J/DYJSIaEJ
         x5dzLhZe8GfdDvYeOiHugLFp4g1rVA4A7W90tW+DqyLSHtgKfmgDdUTj7KCDuFuWM1Qn
         h8gCtcE3l372dJ+Io2d9uEPhb89+f8r98iRCxmfE6Dn0h7E2r3f+HZ7rkpngAZG0GF+8
         iV7t9Ndgc5uu3+bxNGjpnQtfVFEzwWRlT/7S7qzHOtOh4jCHhy4rokSTf7PgXK/sCAbf
         g12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B52/TzLFaZ8ELTIpZ/2PQuvnXdlCL7Qyj/3+GDpbM98=;
        b=F4Pv0WTLplbNf0jvq5TOFIBOdZtADxdArtQp+i6vVAGZYQJ97pYNIqYy6AgiwrBHjx
         ypoPwb/WRsPSuAzdmEglKKTjFuRtxCI6Os4vZEoPQ3cS0Knagr1oAXZbYHTQ8umYMbz3
         Z0fwrxBgz+IG7XtQIb0s2SiarZkyFJruHhSBY27hKgL/uEQsYa5hPJIn6iQK1Mrc7Ijf
         4PkH5LPH9Vv6F4Do7xmoayjXkd9zoAg8PydinD38KK0M9IUsqG9funW/lMdmUrr9ilSn
         M42XVD4wSYecdx4ulXdkh8DhzXx/+ZQFaJVrCeIOlCOngh1JLoD4IiB8FKFcwU5FyXfW
         5mog==
X-Gm-Message-State: APjAAAUiSDkFCi7Ctdhe3pjQaZGvkmMx7TSy3i6BjQRjhWdkMQumZYfJ
        /aziBOe2r+atuWdhqQDh7PPMSw==
X-Google-Smtp-Source: APXvYqzQb4v6YIq/tH4gM9y8z9QC4YTU4AuGr+vaNK4P35wsrvLN41M9n96t5xpMi8l9wtu8Y1AvPg==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr5919562wmc.115.1582731622867;
        Wed, 26 Feb 2020 07:40:22 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id i2sm3259433wmb.28.2020.02.26.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:40:22 -0800 (PST)
Date:   Wed, 26 Feb 2020 15:40:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200226154055.GQ3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
 <20200223131638.12130-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200223131638.12130-2-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020, Andreas Kemnade wrote:

> This adds a subdevice for the ADC in the RC5T619
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> depends on:
> https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/
> 
> Changes in v3:
> re-added it to the series because of
> "Oh, it looks like there was a conflict.  Could you collect any Acks
> (including mine) rebase and resend please?"

Looks like there is still a conflict.  Sure, it's not a complicated
fix, but that's beside the point.  What tree is this set based on?

>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 073de8e0e78b..321836f78120 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -24,6 +24,7 @@ static const struct mfd_cell rn5t618_cells[] = {
>  };
>  
>  static const struct mfd_cell rc5t619_cells[] = {
> +	{ .name = "rn5t618-adc" },
>  	{ .name = "rn5t618-regulator" },
>  	{ .name = "rc5t619-rtc" },

In what upstream tree is this line present?

>  	{ .name = "rn5t618-wdt" },

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
