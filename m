Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED0B47BC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 08:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404392AbfIQGyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 02:54:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37315 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404348AbfIQGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 02:54:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so2265907edy.4;
        Mon, 16 Sep 2019 23:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcIjvbufynPeD91Mg15EYJOqVZcGPs0ArRORK/sU2Is=;
        b=NORm7alJ/NNFYNkVsZw+y+4XhYlOEOShxHvxTJPWgXXUiVyAarBOcAenGtwDXaH2jz
         GdPRxL67K1a5KlTt+a+FCsg7PpXh52KAOTl8xIYKpO58/HRF37EIZberLr+yXRCuaC/z
         HId8brympq/JQFH3C00bulq67OzY3zHaLSeFAr0l+yA5QG6bSAE2vmNSYoHSvLLPOsW7
         1E7jv8IcgNPppX9utxWYtBsWWkYw5388UAe/Hotui9vKINlKh+miLNHaYR5jdl43kGRV
         6v1eLEWlLIxoq212lzEc9thUQ9BTQI1dQpgtmvtdyznHC/gA1w/3IfSK0yutA8vM1wYo
         USoQ==
X-Gm-Message-State: APjAAAXrAa8Ytc+2TYmyAuCuQSIDwXAwl1ulbJ/E5yirWXLeeoPBU4Ci
        5TgVByFJ4epPunPgrB2kWeA5B+MEKTQ=
X-Google-Smtp-Source: APXvYqzLUqfE8YUain5USpHp+Ppmc+vkqA5g9akw1Ro5kQZY2J0pWwc15KMdNJBtIktYxdN+ZbdIQw==
X-Received: by 2002:a17:906:4c4c:: with SMTP id d12mr3351491ejw.174.1568703261676;
        Mon, 16 Sep 2019 23:54:21 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ba28sm261139edb.4.2019.09.16.23.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 23:54:21 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id i16so1833406wmd.3;
        Mon, 16 Sep 2019 23:54:21 -0700 (PDT)
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr2230059wme.51.1568703260882;
 Mon, 16 Sep 2019 23:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190914135100.327412-1-jernej.skrabec@siol.net>
In-Reply-To: <20190914135100.327412-1-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 17 Sep 2019 14:54:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v640R7edA3EJvC=aJQZXGcfqot50O3-PFyrYj767pUEYrQ@mail.gmail.com>
Message-ID: <CAGb2v640R7edA3EJvC=aJQZXGcfqot50O3-PFyrYj767pUEYrQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: h6: Use sigma-delta
 modulation for audio PLL
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 9:51 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Audio devices needs exact clock rates in order to correctly reproduce
> the sound. Until now, only integer factors were used to configure H6
> audio PLL which resulted in inexact rates. Fix that by adding support
> for fractional factors using sigma-delta modulation look-up table. It
> contains values for two most commonly used audio base frequencies.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index d89353a3cdec..ed6338d74474 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -203,12 +203,21 @@ static struct ccu_nkmp pll_hsic_clk = {
>   * hardcode it to match with the clock names.
>   */
>  #define SUN50I_H6_PLL_AUDIO_REG                0x078
> +
> +static struct ccu_sdm_setting pll_audio_sdm_table[] = {
> +       { .rate = 541900800, .pattern = 0xc001288d, .m = 1, .n = 22 },
> +       { .rate = 589824000, .pattern = 0xc00126e9, .m = 1, .n = 24 },
> +};
> +
>  static struct ccu_nm pll_audio_base_clk = {
>         .enable         = BIT(31),
>         .lock           = BIT(28),
>         .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
>         .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
> +       .sdm            = _SUNXI_CCU_SDM(pll_audio_sdm_table,
> +                                        BIT(24), 0x178, BIT(31)),
>         .common         = {
> +               .features       = CCU_FEATURE_SIGMA_DELTA_MOD,
>                 .reg            = 0x078,
>                 .hw.init        = CLK_HW_INIT("pll-audio-base", "osc24M",
>                                               &ccu_nm_ops,
> @@ -753,12 +762,12 @@ static const struct clk_hw *clk_parent_pll_audio[] = {
>  };
>
>  /*
> - * The divider of pll-audio is fixed to 8 now, as pll-audio-4x has a
> - * fixed post-divider 2.
> + * The divider of pll-audio is fixed to 24 for now, so 24576000 and 22579200
> + * rates can be set exactly in conjunction with sigma-delta modulation.
>   */
>  static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
>                             clk_parent_pll_audio,
> -                           8, 1, CLK_SET_RATE_PARENT);
> +                           24, 1, CLK_SET_RATE_PARENT);
>  static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
>                             clk_parent_pll_audio,
>                             4, 1, CLK_SET_RATE_PARENT);

You need to fix the factors for the other two outputs as well, since all
three are derived from pll-audio-base.

ChenYu

> @@ -1215,12 +1224,12 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
>         }
>
>         /*
> -        * Force the post-divider of pll-audio to 8 and the output divider
> -        * of it to 1, to make the clock name represents the real frequency.
> +        * Force the post-divider of pll-audio to 12 and the output divider
> +        * of it to 2, so 24576000 and 22579200 rates can be set exactly.
>          */
>         val = readl(reg + SUN50I_H6_PLL_AUDIO_REG);
>         val &= ~(GENMASK(21, 16) | BIT(0));
> -       writel(val | (7 << 16), reg + SUN50I_H6_PLL_AUDIO_REG);
> +       writel(val | (11 << 16) | BIT(0), reg + SUN50I_H6_PLL_AUDIO_REG);
>
>         /*
>          * First clock parent (osc32K) is unusable for CEC. But since there
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190914135100.327412-1-jernej.skrabec%40siol.net.
