Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2878E240A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfETSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 14:47:14 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44619 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:47:14 -0400
Received: by mail-vk1-f195.google.com with SMTP id j4so4119992vke.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXzq25JjkHKfqM12yrowm3Yo57M4GMY0BfDmn8niRoc=;
        b=a5ju2t/4nHOU5nEcrI65+QzWOU6crA5EBdKI3G/l/upgB/reaEtlAi/v4+LbS8hPso
         8pDE5IpJCVggowauiA0vT/v4VrL6nsfI9HiXEH+UJlT8lbmzsXva69SSqkHcjwym+5wk
         yqWoQuKYtV8KdIzEPlkCkqCTtbE/U/mBOqTk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXzq25JjkHKfqM12yrowm3Yo57M4GMY0BfDmn8niRoc=;
        b=bvYTSHYlqWIsyP58S7mJuLN+L+37gPpM0TqgnzdApakUH7Qeg7sBfixvPJJH9nB2Qe
         8joOZ9ubm3AUyKmnZBsdgX4yl+ngMUwUpGpJFd+EHDZ9bpIWrxiBBXXdEmdbsmJY6N7p
         PwzYAY+AwYwebDNE5P+gxwsmCiqW6SWZQn5YNF1WzU6KkUp2jj+a+XGj3B2k2P5IbIGo
         6fTGEPbImff4fOlwodAbXMDktMmeLD+avEDvv7PVbn3YaqolK5N8J9ct9Ou5hDiBEwmo
         awxLnFgXHvxc2LoqoVgvvRZFBqczwmQEN1gIX4Xu4D/CGvu37F2ANYKsLOzC2vhW2buo
         hnWA==
X-Gm-Message-State: APjAAAVglUTwJG2q7/W3rASWea+F0GwssNOPQ/A9+zxjYUthpINka503
        xlB+0PU/Mq2WNobBPnWAjBLHMtvXt/U=
X-Google-Smtp-Source: APXvYqzDoaOvzY9VkcC1wIAdt9CIpLTH82G/kWYoKf2v28AMTXvl4BAoeBr1S1I013Hb8zvDi0wh7Q==
X-Received: by 2002:a1f:3ad1:: with SMTP id h200mr8995816vka.24.1558378033029;
        Mon, 20 May 2019 11:47:13 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id e62sm10832625vsc.24.2019.05.20.11.47.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 11:47:12 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id p24so4139207vki.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:47:12 -0700 (PDT)
X-Received: by 2002:a1f:1e48:: with SMTP id e69mr8852626vke.16.1558377691267;
 Mon, 20 May 2019 11:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190429204040.18725-1-dianders@chromium.org>
In-Reply-To: <20190429204040.18725-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 11:41:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEDkufoEUYv9U+c+Y_bm8MYEWS25n63vUeNG0LLCFnuw@mail.gmail.com>
Message-ID: <CAD=FV=WEDkufoEUYv9U+c+Y_bm8MYEWS25n63vUeNG0LLCFnuw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Disable SDIO interrupts while suspended
 to fix suspend/resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, stable@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 29, 2019 at 1:41 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Processing SDIO interrupts while dw_mmc is suspended (or partly
> suspended) seems like a bad idea.  We really don't want to be
> processing them until we've gotten ourselves fully powered up.
>
> You might be wondering how it's even possible to become suspended when
> an SDIO interrupt is active.  As can be seen in
> dw_mci_enable_sdio_irq(), we explicitly keep dw_mmc out of runtime
> suspend when the SDIO interrupt is enabled.  ...but even though we
> stop normal runtime suspend transitions when SDIO interrupts are
> enabled, the dw_mci_runtime_suspend() can still get called for a full
> system suspend.
>
> Let's handle all this by explicitly masking SDIO interrupts in the
> suspend call and unmasking them later in the resume call.  To do this
> cleanly I'll keep track of whether the client requested that SDIO
> interrupts be enabled so that we can reliably restore them regardless
> of whether we're masking them for one reason or another.
>
> It should be noted that if dw_mci_enable_sdio_irq() is never called
> (for instance, if we don't have an SDIO card plugged in) that
> "client_sdio_enb" will always be false.  In those cases this patch
> adds a tiny bit of overhead to suspend/resume (a spinlock and a
> read/write of INTMASK) but other than that is a no-op.  The
> SDMMC_INT_SDIO bit should always be clear and clearing it again won't
> hurt.
>
> Without this fix it can be seen that rk3288-veyron Chromebooks with
> Marvell WiFi would sometimes fail to resume WiFi even after picking my
> recent mwifiex patch [1].  Specifically you'd see messages like this:
>   mwifiex_sdio mmc1:0001:1: Firmware wakeup failed
>   mwifiex_sdio mmc1:0001:1: PREP_CMD: FW in reset state
>
> ...and tracing through the resume code in the failing cases showed
> that we were processing a SDIO interrupt really early in the resume
> call.
>
> NOTE: downstream in Chrome OS 3.14 and 3.18 kernels (both of which
> support the Marvell SDIO WiFi card) we had a patch ("CHROMIUM: sdio:
> Defer SDIO interrupt handling until after resume") [2].  Presumably
> this is the same problem that was solved by that patch.
>
> [1] https://lkml.kernel.org/r/20190404040106.40519-1-dianders@chromium.org
> [2] https://crrev.com/c/230765
>
> Cc: <stable@vger.kernel.org> # 4.14.x
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I didn't put any "Fixes" tag here, but presumably this could be
> backported to whichever kernels folks found it useful for.  I have at
> least confirmed that kernels v4.14 and v4.19 (as well as v5.1-rc2)
> show the problem.  It is very easy to pick this to v4.19 and it
> definitely fixes the problem there.
>
> I haven't spent the time to pick this to 4.14 myself, but presumably
> it wouldn't be too hard to backport this as far as v4.13 since that
> contains commit 32dba73772f8 ("mmc: dw_mmc: Convert to use
> MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs").  Prior to that it might
> make sense for anyone experiencing this problem to just pick the old
> CHROMIUM patch to fix them.
>
> Changes in v2:
> - Suggested 4.14+ in the stable tag (Sasha-bot)
> - Extra note that this is a noop on non-SDIO (Shawn / Emil)
> - Make boolean logic cleaner as per https://crrev.com/c/1586207/1
> - Hopefully clear comments as per https://crrev.com/c/1586207/1
>
>  drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++----
>  drivers/mmc/host/dw_mmc.h |  3 +++
>  2 files changed, 26 insertions(+), 4 deletions(-)

Ulf: are you the right person to land this?  With 5.2-rc1 out it might
be a good time for it?  To refresh your memory about this patch:

* Patch v1 was posted back on April 10th [1] so we're at about 1.5
months of time for people to comment about it now.  Should be more
than enough.

* Shawn Lin saw it and didn't hate it.  He had some confusion about
how it worked and I've hopefully alleviated via extra comments / text.

* Emil Renner Berthing thought it caused a regression for him but then
tested further and was convinced that it didn't.  This is extra
confirmation that someone other than me did try the patch and found it
to not break things.  ;-)

* It has been reviewed by Guenter Roeck (in v2)

[1] https://lkml.kernel.org/r/20190410221237.160856-1-dianders@chromium.org


-Doug
