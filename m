Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5247DB08D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 08:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfILGdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 02:33:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfILGdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:33:02 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B23D214AE;
        Thu, 12 Sep 2019 06:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568269981;
        bh=Oo2cjKAiV3rsOkBdBi7Hyx8RM4IQKUDaU+NoHYxtRkY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n3EhKwYt1YNWIMvXgdASxGW0kH4zqKM9HsPNNFPprhlezL2o3C+ijNZ3/0K9N4b+2
         WMu4Il3SdMs9OOtpT7BfWiqnQFMJyXE+RF9a9mUWR6GwYDVvOJWkP55iXzNVs8T8z8
         nwt0Su+QKPMM/BZT48EsD8A6JAuXyYl2lI84TVyE=
Received: by mail-lf1-f41.google.com with SMTP id x80so18371219lff.3;
        Wed, 11 Sep 2019 23:33:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXiJWc5Yc/IlgZmHmP4H9mIwSr2m2iWWUF/TxC7Uhku+WZvpCkE
        oUMZLDjNf7QWuPe4Ck9c5Eyk3uBRj4/WeGQi7Ck=
X-Google-Smtp-Source: APXvYqznuXgFn7odIM98fPDcWkgctFSvzUYGAl/cTNXN/571YUmoELzvTRg1eO9Bthq5P/b24gmtV+lPmP0zKwmTFkg=
X-Received: by 2002:ac2:43b8:: with SMTP id t24mr7676135lfl.24.1568269979189;
 Wed, 11 Sep 2019 23:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190911183632.4317-1-krzk@kernel.org> <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2pBV+fh0rHitZ30Zz61QNRLfNSD-nhnzq4ZtxSh66F1Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 12 Sep 2019 08:32:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
Message-ID: <CAJKOXPcOSvc2DfoN+7Tca=t5dSm3RcKqmm06AfR0PAVBeY=GvQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: dts: exynos: Pull for v5.4
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 11, 2019 at 8:36 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hi,
> >
> > Unfortunately the patches were applied right after closing the linux-next.
>
> Hi Krzysztof,
>
> I took a look at these and am not convinced this is right:
>
> > 1. Fix boot of Exynos7 due to wrong address/size of memory node,
>
> The current state is clearly broken and a fix is needed, but
> I'm not sure this is the right fix. Why do you have 32-bit physical
> addressing on a 64-bit chip? I looked at commit ef72171b3621
> that introduced it, and it seems it would be better to just
> revert back to 64-bit addresses.

We discussed with Marek Szyprowski that either we can go back to
64-bit addressing or stick to 32. There are not known boards with more
than 4 GB of RAM so from this point of view the choice was irrelevant.
At the end of discussion I mentioned to stick with other arm64 boards
(although not all), so revert to have 64 bit address... but Marek
chosen differently. Since you ask, let's go back with revert.

>
> > 2. Move GPU under /soc node,
>
> No problem
>
> > 3. Minor cleanup of #address-cells.
>
> IIRC, an interrupt-controller is required to have a #address-cells
> property, even if that is normally zero. I don't remember the
> details, but the gic binding lists it as mandatory, and I think
> the PCI interrupt-map relies on it. I would just drop this patch.

Indeed, binding requires both address and size cells. I'll drop it.

Best regards,
Krzysztof
