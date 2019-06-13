Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 194C544677
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfFMQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:52:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbfFMDZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:25:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so10855852pfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 20:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=na+M1IgMGaM0aP15I3XbgNE1q19snWq8SHI4WbjnUi8=;
        b=ayqIIySKl6kes4w9jYHEywIJSvRDA1zi9AMajnhKYpTxcdVuBdAgsWgJaGqrz7xwF+
         9RC/evdpHaaIJEqxagLrwVocrWh3UMlFyW9tMnoHoIj67T2hZWr+R1JYWozCB1qocR0C
         cgnBD4a+F5VS9acKQF05CqFm3K2gf7BOYvzfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=na+M1IgMGaM0aP15I3XbgNE1q19snWq8SHI4WbjnUi8=;
        b=MfXiRFDKoduUZNyQbs9MDpN6hj9vxAfxDLsLBzBTl3cC9C/ac0XMorBt4Vx6WHyaCg
         2MwXyhMmX/W+YfNA5ADtOaYOXxN6memxlLzouojHPokNeVo8clO9jqYvTIMBdFtIFa5I
         QcPrGGJ+Jfy6o0AQRKdEoppJV0zCR7a39nL0njWFv52JLkEzABK4w6h3WIvnqeHEe8Tu
         ylrH67BsnXSOHhkTVdlFWE2vs8WDkmcNhextxbobjME507kTjsTqawTYvzGCiXGm7jIh
         324gQfyKkHEIQimL9llJDRgUsEMFQbE0IiAA9Apf0kbMIHN0/jmg27F0KSRW0KpFD57k
         OFow==
X-Gm-Message-State: APjAAAUG2YirNVjvTnhQon2wMGRZnBjyPtqWPDfy+nx0cPAyn5ewAo78
        Y6oqc40BeBtGg8pnnVyldq/gYL2dIMw=
X-Google-Smtp-Source: APXvYqyM53aFUeG9U9Tc6RAfzM93Fkh7XJF4rWPgPyOYiilGDKKp1+at7vv7zLSJgsW+VMFEfd9C/Q==
X-Received: by 2002:a17:90a:1951:: with SMTP id 17mr2512798pjh.79.1560396311357;
        Wed, 12 Jun 2019 20:25:11 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id w132sm959398pfd.78.2019.06.12.20.25.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 20:25:10 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Enable kernel XZ compression option on PPC_85xx
In-Reply-To: <20190603164115.27471-1-paweldembicki@gmail.com>
References: <20190603164115.27471-1-paweldembicki@gmail.com>
Date:   Thu, 13 Jun 2019 13:25:05 +1000
Message-ID: <877e9qp3ou.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Dembicki <paweldembicki@gmail.com> writes:

> Enable kernel XZ compression option on PPC_85xx. Tested with
> simpleImage on TP-Link TL-WDR4900 (Freescale P1014 processor).
>
> Suggested-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8c1c636308c8..daf4cb968922 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -196,7 +196,7 @@ config PPC
>  	select HAVE_IOREMAP_PROT
>  	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>  	select HAVE_KERNEL_GZIP
> -	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
> +	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x || PPC_85xx

(I'm not super well versed in the compression stuff, so apologies if
this is a dumb question.) If it's this simple, is there any reason we
can't turn it on generally, or convert it to a blacklist of platforms
known not to work?

Regards,
Daniel

>  	select HAVE_KPROBES
>  	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
> -- 
> 2.20.1
