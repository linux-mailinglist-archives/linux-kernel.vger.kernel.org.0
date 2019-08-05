Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3280E825F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHEUTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 16:19:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:19:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so40167088pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xBWCTm8N8Yifh09tk07A94FvqSIiabAj5rSoGm/YzsQ=;
        b=Btnt57UOv0m4dreUiqg3uXNlFJzanFVmkNgSMvCd/nPOwjHC3MA9EoM96eyvJvQ2gD
         34VAUWfxL8Z0fvuS31hZ6DkDC7UYRBxQYOLpwNmO+929aSYqR6NhWc5tGnmNnLFe/mpi
         k8PkXLiQBjt6a2+B30AeD3uNEVw94lKLs3K7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xBWCTm8N8Yifh09tk07A94FvqSIiabAj5rSoGm/YzsQ=;
        b=Z7vNd1ENfYg3HP5nQ5R9fgGLxj7me/yzn5OVsEMm/Vy4olrMoqAEOfPN1tcLITAPLA
         w7gRN8f59jcuFFbULJcvjw2Kvrg71meCtA6KhQsi0fGuaR4k92jOvYckBk9V/mKbFynX
         KUrZPnuoA57Qg6MNttYkBtJpC/6ua+blG/RDXGYEyr/6gCMScbsHLz+0Q0wghFKhvA3E
         eBnSzMG27FUSI/hHW6ny2zS68DQDXr+l6NKJTXh5c8TKpCPjAUsBB9ipOt79k/zYtx7k
         nebMIk2M44phnzJHFinfQhtPLCytdAGcUeCsAbuIopZL6G+fXWf0XRRQ4sVlJHhVxbtT
         cf6w==
X-Gm-Message-State: APjAAAXgb+DodGmkfi5gSy/lfl6L9u1nvHpj5plaAhBmb3kUA7AplCZd
        qR7afXdbj4HlIRIRitFX4a6cBKVcDYs=
X-Google-Smtp-Source: APXvYqxl+I5gFrxtAPAk5cKgR2CargOkThyRxpDJdSjuFS9CCBUUy11MK1VdGA6f2j7dv4MdyqSgMg==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr20001819pje.129.1565036374349;
        Mon, 05 Aug 2019 13:19:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm52295278pgv.19.2019.08.05.13.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:19:32 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:19:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.orgCc:linux-kernel"@vger.kernel.org
Subject: Re: [PATCH] x86: mtrr: cyrix: Mark expected switch fall-through
Message-ID: <201908051319.B3B8858@keescook>
References: <20190805201712.GA19927@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805201712.GA19927@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 03:17:12PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warning (Building: i386_defconfig i386):
> 
> arch/x86/kernel/cpu/mtrr/cyrix.c:99:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/cpu/mtrr/cyrix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
> index 4296c702a3f7..72182809b333 100644
> --- a/arch/x86/kernel/cpu/mtrr/cyrix.c
> +++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
> @@ -98,6 +98,7 @@ cyrix_get_free_region(unsigned long base, unsigned long size, int replace_reg)
>  	case 7:
>  		if (size < 0x40)
>  			break;
> +		/* Else, fall through */
>  	case 6:
>  	case 5:
>  	case 4:
> -- 
> 2.22.0
> 

-- 
Kees Cook
