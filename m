Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECAA15A270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 08:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgBLHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 02:55:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36134 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgBLHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:55:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so899467lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOeJJO/gHIHj8IPyKogVmbQJ5pI6iqanQ/nqcsZTJg4=;
        b=WsaebOtVyZf799AWoTBZINOVHx/iwnX5tezuj5cRXNm3UPQ82JLtJnn8rBqzbVDmJa
         vGNVDnWGlODYLlzZwv9DDd07scxyjKkmYHrlVC6DUSu1dVzUzUIxozt4kZueRsDqqqaZ
         g8CbbQ4dwFVBzwimb3OwXYCeBuzr47rqnxOO8TycXIWdUQ7K2/kLJ6vptooryfMCuffq
         p0flW2JuPrHdLNudE2TN/JQbhxs6SaXvq6Em+HZq3aBRhAhtojWw/VClcy+WOla0xPok
         eEqVGMXQMH/twB5Mn/TmE1Z2OcVV6DCGaYAVRi2Zm3SjnFAkmO4tFQScRJNA5hHAWZMm
         LQPA==
X-Gm-Message-State: APjAAAUoo7zubezniUWMzoyXwSzeCVVbzWD6b7oq9khSOjl1fNESDk8K
        amXHdMArTjwT2jijPETIZpA=
X-Google-Smtp-Source: APXvYqwiqKB4EAN/96Tkd3vj9smH96Nvs43kXzhiz5qG0VLbRhU5S/mNpmL53tNqBKQrPI7aBPWvcw==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr5909864lfl.64.1581494098087;
        Tue, 11 Feb 2020 23:54:58 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id x10sm3474024ljd.68.2020.02.11.23.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:54:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j1mrI-0006TD-3b; Wed, 12 Feb 2020 08:54:56 +0100
Date:   Wed, 12 Feb 2020 08:54:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array member
Message-ID: <20200212075456.GD4150@localhost>
References: <20200211211219.GA673@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211211219.GA673@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:12:19PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
> 
> This issue was found with the help of Coccinelle.

Looks like the scripts may need to be updated. You missed at least a
couple of instances:

	$ git grep '\[0\];' drivers/staging/greybus/
	drivers/staging/greybus/audio_apbridgea.h:      __u8    data[0];
	...
	drivers/staging/greybus/usb.c:  u8 buf[0];

Would you mind replacing these as well so that we really do this in one
patch per subsystem?

> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/staging/greybus/raw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
> index 838acbe84ca0..2b301b2aa107 100644
> --- a/drivers/staging/greybus/raw.c
> +++ b/drivers/staging/greybus/raw.c
> @@ -30,7 +30,7 @@ struct gb_raw {
>  struct raw_data {
>  	struct list_head entry;
>  	u32 len;
> -	u8 data[0];
> +	u8 data[];
>  };
>  
>  static struct class *raw_class;

Thanks,
Johan
