Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30A1128FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Dec 2019 22:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLVVOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Dec 2019 16:14:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42685 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLVVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 16:14:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so1517698ljj.9;
        Sun, 22 Dec 2019 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fbgxkqxZRZGd8DOB9hu/z/RaCx8CkruFIfJ3Fbbw1lY=;
        b=FPynqX1811oIsLp7fOYiZV5tcC5RFxxEHtimITxfxIN02I24xJeCy170rKv8nHVKNM
         oVkwduCyBOnITjBtTr1yBpm6lrgi3rZEa9dwoDmJ9zf5nS3cPVg2WOt+qOwjudMFy43t
         MpZtWj27IGb0xzES6WWBnDY88wl0R5KHdzOd0NHKGWyfGeaJSsi3N6XSybnihjfu2IkC
         A6vzoEsrhEX1dWAQgy5BGSkxxHGCTg/SPltBtcmomD4y7jS8/uXWq/k5/GkiN6k5635e
         M/e9OXQzZlkiGE12vFwae/aTJGiUP/1pbhC+Pzi+kQzkDweiGBTiSUQUGKE/SjKhEq2V
         gIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbgxkqxZRZGd8DOB9hu/z/RaCx8CkruFIfJ3Fbbw1lY=;
        b=KkFBiefeFQFjgw3CNhuGR2yYOPByut/heiPq94JkyyHFB3TKQFvNpjoGynO5i0SeAh
         NvBecevbTwSBvKb+YVzQnnHkFk8NKDjesD2H17ZGRyw735aNwOo3RFMO2deJQsIDWLeu
         /E55FVEN2Alk2fRbZzDwN7RR5YDbkZ/NCEw3+nHLaK5og/oMBijxrz4PykfqH3vi5JDJ
         BrBLkDryEz32OI8jhZt4fIonf0WvvWlE/0srhM9INJuYf+S+lFIdv1HNCChSCoSOf+5j
         4g0o2ImiMq/qJS7sGdDD9DC1mom4J6ut3u7H5qvXs0BdgHbELTwfVZ1e7eowRHujMnh0
         FP2w==
X-Gm-Message-State: APjAAAWvIxMh//yTWs1HO+/Jqx7cmRmTShtVDzGnstU0o3Cfnh6JJy9U
        58muWA6+4shheCVMvlxhzEB7Hxad
X-Google-Smtp-Source: APXvYqyb3q70MzxlzFV+kBg53rnskNuvXbHGmn85RlwX2Uv0qSrlsvD1YL+9Y9LGo2jWVXAYi3Jyrw==
X-Received: by 2002:a2e:9013:: with SMTP id h19mr16349627ljg.223.1577049258970;
        Sun, 22 Dec 2019 13:14:18 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s16sm7169538lfc.35.2019.12.22.13.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 13:14:18 -0800 (PST)
Subject: Re: [PATCH v5 11/19] ASoC: tegra: Use device managed resource APIs to
 get the clock
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-12-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2942bf97-cb02-9f5f-8b5e-73bd4f72006a@gmail.com>
Date:   Mon, 23 Dec 2019 00:14:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576880825-15010-12-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2019 01:26, Sowjanya Komatineni пишет:
> tegra_asoc_utils uses clk_get() and clk_put() to get the clock
> and to free them explicitly.
> 
> This patch updates it to use device managed resource API
> devm_clk_get() so the clock will be automatically released and freed
> when the device is unbound and removes tegra_asoc_utils_fini() as
> its no longer needed.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_alc5632.c    |  7 +------
>  sound/soc/tegra/tegra_asoc_utils.c | 34 ++++++----------------------------
>  sound/soc/tegra/tegra_asoc_utils.h |  1 -
>  sound/soc/tegra/tegra_max98090.c   | 22 ++++++----------------
>  sound/soc/tegra/tegra_rt5640.c     | 22 ++++++----------------
>  sound/soc/tegra/tegra_rt5677.c     |  7 +------
>  sound/soc/tegra/tegra_sgtl5000.c   |  7 +------
>  sound/soc/tegra/tegra_wm8753.c     | 22 ++++++----------------
>  sound/soc/tegra/tegra_wm8903.c     | 22 ++++++----------------
>  sound/soc/tegra/tegra_wm9712.c     |  8 ++------
>  sound/soc/tegra/trimslice.c        | 18 ++++--------------
>  11 files changed, 39 insertions(+), 131 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
> index 9e8b1497efd3..50a6d2ff4442 100644
> --- a/sound/soc/tegra/tegra_alc5632.c
> +++ b/sound/soc/tegra/tegra_alc5632.c
> @@ -205,13 +205,11 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
>  	if (ret) {
>  		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
>  			ret);
> -		goto err_fini_utils;
> +		goto err_put_cpu_of_node;
>  	}
>  
>  	return 0;
>  
> -err_fini_utils:
> -	tegra_asoc_utils_fini(&alc5632->util_data);
>  err_put_cpu_of_node:
>  	of_node_put(tegra_alc5632_dai.cpus->of_node);
>  	tegra_alc5632_dai.cpus->of_node = NULL;
> @@ -226,12 +224,9 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
>  static int tegra_alc5632_remove(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card = platform_get_drvdata(pdev);
> -	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(card);
>  
>  	snd_soc_unregister_card(card);
>  
> -	tegra_asoc_utils_fini(&machine->util_data);
> -
>  	of_node_put(tegra_alc5632_dai.cpus->of_node);
>  	tegra_alc5632_dai.cpus->of_node = NULL;
>  	tegra_alc5632_dai.platforms->of_node = NULL;
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 536a578e9512..38535962029c 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -175,52 +175,30 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>  		return -EINVAL;
>  	}
>  
> -	data->clk_pll_a = clk_get(dev, "pll_a");
> +	data->clk_pll_a = devm_clk_get(dev, "pll_a");
>  	if (IS_ERR(data->clk_pll_a)) {
>  		dev_err(data->dev, "Can't retrieve clk pll_a\n");
> -		ret = PTR_ERR(data->clk_pll_a);
> -		goto err;
> +		return PTR_ERR(data->clk_pll_a);
>  	}
>  
> -	data->clk_pll_a_out0 = clk_get(dev, "pll_a_out0");
> +	data->clk_pll_a_out0 = devm_clk_get(dev, "pll_a_out0");
>  	if (IS_ERR(data->clk_pll_a_out0)) {
>  		dev_err(data->dev, "Can't retrieve clk pll_a_out0\n");
> -		ret = PTR_ERR(data->clk_pll_a_out0);
> -		goto err_put_pll_a;
> +		return PTR_ERR(data->clk_pll_a_out0);
>  	}
>  
> -	data->clk_cdev1 = clk_get(dev, "mclk");
> +	data->clk_cdev1 = devm_clk_get(dev, "mclk");
>  	if (IS_ERR(data->clk_cdev1)) {
>  		dev_err(data->dev, "Can't retrieve clk cdev1\n");
> -		ret = PTR_ERR(data->clk_cdev1);
> -		goto err_put_pll_a_out0;
> +		return PTR_ERR(data->clk_cdev1);
>  	}
>  
>  	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> -	if (ret)
> -		goto err_put_cdev1;

Please leave returning 0 in the end, it is much more expressive variant.

	if (ret)
		return ret;

	return 0;

> -	return 0;
> -
