Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529E239FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2019 15:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFHNph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 09:45:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38785 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:45:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so3036563qkk.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MUPzmCJTf51J7FWBUyfukjZxItNopz4dEjvYkIcFsmw=;
        b=Q2pkpTSh1sN3U8JV85bhk2nEzmUygYdBsraQ4g0HlG3alCSXucsczck0e33FeJTdWh
         9XOj8LtvUveWSagEvqU257mowxAolaPyE4Tfa0WzkOs2VJNbd9cAnyQ/I1oLCWJoykuq
         t2OiqtWF51/6yhnwsOaImIfM7TCPufiXxfrgf5tQHtdC/OkoL9Fz1lmba+i6BjvjgQKa
         7k56dP/NuDsV6kLYgsASzfGz7hGa44Knslc4/+MKbEoCo1VtS4gSgB7cWa7AnYDIiDuY
         5iV4+Y45m6x+gOxvXcYAGOgDvJtRWlzqZ+AU+BiOQh8SWpwsYXPEUTeFnP9G57XRDjL2
         +5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUPzmCJTf51J7FWBUyfukjZxItNopz4dEjvYkIcFsmw=;
        b=pqEy2IV3JTGAjWFVK5+XViu8CPP/x7dNOIKds2+DS1FzBP6Nhakq18ChfifhFhNsRN
         8KO41zvUNdDpouOGnsFtz21vfTmDNl8E5VbSr02G+7vpM5OGCFla8tUe3BojtDrnt6GB
         DMLNOe4s/uBAhDC9Un1feSY+I0fNCjDb7xoA9NIrv99xBezzONpmFC0Kh+gM9/K68Glw
         oZqyba8tEx6nzgJxIe9iFi06tYT1V4yB8C4OVKf9Ls6tScQB7V8rM7pA5EptR4TpTFpm
         v5/x/31DoXRquSdApeVcQgrIZ7E8jFgJGQPBUcVtHj4Sk9L3xb3/GamW+wEqbU9QTyMz
         jtjw==
X-Gm-Message-State: APjAAAWLfSak6VpyThQYodmmg/LPPPe9GUA82yAoy9CDuEqWClVYhAN8
        GNIFlhPECAN50kfucieRz1A=
X-Google-Smtp-Source: APXvYqy7bXDSwzqI7DavVnoWod/v6m7quPV7wq8QDArJeMYTrf7s3jVmLs4z11XCnh1WGiWiSQTX7A==
X-Received: by 2002:a37:9c16:: with SMTP id f22mr48508568qke.261.1560001536036;
        Sat, 08 Jun 2019 06:45:36 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id l94sm2427949qte.48.2019.06.08.06.45.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 06:45:35 -0700 (PDT)
Date:   Sat, 8 Jun 2019 13:45:05 +0000
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Hao Xu <haoxu.linuxkernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: kpc2000: kpc2000_i2c: void* -> void *
Message-ID: <20190608134505.GA963@arch-01.home>
References: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559978867-3693-1-git-send-email-haoxu.linuxkernel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 03:27:46PM +0800, Hao Xu wrote:
> modify void* to void * for #define inb_p(a) readq((void*)a)
> and #define outb_p(d,a) writeq(d,(void*)a)
> 
> Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
> index a434dd0..de3a0c8 100644
> --- a/drivers/staging/kpc2000/kpc2000_i2c.c
> +++ b/drivers/staging/kpc2000/kpc2000_i2c.c
> @@ -124,9 +124,9 @@ struct i2c_device {
>  
>  // FIXME!
>  #undef inb_p
> -#define inb_p(a) readq((void*)a)
> +#define inb_p(a) readq((void *)a)
>  #undef outb_p
> -#define outb_p(d,a) writeq(d,(void*)a)
> +#define outb_p(d,a) writeq(d,(void *)a)

Alternatively to fixing up the style here, did you consider just
removing these two macros altogether and calling [read|write]q
directly throughout the kpc_i2c driver (per the '//FIXME' comment)?

Unless, I'm misunderstanding something, these macros are shadowing the
functions [in|out]b_p, which already exist in io.h. [in|out]b_p are for
8-bit i/o transactions and [read|write]q are for 64-bit transactions, so
shadowing the original [in|out]b_p with something that actually does
64-bit transactions is probably potentially misleading here.
