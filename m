Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649E614EE85
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgAaOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 09:35:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46819 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:35:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so7930546edi.13;
        Fri, 31 Jan 2020 06:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+L0iX3tm8D59zvK+565nrkVCoUCzYBhBvxeDsG6SUQ=;
        b=Cs92N2ZINKPfHdeM1/OUztTdDDpWztVzBoW2706c9ZZXQKlTL80GOYZkpCIhg0ACCM
         l9PyboELzrezD4mYgUpEPeJ8I2PIQ45lHQK7hKrygZcavIgtNU4N6IBZIGQpo74Tn2dh
         q07QbEG+dZ4ZAZx0NR/NwFuYZTGCTVQ5nMVBJVZykgu2iSPObDKEfJOnvSktDPnNhXDn
         kgH7aZdF3XsjF2YE0/zbYzYpgGxKCmOa0diEogqp5OFU5XQhCOEc2orpom1dRIw8Gn/N
         lLru6xnxOhWRdh2wvOBMTNk5Qie4+WykL2zmrAeGE0BbJ9Q4okZRYK2DGPjq85HCd5zj
         0uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+L0iX3tm8D59zvK+565nrkVCoUCzYBhBvxeDsG6SUQ=;
        b=BQrUxsf0esHazHymeqfJaiBairigc87S42t90mEcmBfxVz3q7hZYPLThXh7GtO/uH5
         H9d5qU19N9P80TwmTIDZOhdYunhirdz2sLJCXLoPWaNA+azanOTfPJv7dxZELoszEj0t
         5asp4uXJB4v8+gUvmHANF+IMMEHKrqYYu78FEsO3Zr7BovIJTR7Y3VHixmBAm3Ggs/Mb
         pF8gjmKctDsPJMfGRP+voojTmbUzTae1+lJ3hXAhovcvyDisG7Jd2zv+FfxFXhnaqr08
         VxG5nYpn+XdME+nFrw56pr2abxeR5yyMghjw1FKYjU28+14NDp8+2dxbBABwcNUYbJ7p
         7h8A==
X-Gm-Message-State: APjAAAXr1o4cRnGzkws1uW51n+MRMNrXCZEseHN/qfMNUi2w2BTY+w7R
        KOblPcfAiZAcUDELcbeTAYs=
X-Google-Smtp-Source: APXvYqyLVYadz3t7QzEt5g6a58I6klmZbuRSMlzUhuJgeiNPSqabB8cXOnMSGi9TKnxJanABOXEh8Q==
X-Received: by 2002:a50:dacd:: with SMTP id s13mr546095edj.194.1580481301293;
        Fri, 31 Jan 2020 06:35:01 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g31sm502417edd.53.2020.01.31.06.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:35:00 -0800 (PST)
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
 <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
 <00ce0f46-4401-c1da-5513-4aa38d224a44@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aeced6f5-cd7d-bc57-ce83-541554a7dd40@gmail.com>
Date:   Fri, 31 Jan 2020 17:34:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <00ce0f46-4401-c1da-5513-4aa38d224a44@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2020 06:12, Sameer Pujar пишет:
> 
> 
> On 1/30/2020 10:55 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 30.01.2020 13:33, Sameer Pujar пишет:
>> ...
>>> +#include <linux/clk.h>
>>> +#include <linux/device.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/regmap.h>
>>> +#include <sound/soc.h>
>>> +#include "tegra210_ahub.h"
>> Nit: I'd separate the per-directory includes with a blank line, like it
>> done by the most of existing drivers, for consistency.
> 
> Hi Dmitry,
> 
> I'd assume these are the only review comments (which includes your other
> replies for v2 5/9) for the series.
> Let me know otherwise.
> 
> It would help me to discuss all the issues at once, finalize changes for
> v3 and so that we can avoid multiple iterations.

Hello Sameer,

I'll take another look at the patches around Monday.

In general, you should wait for a week or two if you're expecting to get
more comments.

There is now more than month for you to finish this series. If you have
any other patches that depend on this series, then you may send them as
RFC and explicitly state that they depend on another series.
