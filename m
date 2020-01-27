Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D383814AC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0X1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:27:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39961 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0X1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:27:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so5948167pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hwrToBDFY4HIyFLVjgz55WQA/wuDwI/+ZrtWoDNgqy8=;
        b=P7/Ol9VFJBuzQj3BmDZ7XheRs5xTuuwbS3UWi5CNkSUsTkwKfcix4/o2R+Uqg5Z+S7
         bgnUa/54hKHdlkuF9qEt8rIwaLxRSrCEDlNlgmuGNNmsaZgbmaHRHhCCy7vdag57HgjB
         cw4veg02KHYv1G0VjBjblOt60y/D7hKBbXeNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwrToBDFY4HIyFLVjgz55WQA/wuDwI/+ZrtWoDNgqy8=;
        b=hb4ViS67lQLQ4zE4NgdCQ0QiNWh20UY96vcFL+uLUbUkufTR+oJmMOHDe61sTyGHHF
         kiiS95KYy+lhNnnwN2hyPXMDLgadXO4oeOGnY1NlJY1112de4A2GpcSfFD8kBbI/XpUG
         a9iB9jAvqzqcymom6ylgsT1HfyOpljHWdpEpRlnkIi5Lj7IIXv+96RdMGCunhq819pVY
         /m1vLXXl1vKGBV3LapTQBTq0JG7KiTbDOGDfDgJhtY2DERqdrBpI3vSHfv4GGl882u8z
         tAW7OWbSfnub9kzhm9YDuqyqmCqYlRfSjFTvlvlzVq9iTRv6yF5bLk8/nbqa8RRaGYgA
         12Yg==
X-Gm-Message-State: APjAAAW3upP7PogFlovuK0a+eyfn2M0lVP7hTo8oJIgo4RAsypFVgPhc
        1+n+11iEN5oY63a2kKv2BJCkGA==
X-Google-Smtp-Source: APXvYqzBa+ZBcDQ+dqyhCzSfqudbD6GhoALp9yymRH4pSJpi2ADb/wQQOBTsiGcGP/atIwo/qfxDjQ==
X-Received: by 2002:a62:cd86:: with SMTP id o128mr1017346pfg.187.1580167655327;
        Mon, 27 Jan 2020 15:27:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r2sm17236619pgv.16.2020.01.27.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 15:27:34 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:27:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] pstore: Fix printing of duplicate boot messages to
 console
Message-ID: <202001271525.E6EB4FDD6@keescook>
References: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123160031.9853-1-saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:30:31PM +0530, Sai Prakash Ranjan wrote:
> Since commit f92b070f2dc8 ("printk: Do not miss new messages
> when replaying the log"), CON_PRINTBUFFER flag causes the
> duplicate boot messages to be printed on the console when
> PSTORE_CONSOLE and earlycon (boot console) is enabled.
> Pstore console registers to boot console when earlycon is
> enabled during pstore_register_console as a part of ramoops
> initialization in postcore_initcall and the printk core
> checks for CON_PRINTBUFFER flag and replays the log buffer
> to registered console (in this case pstore console which
> just registered to boot console) causing duplicate messages
> to be printed. Remove the CON_PRINTBUFFER flag from pstore
> console since pstore is not concerned with the printing of
> buffer to console but with writing of the buffer to the
> backend.

I agree this patch isn't the solution, but I'm trying to understand
where better logic could be added. Is the issue that printk sees both
earlycon and CON_PRINTBUFFER active? Can we add a new CON_* flag that
means "not actually printing anything"? (Or maybe a new flag for
non-printing to replace CON_PRINTBUFFER that lets pstore still work?)

-Kees

> 
> Console log with earlycon and pstore console enabled:
> 
> [    0.008342] Console: colour dummy device 80x25
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]
> ...
> [    1.244049] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x51df805e]
> 
> Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  fs/pstore/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index d896457e7c11..271b00db0973 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -505,7 +505,7 @@ static void pstore_console_write(struct console *con, const char *s, unsigned c)
>  static struct console pstore_console = {
>  	.name	= "pstore",
>  	.write	= pstore_console_write,
> -	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME,
> +	.flags	= CON_ENABLED | CON_ANYTIME,
>  	.index	= -1,
>  };
>  
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

-- 
Kees Cook
