Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB114DFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgA3RJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 12:09:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41341 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3RJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:09:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id c26so4595747eds.8;
        Thu, 30 Jan 2020 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yel/LjQW25KcQEFu+jzZC73Egkh1tqmmLbvqWmoKP8c=;
        b=McU784o+BlKHiU8m5vavNqQyA3oFBpzOf3HlAuCMmdNFGz14lvO6yRPhgp4Ds4XVp6
         xpAvGZTEv5SCKQaFFrYwvi75BMEkZDA8i++ymWsMVkOxfW8HgsbWyQQk17cRno5N8yNy
         +eIYCA09AdUds5GQp5XlCVuz/67NmydI1ExgXMUGQFlMcp5FGKG/ZtrQ/KCpvil1xyVO
         0ksORwuZ0HqRtD5JoqebvM+XYG3wA0+1+jUB9RegC363PKmF5T0++3mtERGo7eQT9ejz
         sToBBqbfHIJj1AGeYQFSLG+RrdNaGhNET4V1YnbxG1yRxsjjVFAvJtCdYFhJBthvZJ94
         0Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yel/LjQW25KcQEFu+jzZC73Egkh1tqmmLbvqWmoKP8c=;
        b=CAa92roEjYmgqg66N4WE3LAaPk5wQY0zB6/F1GK1ZhZk93hgfiB0/r48Sg+CjZu9kZ
         5IdnQfdEccqqr6skQEnxAlmQjxPLa9B4tlWTOONzHSnYhZPFTSc1WfbvqsXDL2FSyhdV
         PI+1V5W4UrXr5UWqg/OcpytpAB4ACGW8R0k/Fg/BD4tvuTEtrud/H0A7IriqqoWmnzYe
         UK6E/zGHLdI36ntO4UCFp5mb/7gzKtn9Fv3Y5y3MVVhxbDEvzL7sCj+J0+9BV8Egct81
         GtjJjxDLDGCMNbvfwzGJSV/rrduElCrSQUhyaxUlTbJwxtAP3/9umR+ZIErMAfTpsA89
         4DFw==
X-Gm-Message-State: APjAAAWPwKA2Oj2RtAP9szB5oWIqonHxiv8B6GptEXqJ2UfPjjZbf3TO
        BGq4dfkkyDcQC9iwuwzDFyI=
X-Google-Smtp-Source: APXvYqwq3GK/kZ6ctkM0oUPdYfKKLpmFsfdQxaEw47STW+5vOHF65mQWT7BC3nPoioz0sKAOgdJxuA==
X-Received: by 2002:a05:6402:168c:: with SMTP id a12mr4871067edv.43.1580404185669;
        Thu, 30 Jan 2020 09:09:45 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u9sm493512edt.91.2020.01.30.09.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 09:09:44 -0800 (PST)
Subject: Re: [PATCH v2 5/9] ASoC: tegra: add Tegra210 based AHUB driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bd802f93-dd03-f39d-86e1-39f8571bbbb0@gmail.com>
Date:   Thu, 30 Jan 2020 20:09:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-6-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      ahub->soc_data->cmpnt_drv,
> +					      ahub->soc_data->dai_drv,
> +					      ahub->soc_data->num_dais);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register component, err: %d\n",
> +			ret);
> +		return ret;
> +	}
In the the patch #4 ("ASoC: tegra: add Tegra210 based I2S driver") I see
the following:

	ret = devm_snd_soc_register_component(dev, &tegra210_i2s_cmpnt,
					tegra210_i2s_dais,
					ARRAY_SIZE(tegra210_i2s_dais));
	if (ret != 0) {
		dev_err(dev, "can't register I2S component, err: %d\n", ret);
		return ret;
	}

Please be consistent in regards to errors checking. The correct variant
should be: if (ret != 0). Usually error codes are a negative value, but
it is much safer to check whether value isn't 0 in all cases where
positive value isn't expected to happen.

I'd also recommend to rename all "ret" variables to "err" everywhere in
the code where returned value is used only for errors checking. This
will make code more explicit, and hence, easier to read and follow.

So, it will be nicer to write it as:

	err = devm_snd_soc_register_component(&pdev->dev,
					ahub->soc_data->cmpnt_drv,
					ahub->soc_data->dai_drv,
					ahub->soc_data->num_dais);
	if (err) {
		dev_err(&pdev->dev, "failed to register component: %d\n", err);
		return err;
	}
