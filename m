Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7815014294B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgATL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 06:26:23 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37349 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgATL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:26:22 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so11348940uah.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMltZyjqEXLKv+701Vx+gjP4V99Edn3VdTw2YKakZQU=;
        b=x9SLfMjB7Joymxy2DJJcHt4fk9IEyF7qN97bzNCYwmpcDBqmg1SdTYWO+kyjnMwaO5
         vlvUyp6xCkzLYG9znKaAlebIE6y7kK9X7Q68jdurP3WSoOblaPzDt5rgUmu/T7GzU//4
         8FYdO/Lp7bFdhVWgWiCt3KdYFvC1hS2HDZQua1Ou3cx8/TA3PD+Pnezep0ywRPTZU5hs
         8dzSXMy9v8ZNvyqKx0oB2Ll+5BGcLziuba5+Fb2Fhvp7gG6F7hP/g4O/lk4gQcQmiuPF
         QIMd9M8CdpLh+4bjIqsnfgmhiGxHi/pBs7PV+EX3YYEbKz8KS4kwmKpoIh7nQqvfEwYr
         IW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMltZyjqEXLKv+701Vx+gjP4V99Edn3VdTw2YKakZQU=;
        b=Fri4qt/gGsVDAEO/45akCYb7rBuE7iqrWls5HVw11SCGkoBWjv6JQCyqNk4IcucJu+
         ljQsCc5ji6bzhQwtrKZqVKwZ1ComC+IHGORMvKh+hgf+2H5K/sEKx+woJ3ix1fvcMTvf
         OWKM+qjHWJFEK7D5MCqq0YVbKNaDeg4spkpVqEKrI+I0xTJpaRoouuTpcinPMx8bBnkf
         kUeHPR57nEcG3LHVHLLBkxsv1NeTfkq0srVyCRKbfYr2Fx3+GtlYqCr1JylTXktuqV4/
         TSTGksLW+wOBYuccFwkAElY/oFbxHdmtAItv91OXoKxkjPC9AAG1MjITLhawsvCQ5klK
         svbA==
X-Gm-Message-State: APjAAAVSaUkhDY45STHh2lgD2MnWqQQetLlR3iI8CFjoAJXAMIOlqiiz
        O34odDglsCAR/CfLKGZiFG8Gf+fH4lVavI0q+DMcvA==
X-Google-Smtp-Source: APXvYqxKOg9xB8XfL4rfLGRcMxbyRFwMSCwEYJNga3Tv3rpmXA1r3UXHbtiJXS2hERZ8PkUrI2DpkswuNuzWn5p+4j4=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr28696691uar.100.1579519581204;
 Mon, 20 Jan 2020 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20200113210706.11972-1-alcooperx@gmail.com>
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:45 +0100
Message-ID: <CAPDyKFr3mrkY5KNO8tnjD1Fuqbbbb_4s6vuJ4cyOrOHM1E5vQg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-brcmstb: Driver updates
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 at 22:07, Al Cooper <alcooperx@gmail.com> wrote:
>
> The latest BRCMSTB SoC's now use a new Arasan controller along
> with a custom Broadcom PHY that supports HS200, HS400, SDR104,
> HS400E-ES and CQE. This series of commits adds support for these
> new features along with a few bug fixes. The 7216 is the first
> SoC to have this new hardware.
>
> Al Cooper (6):
>   dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
>   mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
>   mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
>   mmc: sdhci-brcmstb: Add shutdown callback
>   mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
>   mmc: sdhci-brcmstb: Fix incorrect switch to HS mode
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  41 ++-
>  drivers/mmc/host/Kconfig                      |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c              | 270 +++++++++++++++++-
>  3 files changed, 284 insertions(+), 28 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
