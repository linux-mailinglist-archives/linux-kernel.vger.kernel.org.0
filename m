Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DADE142F18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgATP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 10:58:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35147 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:58:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so29955826edv.2;
        Mon, 20 Jan 2020 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hCx0FkOyPUAD6FImSxkekqB+LP9ak15a5zOVHzRkbmQ=;
        b=fP/G9x+L9PkgABveHZWoY9IaNc5ecTNODt99ULgbvz4WSGj+RnBE9AphLW93GtkZ3F
         1JJaEFbixiJRZPRtcGTck/aS3dEh5qIPQaxMRxB2EgifHFzu9s6KQfhgI9PzfbSboilB
         IXo01B8GkrtVd7FFkOOl3Up1RM4ZRrWx+OJ/9NSKwrc9AngKrSVo/8izMGXL+UvzS3Vd
         8LvD+ure5A3IoxOcaX7RuFrYapJxo/1o86BbhRX+6EtEA167ic6Ecytm9lh9h2EJWyP8
         px4zrGg8O6XS7YbF8EQTkILa04SzPKDDcjT9b8yvTyKs/0yLzcZZ2s/azXsJbH20itbq
         zN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hCx0FkOyPUAD6FImSxkekqB+LP9ak15a5zOVHzRkbmQ=;
        b=NFRZn6ILXyfVszk1r4EXfCzAe1yOtlSwHot9uMUA74Lcq6vvedec9TV+f7q/ajb2tu
         9rocu8kD2JbEsIvw8N4A76Wus0cxDccP8F7979tWnx/b175UuoiUxy1q5HIzQrHe8Y0M
         ZhTbYxzam9sc9lM665As4p/SGr29tW9gE0JC9BtnFILkSecLHddmgm72zZOz88YRwZi6
         7oDB/8z7IODwDhkoWoOWIpmJWurY3D/mKRP75duvRiC7ctriWlj9cLX7odY1AOjbo6pu
         FMeuDqJ3jHG35frrLevx+y7r0AdeC0pbwTeD8ej3r5d84GofJPBX0K/mkuMNSryD8mVu
         kG9w==
X-Gm-Message-State: APjAAAWE0jSGIsYTKbOAtM8Ex1f+lVxjT4SOFMOwTI4lqNj8l8k3To+B
        NPlPGjMHItmAid8AQb/j7IU=
X-Google-Smtp-Source: APXvYqyWbXRB0TX6y0VmIJ7AAivnItgalHZTSGnWc7Y6DX1cBKxWX2c1pdhOcKTxeWIEECp/nlZ/zA==
X-Received: by 2002:a17:906:7006:: with SMTP id n6mr53213ejj.1.1579535893494;
        Mon, 20 Jan 2020 07:58:13 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r9sm1162950ejx.31.2020.01.20.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 07:58:12 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: tegra: add support for CIF
 programming
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-3-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d01ed171-d949-19b2-3390-ee30eada2779@gmail.com>
Date:   Mon, 20 Jan 2020 18:58:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579530198-13431-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sameer,

20.01.2020 17:23, Sameer Pujar пишет:

[snip]

> Tegra30 and Tegra124 have an identical CIF programming helper function.

[snip]

> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT	24
> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US	0x3f
> -#define TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK	(TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_MASK_US << TEGRA124_AUDIOCIF_CTRL_FIFO_THRESHOLD_SHIFT)
> -
> -/* Channel count minus 1 */
> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT	24
> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US	7
> -#define TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK	(TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_MASK_US << TEGRA30_AUDIOCIF_CTRL_AUDIO_CHANNELS_SHIFT)

The AUDIOCIF_CTRL bitfields are not the same on T30 and T124, why are
you claiming that programming is identical? Have you actually tried to
test these patches on T30?
