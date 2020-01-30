Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C514D89D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA3KGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 05:06:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36428 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgA3KGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:06:16 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1894458lfh.3;
        Thu, 30 Jan 2020 02:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMa1e7CIB/ICH+nou7ITTylFB/1HYBUx8QMl9FpjHbE=;
        b=f4peSxZHZ4OjdRhuPvtSOmdIJ9UlrhodwItFng5/y5lcXf8D+/c3fEd0Fe+rCGPQux
         stkxhXnM/aEa38+rFK4xk+3xBv6KSKxzA+fwjQ8ipWBOiZEwmGYsWkh/pBsEIX4+p8yv
         5ivGAmZRBv+6ElYBG2X6OhuofkCh/EePCoO7396gCAMZP8Zr8w9iu9kK6h+wDgByGQgs
         mwiEwOmF7U+EiGkgXai+QAunzx3KrxyUdFgXKSih/m18Wexw90zIr0+XHayCtWSA0nAX
         rJ2rg9RmUiff7avM+niecfiJgwX79JC5eCvRgcm7LTAqNtaFlklCveK4avAIlIVFWbwS
         S+jw==
X-Gm-Message-State: APjAAAUqkctAXzcooU0Ip+Kt0pbda6HvKKwFocpsdWvpWY1NjMac0RJ+
        tH2xyaRDdAeMhJjvHanQKXfSoNcL
X-Google-Smtp-Source: APXvYqzhduINwM+6QPXly3R+WJ2s7x7uQCv2U3UkXyQumgwIFYQkKgBmi/MtvPr1aU1ZG5ImcRAe4g==
X-Received: by 2002:a19:4849:: with SMTP id v70mr2248063lfa.30.1580378774190;
        Thu, 30 Jan 2020 02:06:14 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u23sm2517545lfg.89.2020.01.30.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:06:13 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ix6iH-0000Ae-Dp; Thu, 30 Jan 2020 11:06:17 +0100
Date:   Thu, 30 Jan 2020 11:06:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 7/8] usb, cdc-acm: optimize barrier usage for Rmw atomic
 bitops
Message-ID: <20200130100617.GA8871@localhost>
References: <20200129181545.25302-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129181545.25302-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:15:45AM -0800, Davidlohr Bueso wrote:
> We can avoid the unnecessary barrier on non LL/SC architectures,
> such as x86. Instead, use the smp_mb__after_atomic() call.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: Johan Hovold <johan@kernel.org>

> ---
>  drivers/usb/class/cdc-acm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 62f4fb9b362f..0bc4b558f387 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -842,7 +842,7 @@ static void acm_tty_unthrottle(struct tty_struct *tty)
>  	clear_bit(ACM_THROTTLED, &acm->flags);
>  
>  	/* Matches the smp_mb__after_atomic() in acm_read_bulk_callback(). */
> -	smp_mb();
> +	smp_mb__after_atomic();
>  
>  	acm_submit_read_urbs(acm, GFP_KERNEL);
>  }

We have another barrier in USB serial which can also be relaxed this
way. I'll post a patch shortly.

Johan
