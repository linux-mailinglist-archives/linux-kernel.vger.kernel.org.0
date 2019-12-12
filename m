Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F3911C319
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 03:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLLCRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 21:17:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35884 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfLLCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:17:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so425665ljg.3;
        Wed, 11 Dec 2019 18:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KdekJit4TR3IPCfvOdjWaldHsRv3CP6xyOWik6J728U=;
        b=Gzoy0jSIMfRnlkLFprOT/8bSftgaE1XGMH2S11/bQyAYAgPyGLv7UfA3to2mBC9ahw
         lasT8Xz3//jxRU/sg1UwEqg/4uO/pMXddC8R6YpL2xv3nsNj/3Y2vkY7uXyAsAgJStyQ
         hejzY/DNisbA6BelKCv50AYKV8pkdocUm84rCnjpy/22lN4Bl5cdV0ea7n3hD9dh1gf/
         129rWL67ghxxsR7YAyw5UNsWuHCfbxHZmoweiwrnS20wIiWM5FN6Hnj9bclUIFxemkA9
         DRct4rFSvRA+zbkw7T2j7ectI//ARXOvmkDeG002BMved3WIj+FEXxsUKt0FCxl+J+KN
         LnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KdekJit4TR3IPCfvOdjWaldHsRv3CP6xyOWik6J728U=;
        b=QDwQHfcpAF9FIXvPKhtMLNEc+xYvd3Y9ijVmHDrCZQ8QOYZqQt9E1KhoouyLdoRTfJ
         6K50VjOjbwk6zGh08tw/iS9JI/5H/h9RN42xd9ePVlHpprCge3x03vCrsktUL/6KNREH
         waZ6vRaXh6IHI7J7RMSfqdOixgpw/2h6N4SCeIeAz9Ysx6MPiohyPkvGNI7bY6JFOzbR
         QX58gmosK1qiNR+OPcybFPdcRvLdhHkdq914dVgDqKqAEZttLn6TFZGIUfZvOzpdhMZH
         fm3wUovhRGwW3vzMQMzlys2ozBX9euw0BT3QMvDCtrcUJKaltoUgDKzBHDHrV5lLIk5z
         3xFg==
X-Gm-Message-State: APjAAAXl0rjboEGAF+0Xq/BQkrZ+Ya+lZGwQaV75pN7bP8FzYQm+21mw
        gpX3myxT/ASGnGxONBm+zzs=
X-Google-Smtp-Source: APXvYqxocQ3Qzqf1VktbMSvmfBoQQJvSlcA7ebJXnc2n/qMpwM8OtMrx9qViLmWIbhcJSRtMR7Gk2w==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr3878082ljo.153.1576117032279;
        Wed, 11 Dec 2019 18:17:12 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u21sm2041632ljl.93.2019.12.11.18.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:17:11 -0800 (PST)
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
To:     Mark Brown <broonie@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, allison@lohutok.net,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <20191209164027.GG5483@sirena.org.uk>
 <7fe879fd-dae3-1e64-1031-cd9f00e31552@gmail.com>
 <20191209204735.GK5483@sirena.org.uk>
 <560185d9-32fd-a85e-5feb-105f79b953c6@gmail.com>
 <20191210185933.GJ6110@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17cb9e87-e1bd-93a0-aa9c-0f30c2263ec0@gmail.com>
Date:   Thu, 12 Dec 2019 05:17:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210185933.GJ6110@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.12.2019 21:59, Mark Brown пишет:
> On Tue, Dec 10, 2019 at 09:24:43PM +0300, Dmitry Osipenko wrote:
> 
>> In some cases it could be painful to maintain device-tree compatibility
>> for platforms like NVIDIA Tegra SoCs because hardware wasn't modeled
>> correctly from the start.
> 
>> I agree that people should use relevant device-trees. It's quite a lot
>> of hassle to care about compatibility for platforms that are permanently
>> in a development state. It could be more reasonable to go through the
>> pain if kernel required a full-featured device tree for every SoC from
>> the start.
> 
> We absolutely should support the newer kernel with older device tree
> case, what's less clear to me is the new device tree with old kernel
> which is applying LTS updates case.  That does seem incredibly
> specialist - I'd honestly never heard of people doing that before this
> thread.
> 

There was a precedent in the past [1].

[1] https://lkml.org/lkml/2018/8/20/497
