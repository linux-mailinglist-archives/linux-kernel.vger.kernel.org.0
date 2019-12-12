Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E995411D39E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfLLRTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 12:19:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34694 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbfLLRTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:19:12 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so3637582iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkLYAaxMsU89doUTWE2z523QubdkgbrHcn6MJHqsfXE=;
        b=wM+/b415vKlDGcH0FT/DmrKXrbr3+kjOJQQoZ4B25gdq0MrNNbvBCdRTZ70xAIsQDW
         CFLkZXXyejBI+Lhg5WzsI+7PmQ3UxW1xTQYKLLbXSaqtHm477JfYoqtJLqU3hjTxlJnE
         SmkoE4OhLIixqmmvcz3WEw8Nqo0iWTUAwkPzWlHzP5XZNyIRlIaK9JICNaa/P2x24m++
         mfCUtbdGFDjR3ImgYC3HYQqYCdBy5lw0iZO3dzBdKXbRgtuN8cpuykL65AxKHbV6P4RA
         UCNmM/c1ZIGYLZSEFUfxGHUa/cY8PUGWT2XgluJ1cZCvHwL6Dx8h8ajtSTB/VtyDCQRR
         9Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkLYAaxMsU89doUTWE2z523QubdkgbrHcn6MJHqsfXE=;
        b=YL8qhLapvTnrziQ6NyaazfTTQf++6qx3+C8i2Q0QfHqda4B9XrQWtgH2bwVlLGssD+
         sEuqcz90gS86v8Wd9M/tLaTInsmQdSfiTCG9W9Qt8imonYHo0BMYb+f4gs5mON1ZsIpE
         ZzO/DHCCajr8Rz1gWwoj0L/GlRwL++Zyx6fIuVJqxxM0PP952iJtgLD2EZ+r4KWkwBcp
         jqYnVZaUCoiF9P/TqrFmS1k7BRWgCscP8lh6dcFEtPm2ONf7v1mI4dru0hH1fQ0VoDTx
         Hwo4HEW1il4iTNQQ9MvgvxtFXInLyVBXHXj/+7tyoKIU2n786KlQ+DAMRfpuN8nA7AE8
         7a9w==
X-Gm-Message-State: APjAAAWOGk2idRSxHZjAyh6mxFIlvNSGavBu1H4CwPoWFp5jt59eALBi
        G00mnc6TJ6rSbjuwm9Dq3LLIX+TOzzenPXD0nHin2Q==
X-Google-Smtp-Source: APXvYqzcvq5kvJBsourvh7Hjzum+2v1u8IfMIeuKWSS5IOPVmIafGGO3yRhanv7wXvyRrE+ZuHakaUlNy1tci7y8T2A=
X-Received: by 2002:a6b:8f41:: with SMTP id r62mr3888363iod.140.1576171151873;
 Thu, 12 Dec 2019 09:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20191210203339.2830960-1-arnd@arndb.de>
In-Reply-To: <20191210203339.2830960-1-arnd@arndb.de>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 12 Dec 2019 10:19:01 -0700
Message-ID: <CANLsYkzqoBg+Xs7i146VTfut2pG0_k_U1N60Bp9dDSs4UfqWLw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: fix unused function warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 at 13:33, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Some of the newly added code in the etm4x driver is inside of an #ifdef,
> and some other code is outside of it, leading to a harmless warning when
> CONFIG_CPU_PM is disabled:
>
> drivers/hwtracing/coresight/coresight-etm4x.c:68:13: error: 'etm4_os_lock' defined but not used [-Werror=unused-function]
>  static void etm4_os_lock(struct etmv4_drvdata *drvdata)
>              ^~~~~~~~~~~~
>
> To avoid the warning and simplify the the #ifdef checks, use
> IS_ENABLED() instead, so the compiler can drop the unused functions
> without complaining.
>
> Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index dc3f507e7562..a90d757f7043 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1132,7 +1132,6 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
>         drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
>  }
>
> -#ifdef CONFIG_CPU_PM
>  static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  {
>         int i, ret = 0;
> @@ -1402,17 +1401,17 @@ static struct notifier_block etm4_cpu_pm_nb = {
>
>  static int etm4_cpu_pm_register(void)
>  {
> -       return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
> +       if (IS_ENABLED(CONFIG_CPU_PM))
> +               return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
> +
> +       return 0;
>  }
>
>  static void etm4_cpu_pm_unregister(void)
>  {
> -       cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
> +       if (IS_ENABLED(CONFIG_CPU_PM))
> +               cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
>  }
> -#else
> -static int etm4_cpu_pm_register(void) { return 0; }
> -static void etm4_cpu_pm_unregister(void) { }
> -#endif

I have applied this.

Thanks,
Mathieu

>
>  static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  {
> --
> 2.20.0
>
