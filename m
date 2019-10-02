Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32261C9321
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfJBU6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 16:58:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40451 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfJBU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:58:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so207556pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KX5XeevGScIhOFues3GQkV78ozucGw/LYZ1l8L5X6bo=;
        b=YM7PrqwY/F7Vm9PudRT17T2mqcMDRwHbIT7qw3mpkzdEEzHkANg4PLltdxVjuLFB4q
         mOMigow1C99Fxn3258qWATdkH6FCy/iw8I1WAaM+BP4aM7NWNDxHcJANq1Drp3mh+m2H
         /aEO9TVSFVtczdY6PmO9rseb3o8Dna0PVSt1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KX5XeevGScIhOFues3GQkV78ozucGw/LYZ1l8L5X6bo=;
        b=kW1+iYfDhNtj+W8l8CFNgPhzK2VOy97ZrQHXv64QnY3vm1qJKE80f6GWpHnY5u1foE
         svnu2ww+guK6WKFsIpNxtTOgLiCK7+HPjQ1kk30yzyCKae7O15foh+8iCLa3R2FjL3V+
         TTseZqwGcXMPBT/iY6C5zrVZcuSxa8jcHYOhm/moc5TpRnfABn09ItxqIJj8LY4YVLXX
         CYfdN0Tq2n07QIKNMir/VkdhepezXeOPViejEBFdpoVwYjPNuXjTjzfUvQA1tU6XXQnR
         iahLC882wHwKD78RkHFFxqDbjldxlNrF5oLJrYRfuIk1SnVoxoRxo/sYOf2pXxYzdwap
         6qQQ==
X-Gm-Message-State: APjAAAVJnEIxH4z3InaN6NjM/lRjt0UIZ3l2JQkICIPf/UxUQiO9ULVE
        z97bjLSKl4fU5vw5Uo2oKlZ1Tg==
X-Google-Smtp-Source: APXvYqyKNOmRPkS1Q8AKw0jUMUMu27C3e3zFkbZCALS8GZ9yijv6oqy5W8ctOfywkUEq/6vs+Euvuw==
X-Received: by 2002:aa7:97b0:: with SMTP id d16mr7065724pfq.54.1570049927960;
        Wed, 02 Oct 2019 13:58:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p190sm354504pfb.160.2019.10.02.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:58:47 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:58:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        contact@xogium.me, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] panic: Ensure preemption is disabled during panic()
Message-ID: <201910021355.E578D2FFAF@keescook>
References: <20191002123538.22609-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002123538.22609-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 01:35:38PM +0100, Will Deacon wrote:
> Calling 'panic()' on a kernel with CONFIG_PREEMPT=y can leave the
> calling CPU in an infinite loop, but with interrupts and preemption
> enabled. From this state, userspace can continue to be scheduled,
> despite the system being "dead" as far as the kernel is concerned. This
> is easily reproducible on arm64 when booting with "nosmp" on the command
> line; a couple of shell scripts print out a periodic "Ping" message
> whilst another triggers a crash by writing to /proc/sysrq-trigger:
> 
>   | sysrq: Trigger a crash
>   | Kernel panic - not syncing: sysrq triggered crash
>   | CPU: 0 PID: 1 Comm: init Not tainted 5.2.15 #1
>   | Hardware name: linux,dummy-virt (DT)
>   | Call trace:
>   |  dump_backtrace+0x0/0x148
>   |  show_stack+0x14/0x20
>   |  dump_stack+0xa0/0xc4
>   |  panic+0x140/0x32c
>   |  sysrq_handle_reboot+0x0/0x20
>   |  __handle_sysrq+0x124/0x190
>   |  write_sysrq_trigger+0x64/0x88
>   |  proc_reg_write+0x60/0xa8
>   |  __vfs_write+0x18/0x40
>   |  vfs_write+0xa4/0x1b8
>   |  ksys_write+0x64/0xf0
>   |  __arm64_sys_write+0x14/0x20
>   |  el0_svc_common.constprop.0+0xb0/0x168
>   |  el0_svc_handler+0x28/0x78
>   |  el0_svc+0x8/0xc
>   | Kernel Offset: disabled
>   | CPU features: 0x0002,24002004
>   | Memory Limit: none
>   | ---[ end Kernel panic - not syncing: sysrq triggered crash ]---
>   |  Ping 2!
>   |  Ping 1!
>   |  Ping 1!
>   |  Ping 2!
> 
> The issue can also be triggered on x86 kernels if CONFIG_SMP=n, otherwise
> local interrupts are disabled in 'smp_send_stop()'.
> 
> Disable preemption in 'panic()' before re-enabling interrupts.

Is this perhaps the correct solution for what commit c39ea0b9dd24 ("panic:
avoid the extra noise dmesg") was trying to fix?

Either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/r/BX1W47JXPMR8.58IYW53H6M5N@dragonstone
> Reported-by: Xogium <contact@xogium.me>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/panic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 47e8ebccc22b..f470a038b05b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -180,6 +180,7 @@ void panic(const char *fmt, ...)
>  	 * after setting panic_cpu) from invoking panic() again.
>  	 */
>  	local_irq_disable();
> +	preempt_disable_notrace();
>  
>  	/*
>  	 * It's possible to come here directly from a panic-assertion and
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 

-- 
Kees Cook
