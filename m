Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0412F13DDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 15:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgAPOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 09:40:23 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33942 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:40:23 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so12810771vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLOtx1Cm2kQjqIZAryXlYAwPA/kH+UoHc2cF2Zi/hG4=;
        b=SZhcyTGG7LgbCVPGxPjdGPVv08lKymOWt6837KKCDp+TxAgzrZXQgE1LmFIiupUnf7
         1BsFsxjwlElet9UM98uV2cZCHigpQmncFYFAhzPnssFMpfYslkzWDSdjfD1zrXzkBZyw
         SOnnTZcPA7tgpQBETYzxXa1rSVsWpQ76+knrJ+3jF6SkAYPfynNqtOuegbyhCtDdWk8/
         fR9sm51NjZk5l/9MqcSihxSHpWab5HyxiWSZ6V80138L3yinrN9Pj4Wk/RrArxufZb82
         GFAvPdihk5fXTMzG5QkHVzKzdofdiQym3dcQpyt1H8WG7vIsREQcVnLyuxgx869CyQp8
         obwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLOtx1Cm2kQjqIZAryXlYAwPA/kH+UoHc2cF2Zi/hG4=;
        b=bHIkPfuhEqHj9PE6SUcsk4HBWgXoVPcRDQFD3RLK7CBSif9XNZtYkfW+pauyMk56BU
         ybkoibOwB+BjYINuEYelgggeYWXoOqgUzn8pH36nhf29x75mfeXS3dA2Zx4jIP2oBaVh
         ErhUk4D3K+Ov6DB0bYuNiI3c5WaWTX/Zr0HTv09irKJKBWWKAbNZiTUlMpKbtAWzamsU
         9PX39dc6QegzqRi2NXktpbMd8+btTqFrES0YOp4sZOIq8hqIx4aGhd2uFC197BeiG4Mr
         1XR49gYrTROOK1L7e+QitJc2tCFv6T0EkoeTHv4I5llw6YToouh+ZU0PEeiAiPOdHkpA
         4ELA==
X-Gm-Message-State: APjAAAXKnrXO+N/Xg8tcmVcWdrEhrg9HVerYuEG6sypB1sFJTM1vxb4r
        iRF57aIWMfzDnfm6VG+3WS39nuO51sidNWMtsAVvvw==
X-Google-Smtp-Source: APXvYqyj1RyQ4mHv6sAPKJt/aQxTv2YBBQwx5jDuljMrFdCRef4nwJ3cwMFYoYujq9ZdHOX6GrjmQ5Jm0bASvcwkKXE=
X-Received: by 2002:a67:e9da:: with SMTP id q26mr1749830vso.34.1579185622440;
 Thu, 16 Jan 2020 06:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20200108143301.1929-1-faiz_abbas@ti.com>
In-Reply-To: <20200108143301.1929-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jan 2020 15:39:46 +0100
Message-ID: <CAPDyKFpjFkoSy9qJ0Ehy9eD38HEfdpOjBa+3mj1SnfFKKTeiVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for Am65x controllers
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2020 at 15:31, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following are some fixes for sdhci_am654 driver.
>
> Patch 3 depends on patch 2.
>
> v1 of patch 2 was posted:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=222279
>
> Faiz Abbas (3):
>   mmc: sdhci_am654: Remove Inverted Write Protect flag
>   mmc: sdhci_am654: Reset Command and Data line after tuning
>   mmc: sdhci_am654: Fix Command Queuing in AM65x
>
>  drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
>
> --
> 2.19.2
>

Applied for fixes, thanks!

Kind regards
Uffe
