Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93B79016
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfG2QAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:00:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33943 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfG2QAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:00:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so27704525plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0V+nqRUKJ/wXTF8PNC+qKkULehTd1Z9IBC2xcJEr1OA=;
        b=h3DR1EAs9U0mh9Sq1YLTGzN8wajb7GBOI6d43E/w2s8x4LiJdUIcL5tz671/+xqvsf
         KIYKHm72KfAyDF4H9JShij7U8bzG+8k5ZwMCyu620muAut2frf/DOl/utrA6caAdPk7v
         zdM+VAtTi9KyaUp1CheR5uwZCsLn7yq/XOT48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0V+nqRUKJ/wXTF8PNC+qKkULehTd1Z9IBC2xcJEr1OA=;
        b=a0+BgQL22n3I77QGHFFtccStGHA3ty86C6smsSF/4T9XzvFv0gSWATUhTqWdiiGedQ
         3zNiMHm8iHWMKbm5gLptwCEkp4flFEUOJx4QTAV1Dx5GdvTilnpm25LndTsEuK51j0wc
         +bAKSZrfH5Band3N/cRaJ7JgGdQYPpWv08kwG83uY8vETBjkWMCKUr4NrbiO9l1MkFw4
         5z/9RB646ApmR458+PIUglvQ73scSrhEQzjg0IqEfttfU2OGGYVLORwvlcSCqov3613D
         IKADlXXcwwGiqGY5XnqoQ2i7C1JdHy502d0kFzo1FQT0FBdHi+ZXLBR92RtGGrfMOwfv
         eQ1Q==
X-Gm-Message-State: APjAAAXt1ByZC+GgCnhgrsUwxcJ4lgooEoXE1jyRZ999N6J10wvuzL+X
        CHEFDkKm8LNQnVQLNVwiqVcJ+g==
X-Google-Smtp-Source: APXvYqy1/lz01xcbRWXLaOnLEh5b2XaHl5uZAOECRw3qJ0rRaLaWNOztxelY9rfeu+7inxtVlAmzNg==
X-Received: by 2002:a17:902:306:: with SMTP id 6mr112340892pld.148.1564416020205;
        Mon, 29 Jul 2019 09:00:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i123sm85086288pfe.147.2019.07.29.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:00:19 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:00:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] arcnet: arc-rimi: Mark expected switch fall-throughs
Message-ID: <201907290900.81E6FE8B2@keescook>
References: <20190729111550.GA3327@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729111550.GA3327@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:15:50AM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: powerpc allyesconfig):
> 
> drivers/net/arcnet/arc-rimi.c: In function 'arcrimi_setup':
> include/linux/printk.h:304:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/arcnet/arc-rimi.c:365:3: note: in expansion of macro 'pr_err'
>    pr_err("Too many arguments\n");
>    ^~~~~~
> drivers/net/arcnet/arc-rimi.c:366:2: note: here
>   case 3:  /* Node ID */
>   ^~~~
> drivers/net/arcnet/arc-rimi.c:367:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    node = ints[3];
>    ~~~~~^~~~~~~~~
> drivers/net/arcnet/arc-rimi.c:368:2: note: here
>   case 2:  /* IRQ */
>   ^~~~
> drivers/net/arcnet/arc-rimi.c:369:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    irq = ints[2];
>    ~~~~^~~~~~~~~
> drivers/net/arcnet/arc-rimi.c:370:2: note: here
>   case 1:  /* IO address */
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/arcnet/arc-rimi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
> index 11c5bad95226..14a5fb378145 100644
> --- a/drivers/net/arcnet/arc-rimi.c
> +++ b/drivers/net/arcnet/arc-rimi.c
> @@ -363,10 +363,13 @@ static int __init arcrimi_setup(char *s)
>  	switch (ints[0]) {
>  	default:		/* ERROR */
>  		pr_err("Too many arguments\n");
> +		/* Fall through */
>  	case 3:		/* Node ID */
>  		node = ints[3];
> +		/* Fall through */
>  	case 2:		/* IRQ */
>  		irq = ints[2];
> +		/* Fall through */
>  	case 1:		/* IO address */
>  		io = ints[1];
>  	}
> -- 
> 2.22.0
> 

-- 
Kees Cook
