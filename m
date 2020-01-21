Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8223144027
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAUPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 10:07:40 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAUPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:07:39 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MlO9r-1jLKJY3Xsj-00llVD for <linux-kernel@vger.kernel.org>; Tue, 21 Jan
 2020 16:07:38 +0100
Received: by mail-qt1-f182.google.com with SMTP id c24so2848443qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:07:37 -0800 (PST)
X-Gm-Message-State: APjAAAUdhKR3zAREvnr3btnlPl6xYWy38eGPeGaP+W7mNY9W/wq3CeFb
        XtxOyeTzPZxJuPeChGDB6RKQO6ob8sQqF0a9oCc=
X-Google-Smtp-Source: APXvYqyEHp6MLSIhx+AyP6DWTxONoADPVbpvbA0alf7+o+m67/7ztosAtihKbjjjrNGU1lvcux9b/MHxUQcqJ2GwsuU=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr4873169qto.304.1579619256732;
 Tue, 21 Jan 2020 07:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
In-Reply-To: <20200121103413.1337-1-geert+renesas@glider.be>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jan 2020 16:07:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3owvM0bQvHkO623FCmwwuxzza0Wx_XyajMWVc5N6n2mQ@mail.gmail.com>
Message-ID: <CAK8P3a3owvM0bQvHkO623FCmwwuxzza0Wx_XyajMWVc5N6n2mQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] ARM: Drop unneeded select of multi-platform
 selected options
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4Rz27zIittWVLufQaHMZyTFgn3FklxpDCbNaz++RssCPtyKWFk8
 HenkMalIUvRXUgY/Ffgj9D7x7zUBB9iIHfGzZ3FFT6IOKSDHlmZQ8s50CXZgV9ow9r/B3zV
 XAwDSfOYRRmum/uGbBqxD9eQFrs29ds07Ilej8G0sSyedH38I/1lCarq9cxQP617yzmIpDS
 hsaUhUO++s6EIek2S2uhA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DPUzvJ3n2Ow=:KPJfTxyMfga4spEsVbG6FU
 wsUb37WMK8Efj4qDpCP/rzJrRv1trIUQxOQsqnhc4lSJE5DYysKcbgzw/QWCX6qqhDZyVg4OG
 8A32KAMef5E+hMIzoBYZPrRe1H3o0F+HlaPwjsmnAxtKZHcOjm5gqJgFIXvohC5VRshquIJPi
 +Xr1uRpyDWZpbs3+RzycG3VghhfdgjFyYlxevbx2qMWW02cV6cslqq5HVpJAV6YYxbWcsDGdv
 g9s/feDBch9L6kch3lkE57u6TeM2K8jI3dTkSIdxmjKpZF+BXqolG7BfJZFptoJ9UMHOg0SiR
 PmwE8QnSJF99mxqWZ3aPEJlXbmdTInxSrjdjNT/zPvImq4B9A/wYYDh+iAUfjwhfJ+nZDZxcU
 2QsjEjkjF+j7NvzewLr4bUT2oEhTSHTGBG/3LhW94TA3gz7pAiCXb6SCjUgcR9nMpNTh267lf
 RkJGWLWuKssSloFOOyY5g6DU3T8BHB2ooJ118CWqzlm1blQ+Uj9cXWerlQVeZqObagiJCA1L0
 gBsspDLmBBlJHBnRYwMJU3EmClAZYTamwoNphKR6CAh7w8azTHZUVVTHpZW0lXWawY7cWXMob
 AkIag+BoCyOztwHEOGEEuxfxTm2w4rkS17GGupcvp3ZZMNaNdmPsic4ARqUPNJC+O6/XDJMgJ
 fUMnbStfecAs/Q+83wDPFWSvJ0T9r6fIbTnPWBoBy5oSSNRd5LoacnEtgFwpxEPfm1+tQZcD3
 TjQ4pEBcXlBQnuVpxzUHrVUSJ/a/XG8onChNmxtcwaIFT5EmK6IGbeGSKpSZB4XON3LCx98rx
 vlVtevRwmyXo/v6Ex4onP4QBif4EMOBftWmWOhqyMmQWWmx6DSmvozRhgvESVVq6hyQoJQ43a
 sY8aHHBPavOrFu1fzVAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:34 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> This patch series drops select statements from the various
> platform-specific Kconfig files, for symbols that are already selected
> by the various multi-platform related config options
> (ARCH_MULTIPLATFORM, ARCH_MULTI_V*, and ARM_SINGLE_ARMV7M).
> This makes it easier to e.g. identify platforms that are not yet part of
> multi-platform builds, but already use some multi-platform features
> (e.g. "COMMON_CLK" is used by multi-platform + s3c24xx).
>
> All patches in this series are independent of each other.
>
> This has been tested by running "make oldconfig" on .config files
> expanded before from all defconfig files, which triggered no changes.

Nice cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>
