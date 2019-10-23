Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07221E1E45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392252AbfJWOgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:36:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38663 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJWOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:36:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so4756803oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 07:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxo/chYm01QC8eTInCjxWj6Txmh3kYU/ouOy2udw44M=;
        b=feAhax+OMofSpcTmlhBg9ZLx11+HHhuubwwMgvidgXbGsMbk5GMLj8BZj5jvqt+9bD
         E9qu7hcychL86lQur6Ad7wY55JQDPtkqxDc9tnUrod56dFnTlBb0aXFDPybUNPgdzZqT
         yX6Bb9F3fOfrOcjDTfKbebz39ckrQ38rEhfIwrQ7S2n2QSXBHP2rVrZ/Q+iaJwYyC/lv
         y+ZjK5Q1LR34Q9Y+Fnx0YzPxrnrTBuRQaasTAH11GfxIotua2qwqemfkNpGA9mlKTD18
         s1RjwV63Qf+YkZQ/tV4ZbLGSGjAwF9+rVd4nMC0e1+IH+Oi9NMRpnoGsaKVgmtf2LMxh
         wxdQ==
X-Gm-Message-State: APjAAAV92LJhgNNT3ZaiDdNCg8L51kS2diQO1RdjQAvCTkK7rgcIgcbv
        Rsz3y+BMqqP3XuGF97yNK3n41SYMXojRhckzJNs=
X-Google-Smtp-Source: APXvYqxDclxiIFroHlO24WZd1qvRSeKC3vh9yrg9lUgtANFtKnt58omlgaU/40OuK3FT1h/IrrwozE4TWGFgB2yxrRY=
X-Received: by 2002:a54:4e89:: with SMTP id c9mr216403oiy.148.1571841378774;
 Wed, 23 Oct 2019 07:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191023135941.15000-1-yuehaibing@huawei.com>
In-Reply-To: <20191023135941.15000-1-yuehaibing@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Oct 2019 16:36:07 +0200
Message-ID: <CAMuHMdV5dBGbB4DCwidpqeFkxtQGzrh=qO8Ph-Se3ZyGnrGpbw@mail.gmail.com>
Subject: Re: [PATCH -next] iommu/ipmmu-vmsa: Remove dev_err() on
 platform_get_irq() failure
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:01 PM YueHaibing <yuehaibing@huawei.com> wrote:
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
