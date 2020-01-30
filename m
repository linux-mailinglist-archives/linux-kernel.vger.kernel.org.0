Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D101114DFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgA3RSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 12:18:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43783 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgA3RSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:18:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so4608111edb.10;
        Thu, 30 Jan 2020 09:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8D3nTAguvIqplzObM8ADcL8DB29MsLu3XHDyWA8ErwI=;
        b=SztIeg2qAmGyys78oPuc0B+llqop2JE4RwZD4idMUu3ObZ/sHCVYDeI7gFc3/gz5gV
         ic14C3DERF+MAayEZxmxpMtYDWBR4anQQ3K3y2+GhoSv7BYa6LLbbzBb+T1cVN2uyrJU
         rPF5XBoqu8s1p57eM+fC2YLfVgR/g27WixvVHVyXgfz+MW42UlXI7FQrvuAxMlrrcLPq
         3qha0jhqqi+i26Y9oUOhw7x+91cj6ornJTwkAVWwSTDkD0YpTosmWdA5iAx8hMB35Dr+
         ytILyALuqH0+Ksv0rvzpRCb1UMyTwRKEMjy55xx7LEE0E5UQCYSP7/mb2dVHcUSsU5H4
         zHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8D3nTAguvIqplzObM8ADcL8DB29MsLu3XHDyWA8ErwI=;
        b=DZrB9UAD+e50yCVJoTgbWbRtQleQTjQ0WSrX8Xghp0U7+k76wPwGbATwXNPKkmn8Jd
         BIvx/I+CE4Q4YbzKrjNcW/z8tW/tlvgoxcEofrSrrbxq6roJKQf0GRJ8oVKKSX3bYWS9
         DLO/Wmk1xWYPJyVjwsBzd7ZHGDmyyBGVxVrUDYoqI6yPEB5a/cjKyDEyOBiKtaLpgkKD
         WsaR6vq0CLoV/V46vyKe8oF20qbxbMEm+tW1B29OWaNJCsaV/N2kw6RPVCuq/Eqz2Bh1
         6cuU931YXXJN8ygmowhh0Ob6Qc8N2SrMnnlxg/3XvmRNwna7eXqrwrjJLd3u26xdvVdj
         rRow==
X-Gm-Message-State: APjAAAU6mcRScBzWZx/ZSCIG26IUcHSdGbkxm6G11PgzdbMHKTyU7Saa
        3fpdFGoBJyyZpnW5vHAc2WY=
X-Google-Smtp-Source: APXvYqyaqSRiJKtRlJIEZRpmEczULCkL7DfyZ6QlrCeACutPmtwyTeL3GSEw2hFOZXNyQmaUKrwA0w==
X-Received: by 2002:a17:906:52cb:: with SMTP id w11mr5230760ejn.59.1580404716284;
        Thu, 30 Jan 2020 09:18:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id x2sm450476edi.95.2020.01.30.09.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 09:18:35 -0800 (PST)
Subject: Re: [PATCH v2 5/9] ASoC: tegra: add Tegra210 based AHUB driver
From:   Dmitry Osipenko <digetx@gmail.com>
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
 <bd802f93-dd03-f39d-86e1-39f8571bbbb0@gmail.com>
Message-ID: <f8c04460-f2ea-3102-4723-a5a75ba535ba@gmail.com>
Date:   Thu, 30 Jan 2020 20:18:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <bd802f93-dd03-f39d-86e1-39f8571bbbb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 20:09, Dmitry Osipenko пишет:
> 30.01.2020 13:33, Sameer Pujar пишет:
> ...
>> +		dev_err(&pdev->dev, "failed to register component, err: %d\n",

> 		dev_err(dev, "can't register I2S component, err: %d\n", ret);


Also, will be nice to have wording of the text messages to be consistent
everywhere.
