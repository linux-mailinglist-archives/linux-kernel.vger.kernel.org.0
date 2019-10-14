Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF67D65E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 17:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbfJNPJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 11:09:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45753 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732647AbfJNPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:09:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so20117179wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=e/+zgzvz7cdRSfGr8CbomtgDWC7Xf9aC4mhPjEtGzjI=;
        b=PPcP0ZPAsk7CO8rwGRm94KGORWc2VFlrbsiIWKL44xuhF9fnPgHdg4Id/W2Ja4LD7U
         0YUPDhPGflxds0PEAhO1dir8ynybpSVMTvd6FBG0k+xA3/JkNy76rsQmWcwkudCW+JaG
         L2TRa1YZxB18ga5TFK5aij+Bl8WCVr5+tpeN72R/2B/R25B9pec+94NXmBEZs/i18eda
         cOzbcNoo3btYabqNXdl98+qctW8LTmhpk5DDXGL6RYdUeEldltF/nxI19BIfUGKXgFzR
         ZxC2PfuMZtaAAmk+zlLjD1COK8Vxu3ITfp9bXWImewjXaDC6mtfkGVwKHW8MNtH2kFCn
         ftAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=e/+zgzvz7cdRSfGr8CbomtgDWC7Xf9aC4mhPjEtGzjI=;
        b=XBec/KIeDan84fB+7zkSogXFNZNcG8qRO7qFIUryfalbQsvUMdPUuvAse8n5e/0ySA
         +TyOjWdF7PPDEvd8WSJYSk5KDwDd4VFGXG76uxZU+nJsnt09J6lc+b1Me2wpGcViVHn9
         4LfUHHj/+qABAFrlKxzVBmzRpvb136F5Wm8nRePzpv50Pz2DDw54009t7lw5EL/VXcmO
         p03dhWHwwU5qkP+gmbpwWyl5Na9N3mb7KSHYQMEVxfcdZiC2kwnQbDoYEYKzQiCJVseS
         vZ8mnRtAIGHoL5qMOg2xtV//cpyUsTjCzohlzZJP7aypPaBYGREa0qt0zOi41/7NEWIt
         myZA==
X-Gm-Message-State: APjAAAVDoxiTS/2VU2ZbTtlUyHV8MjzO5YeIy1jvaKbV03a3j9HlGwW2
        5h8SkVmVoS4YKDlNiGymEsAg+g==
X-Google-Smtp-Source: APXvYqydjsG8U+zYFq0mECW81Lw/eZ84pU47/75NLBZW1j95nCqUR8IryrSfNyGJASnYpIQfA+BMFw==
X-Received: by 2002:adf:92a5:: with SMTP id 34mr24903377wrn.337.1571065747515;
        Mon, 14 Oct 2019 08:09:07 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a4sm14961234wmm.10.2019.10.14.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 08:09:06 -0700 (PDT)
References: <20191014144316.18696-1-yuehaibing@huawei.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     YueHaibing <yuehaibing@huawei.com>, narmstrong@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: meson: axg-audio: use devm_platform_ioremap_resource() to simplify code
In-reply-to: <20191014144316.18696-1-yuehaibing@huawei.com>
Date:   Mon, 14 Oct 2019 17:09:05 +0200
Message-ID: <1jpniz1i0e.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 14 Oct 2019 at 16:43, YueHaibing <yuehaibing@huawei.com> wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/clk/meson/axg-audio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index 18b23cd..d7d7cff 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -1016,7 +1016,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  	const struct audioclk_data *data;
>  	struct axg_audio_reset_data *rst;
>  	struct regmap *map;
> -	struct resource *res;
>  	void __iomem *regs;
>  	struct clk_hw *hw;
>  	int ret, i;
> @@ -1025,8 +1024,7 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -EINVAL;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	regs = devm_ioremap_resource(dev, res);
> +	regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);

Applied, Thx
