Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850C6DBED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504677AbfJRHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 03:52:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36964 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504816AbfJRHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id u20so2458386plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtPXyBXklCVBqCfkf4k6vSv2ReOc+saCGEZzxF5ZIB8=;
        b=QR3Q4ivMbZIYSXTuwjLFHr9i17PyLdC4ap2QdCd/7/VJaaM3W2zn/gy04geuYYYyQ/
         wOvpc6xwX7WSLXgn+p0xbgcRM/tfDnEoT6BtkF6M3tdm8+TKT3cII3JfxDRwdo+LXQ/z
         TepvDVvlV6jGRtIXymT4j1BmQ3SA8cPPHIq4QpCgHe/yY0ZzHbgFffTlDBAvNDPqbNz+
         P+ItyTEjw14Ms4yX7MOyFwNO6QcHtuCGJiP4buqfKayctnk6nBGchL1FMRp8tCYGCCju
         5LOp/MlG24547uRVmHckxbm8nCV/c9hgoTv7WAIw/87tQ45gkFC94LIToYjSrbV/Gr4r
         Xo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtPXyBXklCVBqCfkf4k6vSv2ReOc+saCGEZzxF5ZIB8=;
        b=DHDTPT1m3fpOSSU6n8vTq+/fFwbF5ajUZ49aAu1di1oSBIh2ubPgt+Af05uGWS9vYf
         P2ms9YAwPR7qXCFEjSPUyb+uB73Ekmr/JCCrUN3FuTF5z9OU3ePn5O2sFnMe6UIswvcb
         AhizRupWk+NHnjSc3uo1EgBrWxrZdMlVv7AHniKsE9tbZAKGhrVVZM8oHTKSVrt8Qgkn
         maJ/rPMPteJiF3feltq03hP2pfSEIe6elYocovoVG9PQCppGOY8O7NGxMjtLgeEOAWii
         Ot+e+gjX86PbNRNis7OGkgdBCgdOYmCJgPioOLhlmwKhGzVwKP1UAi/gAWHf38gZNQX7
         Djbw==
X-Gm-Message-State: APjAAAUxVKH0ic1vT/3U3uj3BIE+Sp0SZdr7z5u+dsEHhPGqedZbY15W
        weN616RkzmYHzlJqjIb970f39xJQSaJVMQIr6t5s4XKDSuJIPw==
X-Google-Smtp-Source: APXvYqwmWZ/1nStLzfzuXa8onnSMaH6XuLTauTa0LfPk3/63eYXcQNRHp2wUV2HNm/oOHdoQQVIPaVz2GSjUyeUXPLE=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr8693256plp.18.1571385105975;
 Fri, 18 Oct 2019 00:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com> <20191018031850.48498-18-wangkefeng.wang@huawei.com>
In-Reply-To: <20191018031850.48498-18-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 10:51:35 +0300
Message-ID: <CAHp75Vc3ek7=jKN6GPoA+jC4qAgS9y5x7SPG7BUnMGA88JScMg@mail.gmail.com>
Subject: Re: [PATCH v2 18/33] platform/x86: eeepc-laptop: Use pr_warn instead
 of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:19 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/platform/x86/eeepc-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index f3f74a9c109e..776868d5e458 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -578,7 +578,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>
>         port = acpi_get_pci_dev(handle);
>         if (!port) {
> -               pr_warning("Unable to find port\n");
> +               pr_warn("Unable to find port\n");
>                 goto out_unlock;
>         }
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
