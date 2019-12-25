Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAC12A953
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 00:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLYXWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Dec 2019 18:22:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45894 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfLYXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 18:22:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so17362370lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 15:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gy6dk1JceW57KpSGmAR3pzf0NX9lVcNuOQ3hyF1SQQ=;
        b=QftLw47QATwWJrAK1J1ZkIPFgUbtVl/bijGpTQCZQnEbmlyWXU8+Dc1pLgxt2uazqb
         lepCE2/H22kDC4gA4qcIq/QOQoHLvRUlAB3fYrwilQRWmIs66vJLWx54zSUIdxu19VDz
         j0fBs5fg9aUMldgRX4sJosAL9Qiuc50NSjD50AK946tUKOhHZgRUDVOqlYzKAVBKPaR8
         Ku7SJiSO16CJzFdbcsHM4+/oDtfM2KM2QiKT4NXNCgnEE2sOFu63RSajiRinXumBwsA4
         pOlSidyJrjd9yR32tnhj9/F4+0zQ1oxftC0BgCZWFxhe8tsGhnF8NZERs7t3qNXfto2Z
         n6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gy6dk1JceW57KpSGmAR3pzf0NX9lVcNuOQ3hyF1SQQ=;
        b=WlDJWmGrKJD9ecHg/w/5cpOhbMF8XZwrvhbuFHH9lzS9Kz2qL+qHqTXD0PjM/HlXGy
         RgGIucwTRSCk6eMQb2cV1IhmHO0Zh2KQJjCgZzzfsQxo5eNhoQweu+Vvkt60g6GRATE7
         0wYyKmPvDOUomadeGgkMEABcrsU20UCS4iJMfNy6nDVZDxi76OKvIDW9NFBVP6pD5Ifo
         RrSWs7Rs2K6fV34Dr+bs0FU+dYeyLyqtYeKls1qZLLZne12ywy/kYZjVZ/wf+tYECqIv
         2wZub4KdY02a0j8YeN8YNAdaKVSDZsyZu5ObLjqsSy7LBGA+KMb1s+5HuhJFuG9Lvf7c
         dElg==
X-Gm-Message-State: APjAAAWCeZygUgJ53SXY2Gn/B4HcSYM7rb8kXq2hWB+Ks/8X9ss75hzB
        y0oRpagzcbctNkpyO5kCVpYxijoyAre82Mnl+Kg3Hg==
X-Google-Smtp-Source: APXvYqxP+4vajSwjPFxjWCJawxrvcwrC5tMG1NUMTBSdIZQPpZe+BN3HpSqOaj2VfoRuz2wvDvieM3+jXWf32Siik2k=
X-Received: by 2002:a19:2389:: with SMTP id j131mr23035440lfj.86.1577316129048;
 Wed, 25 Dec 2019 15:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20191219202052.19039-1-stephan@gerhold.net>
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Dec 2019 00:21:57 +0100
Message-ID: <CACRpkdaaK27UNxYkGM=LkeMXN+WzsmxvLgEpWdNd5GroA=4jdg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add device tree for Samsung Galaxy S III mini (GT-I8190)
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 9:21 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> This patch series adds initial support for booting mainline on
> the Samsung Galaxy S III mini (GT-I8190), codename: "samsung-golden".
> samsung-golden uses the Ux500 SoC, which has great support in mainline.

I queued all the DTS changes in the linux-stericsson tree and will
send a pull request for it soon-ish!

Thanks for your hard work Stephan!

Yours,
Linus Walleij
