Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CCC341FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfFDIiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 04:38:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41718 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:38:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so4245948lfa.8;
        Tue, 04 Jun 2019 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xato1BCEq26RttB9WJaXFUtXlK3fwUaQ8EgAcw4Cho=;
        b=MAVhVwH78ciKwSHC3g0xK46pwIpBO/YvarferntSMckX4SZAg6i4NDoG5/lfc2VhoV
         /DpUIWBbq/D4ZOwdGuAimakt/PZXXNi1VG4RUg9XxtpXKiKbKTJ111ppTNGPtET+HRXX
         DGKAAE1adMVUU4mv636tphVlJmr5jwJpuZ+0aPgArXmrMpci0YoTjS0KljkrhcleI2X0
         gL08Ws7Y3vC1S3Vs3W6n/Uk6y8jDLWNu+Xgz4mH18yKo24triDZu4aBgTp0dbAcwYF3G
         9w4gAaHvTdfVht5vnJix0f/40ZaWfeVC0bZfOjJ/o0V+58qHTBvFibnH5+FYqf5fL/st
         eTxg==
X-Gm-Message-State: APjAAAWkK+9zzrXtdNO6o/8WHbNILFIMw7OijkIrXYyAnzrNwisMnImN
        EQAx7cISeOxjneMG8JJx4y2WUiK2JZXJ0XOLPQDJ9SFg
X-Google-Smtp-Source: APXvYqwAJFYjHy9+DjuwYCf84eKohc8SU/n6wNSaFtbeG3EPe4LKlZBP1XRpI7lM+egtserIe4Gx1tDStTgF7B2RWvk=
X-Received: by 2002:ac2:5a04:: with SMTP id q4mr15968023lfn.90.1559637501682;
 Tue, 04 Jun 2019 01:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <1559635259-21585-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635259-21585-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:38:10 +0200
Message-ID: <CAMuHMdUXrNYWj8B5nz1nYnYEKoGYB3yMwaGaaqwBwGHYYy9J0g@mail.gmail.com>
Subject: Re: [PATCH] sparc: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:03 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
