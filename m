Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FF8158C07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBKJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 04:45:28 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39850 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBKJp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:45:28 -0500
Received: by mail-ua1-f67.google.com with SMTP id 73so3699722uac.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBQbJL9w0L5FatKuuSiioztcIT23PXAGjfOfsR5LHQ0=;
        b=GLWoPZc147lP/xTF0fGJFVcKYtRtXrc6DuzMpYKtI3EadsTAAiWVzxxgMaHKmHkK8j
         7+AM/XrvL9i6J1EM/7OYgZuHjKkM9dHjzptJzvOgl7Is0pRr7OLt7ZPdzZxLXzwHs2HS
         QfxQB12VUvh4O/K23mnlFwAYEtvLrZiW1ISCxGU8dwVEMKRjpkpSZFJyojKlcZCNy0zt
         YBu5cuYF4SdATXcsgQH6LMteO6CpULe1XoMHXxFR1WvKPFcUQgEryilqPjarY3VxaXuA
         rAALCdEfW16ssCkFa64jghPqHlhrxNZSZgLUtJqmdASGntKSOyu4W0WLnbbtsMukscWz
         BLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBQbJL9w0L5FatKuuSiioztcIT23PXAGjfOfsR5LHQ0=;
        b=BEsyKJRTzeKCn7AmYIcqwrOfq1XUK6TcaChHFu/6205G5pcir6k6WWu+osio4xzQqv
         mK4vXhS2lQ91K+gXFOZ/Xd5JqfRBcXUwIo3a9leOzT7YxRgDGlGAAs62XXTiVPZNWSUo
         whxFciBMw/xoTxnaKmfc+VBp1YlQ3uk0JWIoo8J3Ajyemru6BDzJ40CQYo1bSuLOX2H9
         1snZSor3fvsvEJiVkru6b1chc6ba2Yarm/G52nVzyvLt5JaoT74/mqI5Vze7TcrDD+7v
         DlZ4KUtf0CaOGalJQRyjWLiEjrjFVDok7pNCWFrdJIRTcMIaJ3Qk6k/24ox/9QeoBwSN
         7ptA==
X-Gm-Message-State: APjAAAUS3cMjpI8d1zmOsJFXbYX3V1RbM/l3yLKLTnp42lFjcqIHO6P7
        XqdYVDgkzVhe1xuY527q9QpUvesukCt5LaHkRLY1DQ==
X-Google-Smtp-Source: APXvYqzmdkCShViJX/ZyLFGu/K7Xn2EJrE+6tTMoQXX3/NnRjF6msjPk1NRHlWi0GeGmIFBqRHj60c1+IbB+DnomAQE=
X-Received: by 2002:a9f:3046:: with SMTP id i6mr1183158uab.15.1581414327096;
 Tue, 11 Feb 2020 01:45:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580894083.git.baolin.wang7@gmail.com> <3fd82478e82b19c72dddcc17c85313725aa13ff6.1580894083.git.baolin.wang7@gmail.com>
In-Reply-To: <3fd82478e82b19c72dddcc17c85313725aa13ff6.1580894083.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Feb 2020 10:44:51 +0100
Message-ID: <CAPDyKFq_tj+2yYf3YLA2vQkHGWWrY_ULUP=6-anpSJ0q+YvkFw@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] mmc: Add MMC host software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 at 13:51, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> From: Baolin Wang <baolin.wang@linaro.org>
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.

Would you mind adding some more context about the mmc_blk_rw_wait()?
Especially I want to make it clear that mmc_blk_rw_wait() is also used
to poll the card for busy completion for I/O writes, via sending
CMD13.

>
> Thus this patch introduces MMC software queue interface based on the
> hardware command queue engine's interfaces, which is similar with the
> hardware command queue engine's idea, that can remove the context
> switching. Moreover we set the default queue depth as 64 for software
> queue, which allows more requests to be prepared, merged and inserted
> into IO scheduler to improve performance, but we only allow 2 requests
> in flight, that is enough to let the irq handler always trigger the
> next request without a context switch, as well as avoiding a long latency.

I think it's important to clarify that to use this new interface, hsq,
the host controller/driver needs to support HW busy detection for I/O
operations.

In other words, the host driver must not complete a data transfer
request, until after the card stops signals busy. This behaviour is
also required for "closed-ended-transmissions" with CMD23, as in this
path there is no CMD12 sent to complete the transfer, thus no R1B
response flag to trigger the HW busy detection behaviour in the
driver.

>
> From the fio testing data in cover letter, we can see the software
> queue can improve some performance with 4K block size, increasing
> about 16% for random read, increasing about 90% for random write,
> though no obvious improvement for sequential read and write.
>
> Moreover we can expand the software queue interface to support MMC
> packed request or packed command in future.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---

[...]

> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f6912de..7a9976f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1851,15 +1851,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         card->reenable_cmdq = card->ext_csd.cmdq_en;
>
> -       if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
> +       if (host->cqe_ops && !host->cqe_enabled) {
>                 err = host->cqe_ops->cqe_enable(host, card);
>                 if (err) {
>                         pr_err("%s: Failed to enable CQE, error %d\n",
>                                 mmc_hostname(host), err);

This means we are going to start printing an error message for those
eMMCs that doesn't support command queuing, but the host supports
MMC_CAP2_CQE.

Not sure how big of a problem this is, but another option is simply to
leave the logging of the *failures* to the host driver, rather than
doing it here.

Oh well, feel free to change or leave this as is for now. We can
always change it on top, if needed.

>                 } else {
>                         host->cqe_enabled = true;
> -                       pr_info("%s: Command Queue Engine enabled\n",
> -                               mmc_hostname(host));
> +
> +                       if (card->ext_csd.cmdq_en) {
> +                               pr_info("%s: Command Queue Engine enabled\n",
> +                                       mmc_hostname(host));
> +                       } else {
> +                               host->hsq_enabled = true;
> +                               pr_info("%s: Host Software Queue enabled\n",
> +                                       mmc_hostname(host));
> +                       }
>                 }
>         }

[...]

Kind regards
Uffe
