Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC05D8ACC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 04:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHMCgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 22:36:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45589 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHMCgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 22:36:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id t3so11573836ljj.12;
        Mon, 12 Aug 2019 19:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EqaP4DPE6Swxbia9mBuF7NwFDXkyaR3csxZchMYb6NQ=;
        b=HxfDiopB+aMiyI+mRcZ7vOT3qz8bqRREVzU7iiWmfvlqnFQlNWllI3U8WBQuJGX+gb
         l2osfsOcd9Ivl6qIfFPqcvao6X80+3ke2r87apRhMKBW4VYArtu1l/Zt8Mjbw+FQ9GEU
         zBWxbnIUxUBLdeiknP4KPSue+RUi5WpQIgGqSnIUvFx3EFIJSR2YU9vGObWAnxcPQTM5
         PZxvJi14SMD85CkGZbtdG+wRq5zRmkWscpRKhBZ7ea6yVBiU6n8jPzlyAMWcgsfk2YZf
         TR5doalyNK84/PgszjaT2BXBP8BpXs8ybsthmFNSkg6CCqb8KXZiLyw81zl5tDvOEqGM
         mRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EqaP4DPE6Swxbia9mBuF7NwFDXkyaR3csxZchMYb6NQ=;
        b=ERbY0TxZcvUbjWG3loLswBTh83vOuIT4jLy5Uff13qwxva4zbMHVUREROytueOe+XO
         gXbEi/mHoFZoNEq7bPIfPFIdtjjB0GYWNJP+YACN/mZl8kbUTO0/zaZzkK5z31Admky/
         TrPA+Lx1ZohE5oqFaSDerxPMAofCCMsrQOJu/nHkfFLyEy2jNMYF/YOpq9Ctcx9RQKoe
         E752NUdZe1pxw8le1wIh8BMhYUT0G3WvrowVP7RBl1j3OWsDkbC1ng4MfxTMiU9UqahF
         19BbVrS9W2T5iARvCeit7CKEIQLZXvkTc8K7PELg4i38CJ7/MvSv+IPJ2t+/j+IOvKYm
         3eOQ==
X-Gm-Message-State: APjAAAUfvZdin2KkC/11S4AELM04rx8QYzcgQ+4VU5aVSzDj2vh1gs4r
        yWI2CRaGiEYeL7GKfgAoGd3VsbDx
X-Google-Smtp-Source: APXvYqylNi7RD4qkYHcQ30b6C3YKH/am7Ot4EBwZckmxZuv1DhiGhDBaNLGQDG9gLfBYddOs5t5gQg==
X-Received: by 2002:a2e:834e:: with SMTP id l14mr16001349ljh.158.1565663804698;
        Mon, 12 Aug 2019 19:36:44 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id o5sm1351827lji.43.2019.08.12.19.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 19:36:43 -0700 (PDT)
Subject: Re: [PATCH v10 01/15] clk: tegra20/30: Add custom EMC clock
 implementation
To:     =?UTF-8?B?TWljaGHFgsKgTWlyb3PFgmF3?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh-dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190811210043.20122-1-digetx@gmail.com>
 <20190811210043.20122-2-digetx@gmail.com>
 <20190812231258.GA31836@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8369884e-1bd7-063f-e053-5152378078e9@gmail.com>
Date:   Tue, 13 Aug 2019 05:36:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812231258.GA31836@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.08.2019 2:12, Michał Mirosław пишет:
> On Mon, Aug 12, 2019 at 12:00:29AM +0300, Dmitry Osipenko wrote:
>> A proper External Memory Controller clock rounding and parent selection
>> functionality is required by the EMC drivers, it is not available using
>> the generic clock implementation because only the Memory Controller driver
>> is aware of what clock rates are actually available for a particular
>> device. EMC drivers will have to register a Tegra-specific CLK-API
>> callback which will perform rounding of a requested rate. EMC clock users
>> won't be able to request EMC clock by getting -EPROBE_DEFER until EMC
>> driver is probed and the callback is set up.
> [...]
>> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
>> index 4812e45c2214..df966ca06788 100644
>> --- a/drivers/clk/tegra/Makefile
>> +++ b/drivers/clk/tegra/Makefile
>> @@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
>>  obj-y					+= clk-tegra-super-gen4.o
>>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
>> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
>>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
> 
> Doesn't it complain when both CONFIG_ARCH_TEGRA_2x_SOC and
> CONFIG_ARCH_TEGRA_3x_SOC are enabled at the same time?

No, at least not with my toolchain setup. Are you getting some warning?
