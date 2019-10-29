Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0522AE8CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 17:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbfJ2QlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 12:41:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45802 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390258AbfJ2QlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:41:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so9937921pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/SwnEWBgpO8uhQ3EMFcAeMVwoZ0LhooyFwQgCGtCb8=;
        b=HG4z30TuA7/IKrzPnmFV4mK1PPn6OLcaWbWuq+hpE8D0XMINay8grcpjCZY3X3zuAe
         aL/C+yCQ9+WIXOFFMAnfECbV7Uo8CrzEh+LS9YywIXYlojHMILN9HWblYKeki+05uqT3
         WtC0Ra+HH+p/eQLxly54DtXtlJ/SNFaAbAbOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/SwnEWBgpO8uhQ3EMFcAeMVwoZ0LhooyFwQgCGtCb8=;
        b=m0/8IJSAebtAbHX5L+zyPwuLe5JeE2LrCa8NM90cu9cLW8XZL5dBWuXtJ3jf1invgy
         O8Jhbcv9Q9WzZMN/bYmnlG373c07hcyyMJSQiprq7rCEWBonLVtlgKN9UM7cPoQYCPTq
         XF5Dzx7j1YDL30wBo1rwkaGLdk7P/kl6BzvJYAre3OwUlZPCDZTjX+CJQTpbF3+NIrX8
         GV2BhqHgHV/j4s+r6BuCNxwmezu4WjUB2GDzT1qI5gCGQz0Gr6CvqvjCGIOdOIM/l0rM
         HgxU49pLC5C+nNyXIeJadURAh3uI03M/B94HpVV0cCzb0/99MQjcJwK0A5FnWumGfN/F
         x2dw==
X-Gm-Message-State: APjAAAVPi3+W5e//bhUIAcxXO5S8pgqATWJwF2670Z6Z3D0GO3Z8+EA8
        C7L6I0zx3YikdyvSNzvt77IlsP2VsTA=
X-Google-Smtp-Source: APXvYqxqzxwtzPTcK0jqMUGTNz/tUufSeZeNXEy531rEV50WFFZvzK8YenHaMyj3YlfYhge+82MJuw==
X-Received: by 2002:a62:1517:: with SMTP id 23mr28248138pfv.236.1572367273277;
        Tue, 29 Oct 2019 09:41:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm9355020pfq.40.2019.10.29.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 09:41:12 -0700 (PDT)
Date:   Tue, 29 Oct 2019 09:41:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: make 'pstore_choose_compression' static
Message-ID: <201910290940.E90A2D2B1D@keescook>
References: <20191016123317.3154-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016123317.3154-1-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 01:33:17PM +0100, Ben Dooks (Codethink) wrote:
> The pstore_choose_compression function is not exported
> so make it static to avoid the following sparse warning:
> 
> fs/pstore/platform.c:796:13: warning: symbol 'pstore_choose_compression' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Oops! Yes, thank you. Applied to my for-next/pstore branch. :)

-Kees

> ---
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/pstore/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 3d7024662d29..d896457e7c11 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -793,7 +793,7 @@ static void pstore_timefunc(struct timer_list *unused)
>  			  jiffies + msecs_to_jiffies(pstore_update_ms));
>  }
>  
> -void __init pstore_choose_compression(void)
> +static void __init pstore_choose_compression(void)
>  {
>  	const struct pstore_zbackend *step;
>  
> -- 
> 2.23.0
> 

-- 
Kees Cook
