Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87D5BEFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 12:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfIZKoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 06:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfIZKoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:44:20 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7C2AC056808
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:44:19 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so854987wmg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Riw/2Ux9OsHBDm8paJcZzsJiBRoPakD2IyewC8/qlH0=;
        b=Mco0TBV9DX/7E10CumnZrhfv8bS76zwzIi/K8vk6uaNLhCcGnkDcoK1ckoCFqZSFiD
         n6edbWmkC+vGpNAi+6YHRt/E8p3ZBFy6aeyXS8jK09JGFSwDL799AFqtqB6owqkpwR0S
         xX+twSYZRYMCfW0Oufg7DjeT3XpEKQe3epAtpiEdJY1T2q4lk4DaPQfHM0GjpsLSh01/
         hi4SSZ51bWkOYGKxjacnpBHIoys4ywUuBgz8aYD83jj18zoP02iHd07WcJUujxw/P0oO
         V8boV7TFGt1CfI7aNpg68+0TQygmEMNLEkL4npry+t/Cc22YvPfqrkPJxdstxOaryozF
         w+aQ==
X-Gm-Message-State: APjAAAWfQrNwiPAz6aHH0gK8v0uwSrXdBeK6NSwag4UJnyVJRzEAaXzZ
        ivzTc8+PutxVN53vrKBTGIa/fvidobeDL6A8rYcDH2LZHT+UBj7VKCdPGkV0JkBek//CoxePCHf
        sj65nUdj8xt4PzJg6MVFAQUlK
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr2319309wrq.292.1569494658664;
        Thu, 26 Sep 2019 03:44:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxr5GEjW6ka0m4Lpc1OF+XdjpU3XZQ6+sKdP/4G5PYjuXWwBJlGoNZuBr1r4uMLP1CN0JDCCQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr2319287wrq.292.1569494658461;
        Thu, 26 Sep 2019 03:44:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q19sm3835597wra.89.2019.09.26.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 03:44:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd\@arndb.de" <arnd@arndb.de>, "bp\@alien8.de" <bp@alien8.de>,
        "daniel.lezcano\@linaro.org" <daniel.lezcano@linaro.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "x86\@kernel.org" <x86@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for hibernation
In-Reply-To: <1567723581-29088-2-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com> <1567723581-29088-2-git-send-email-decui@microsoft.com>
Date:   Thu, 26 Sep 2019 12:44:16 +0200
Message-ID: <87ef0372wv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 866dfb3..037b0f3 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -20,6 +20,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/slab.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
>  
>  void *hv_hypercall_pg;
> @@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
>  	return 1;
>  }
>  
> +static int hv_suspend(void)
> +{
> +	union hv_x64_msr_hypercall_contents hypercall_msr;
> +
> +	/* Reset the hypercall page */
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable = 0;
> +	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +

(trying to think out loud, not sure there's a real issue):

When PV IPIs (or PV TLB flush) are enabled we do the following checks:

	if (!hv_hypercall_pg)
		return false;

or
        if (!hv_hypercall_pg)
                goto do_native;

which will pass as we're not invalidating the pointer. Can we actually
be sure that the kernel will never try to send an IPI/do TLB flush
before we resume?

-- 
Vitaly
