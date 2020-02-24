Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3A16A4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 12:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBXLOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 06:14:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36822 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgBXLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:14:51 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so8583869oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6J56GZAIisN7s+G2kGZDSpihGRsq1TAS9IAl8pKmY94=;
        b=Z0jP380Lxb0eRiJN5AEV9SSTUKxx1hREr5vNP3OB+wgj+pYvYBya7wCD6B1n3Iyfqk
         NJlqS5wyXs/tqTW8GXMUsZkSwnNz6eipE/QTRM86gG1LqO2TFMtgFbcxLm48hh30Tk0/
         Wacgs88yW5yUl8y91pZljIE6YGOu4GXJOKNo4k7BfkVhWMCgtPB346JwIUReJ+3qXR2l
         qAGaXZoiN/rDZejL1S2m2iua+Mo2aJX1fmD9w1AXdFgaPQcnB2v2hXaCKjbEaHZKxf6t
         WtLJJOKoYg2u8M/ALDjJmBuLUgwBn/jnXBnGb7EpfEod/YH+sKZZnuttOe98CYAPOXNQ
         mCEw==
X-Gm-Message-State: APjAAAV/58Q64LbPpfp7lcJKyvbwo2UsPE9VrECGYsbBT9nfDjyhppnx
        7VVy9JDWJSZWodDOyNH5/18hN3dY+ajgkJ2OPF0=
X-Google-Smtp-Source: APXvYqyJGLntakWARp86s91QH32t/qVwHjeTCsojy/gtzoQLTXH03yoyT3RIy6NniXxO35oP/uCuX+NiSRuYe1mWX5k=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr11814856oif.131.1582542890533;
 Mon, 24 Feb 2020 03:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20180603201202.15468-1-robert.jarzmik@free.fr>
In-Reply-To: <20180603201202.15468-1-robert.jarzmik@free.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Feb 2020 12:14:39 +0100
Message-ID: <CAMuHMdU3uxfBwKd8SkOtZSDV5Ai3CKc3CWRhDy0Cz94T1Hn0iA@mail.gmail.com>
Subject: non-existent SND_SOC_AC97_BUS_NEW (was: Re: [PATCH v9] ASoC: pxa:
 switch to new ac97 bus support)
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Sun, Jun 3, 2018 at 10:12 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Switch to the new ac97 bus support in sound/ac97 instead of the legacy
> snd_ac97 one.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

This is commit 1c8bc7b3de5e76cb ("ASoC: pxa: switch to new ac97 bus
support") in v4.20-rc1 and later.

> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -20,13 +20,12 @@ config SND_MMP_SOC
>
>  config SND_PXA2XX_AC97
>         tristate
> -       select SND_AC97_CODEC
>
>  config SND_PXA2XX_SOC_AC97
>         tristate
> -       select AC97_BUS
> +       select AC97_BUS_NEW
>         select SND_PXA2XX_LIB_AC97
> -       select SND_SOC_AC97_BUS
> +       select SND_SOC_AC97_BUS_NEW

The actual SND_SOC_AC97_BUS_NEW symbol never made it upstream, although
4 of its users did (3 have been removed in commit ea00d95200d02ece
("ASoC: Use imply for SND_SOC_ALL_CODECS")).

The definition seems to have been dropped silently in v4 of the series.
What should the select be replaced with? Or should it just be dropped?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
