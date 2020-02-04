Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13FF151B22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBDNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 08:21:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36451 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBDNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:21:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so8592198otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVrKWveR9k4x9vzNOToq7s3NXA+2AZmIcAe2EfBCbPo=;
        b=HslvlFCPZGrigaqUOxFHGJ3m8L2hC7oZEYEIGmc+a2wv2zYEqWsPcgP7v18mD1mmWC
         sqf5V8kRsJt6xgkI9iZvwK6uKbx/7LhJDRHcq1wM5IuUdhYo26Ktlm9OuM+IaT80RErU
         ElMRKAwLmXwgXGDNbYsehQ72L/8oDg54W47J8AMT2UG9V/iQlFzK+unxACEMg7X6GoWX
         bV5Oc8mdu9dNz03UJ0TOUIKaTl5dLxnuEBz8bl7qMu+D1BMHVNOoBV6jSNl7bIq8R2C7
         h6PdfYYRsC6VOAt9zjc+/nePqzXagQ8x/f1N5tw06aiV/CCZrgRPPuNPnu2QU7vIrygi
         D/nw==
X-Gm-Message-State: APjAAAWF8SurRpg6cb0YDntRhwEqQwWFxlw7EgOcHwJ9dIfHwsQLJkRf
        1/XC+hgJ8hY0/e51kh7BxXFDbK7beCak3nbIs8k=
X-Google-Smtp-Source: APXvYqw1c/0MBx6lPDtFz9lgiWXHqMXu8272JmBs2BMg2EB4RC2X8iQqu+sRw2BpYMZVaSewmKj+LKnWEmjz+AHpD+I=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr22138743oth.145.1580822472473;
 Tue, 04 Feb 2020 05:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20200204111241.6927-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200204111241.6927-1-srinivas.kandagatla@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Feb 2020 14:21:01 +0100
Message-ID: <CAMuHMdVw0crXH+=7e9GGLUR-c-SxZDz9kQdeWxkZyZ9Jx7CVig@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: wcd934x: Add missing COMMON_CLK dependency
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Tue, Feb 4, 2020 at 12:14 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Looks like some platforms are not yet using COMMON CLK.
>
> PowerPC allyesconfig failed with below error in next
>
> ld: sound/soc/codecs/wcd934x.o:(.toc+0x0):
>          undefined reference to `of_clk_src_simple_get'
> ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
> wcd934x.c:(.text.wcd934x_codec_probe+0x3d4):
>          undefined reference to `.__clk_get_name'
> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438):
>          undefined reference to `.clk_hw_register'
> ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474):
>          undefined reference to `.of_clk_add_provider'
>
> Add the missing COMMON_CLK dependency to fix this errors.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for your patch!

But did this change really fix your PowerPC allyesconfig build?
SND_SOC_ALL_CODECS will still select it...

Fix sent.

Disclaimer: tested with m68k/allmodconfig only ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
