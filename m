Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B7CEDA86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 09:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDIYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 03:24:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43697 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:24:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so15909587wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HbCKMBfKUr8ei9f80RshE008kEv1rpM+1JLqgt8YSf0=;
        b=dCPds5HB+pwaHxspm3lwvwRTGUvMTV2LRV8fdw8n9+M3eDYr/kb4WY0ssDX19CbaQZ
         aFKXxGJVIYqHNGZOdzC2JXBFgN6PI296B0s7J8pm5W+JfSOTwg8ntyHmeUwZnj3Qe2Sd
         ZhF251l+152eAwojPgjY0E2GgfnmCaZ/yOtdzwJhMflqHtGJbj7+5BDqhzWh2hMV2Rl2
         uPQJl7beR85srn+FIdWvY9DguzLjA2RqjhBwbjCFh5kVGTTxfKTxgKsrLDKy1z7qI6vm
         4vWmqYjOWwZ94dJUPlpqimHrO8FvgwX1psbOC2Xda6OhVDrErWw6O4NYTpUqgTHqR8NP
         SxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HbCKMBfKUr8ei9f80RshE008kEv1rpM+1JLqgt8YSf0=;
        b=HNLPuJYVI+7IH619yd057VjknbJFNMosgby3vN9oNHR98pDZHessvyDa9s1MEvEG8g
         azxh74JCLSKMhpvGR5eZ93BBl9dWw4GTvmO3DhKGBROKOrh39ItSKzLEsloKJGkYcY5C
         I4MjH6EPeUqe+G0WmlRq9GUqx8D3Y449Yj5AtsGHgo0THTl0CGOfEA9xQDNbVM77xEWg
         D8twNUjgJVR3kqSg2kgnO3Mg536IhQxkoQopZEXMS9tcfx6UyEDFgfivXnLyYtOEc/tY
         WWEQMDNyggvJbUVgvr4MaIyjH0aMFgArfWvW62aaUCOacUHlf4CIhrEwYhxv8I69k6Ex
         OVzw==
X-Gm-Message-State: APjAAAVL2zlMG0xS+T7Yz7Ig1DAJzNJfy8hp1vOxp8WHBrX/cshl2mBx
        okhxDpih2yRefynOlhwO3+2vZw==
X-Google-Smtp-Source: APXvYqyaZdMm10JTLwp6Z7FxbUbKxgpuvceoigXFMxHGSlV0Uyc7AXOzHDCyo6MLRVa3WuuPUmZ0pg==
X-Received: by 2002:adf:e78d:: with SMTP id n13mr4902576wrm.59.1572855878844;
        Mon, 04 Nov 2019 00:24:38 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t5sm5059946wro.76.2019.11.04.00.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 00:24:38 -0800 (PST)
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com> <1571382865-41978-4-git-send-email-jian.hu@amlogic.com> <1jsgnmba1a.fsf@starbuckisacylon.baylibre.com> <49b33e94-910b-3fd9-4da1-050742d07e93@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: meson: a1: add support for Amlogic A1 clock driver
In-reply-to: <49b33e94-910b-3fd9-4da1-050742d07e93@amlogic.com>
Date:   Mon, 04 Nov 2019 09:24:37 +0100
Message-ID: <1jblts3v7e.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Oct 2019 at 13:32, Jian Hu <jian.hu@amlogic.com> wrote:

> Hi, Jerome
>
> Thanks for your review
>
> On 2019/10/21 19:41, Jerome Brunet wrote:
>>
>> On Fri 18 Oct 2019 at 09:14, Jian Hu <jian.hu@amlogic.com> wrote:
>>
>>> The Amlogic A1 clock includes three drivers:
>>> peripheral clocks, pll clocks, CPU clocks.
>>> sys pll and CPU clocks will be sent in next patch.
>>>
>>> Unlike the previous series, there is no EE/AO domain
>>> in A1 CLK controllers.
>>>
>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/Kconfig  |   10 +
>>>   drivers/clk/meson/Makefile |    1 +
>>>   drivers/clk/meson/a1-pll.c |  345 +++++++
>>>   drivers/clk/meson/a1-pll.h |   56 ++
>>>   drivers/clk/meson/a1.c     | 2264 +++++++++++++++++++++++++++++++++++=
+++++++++
>>>   drivers/clk/meson/a1.h     |  120 +++
>>>   6 files changed, 2796 insertions(+)
>>>   create mode 100644 drivers/clk/meson/a1-pll.c
>>>   create mode 100644 drivers/clk/meson/a1-pll.h
>>>   create mode 100644 drivers/clk/meson/a1.c
>>>   create mode 100644 drivers/clk/meson/a1.h
>>
>> In the next version, one
> OK, I will send a1 peripheral and pll driver in two patch.
>>
>>>
>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>> index dabeb43..c2809b2 100644
>>> --- a/drivers/clk/meson/Kconfig
>>> +++ b/drivers/clk/meson/Kconfig
>>> @@ -93,6 +93,16 @@ config COMMON_CLK_AXG_AUDIO
>>>   	  Support for the audio clock controller on AmLogic A113D devices,
>>>   	  aka axg, Say Y if you want audio subsystem to work.
>>>   +config COMMON_CLK_A1
>>> +	bool
>>> +	depends on ARCH_MESON
>>> +	select COMMON_CLK_MESON_REGMAP
>>> +	select COMMON_CLK_MESON_DUALDIV
>>> +	select COMMON_CLK_MESON_PLL
>>> +	help
>>> +	  Support for the clock controller on Amlogic A113L device,
>>> +	  aka a1. Say Y if you want peripherals to work.
>>> +
>>>   config COMMON_CLK_G12A
>>>   	bool
>>>   	depends on ARCH_MESON
>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>> index 3939f21..28cbae1 100644
>>> --- a/drivers/clk/meson/Makefile
>>> +++ b/drivers/clk/meson/Makefile
>>> @@ -16,6 +16,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) +=3D vid-p=
ll-div.o
>>>     obj-$(CONFIG_COMMON_CLK_AXG) +=3D axg.o axg-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) +=3D axg-audio.o
>>> +obj-$(CONFIG_COMMON_CLK_A1) +=3D a1-pll.o a1.o
>>
>> So far, all the controller had there own option, I don't see why it
>> should be different here.
>>
> OK, I will add the other option CONFIG_COMMON_CLK_A1_PLL for pll driver
>>>   obj-$(CONFIG_COMMON_CLK_GXBB) +=3D gxbb.o gxbb-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_G12A) +=3D g12a.o g12a-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_MESON8B) +=3D meson8b.o
>>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>>> new file mode 100644
>>> index 0000000..486d964
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/a1-pll.c
>>> @@ -0,0 +1,345 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>> + */
>>> +
>>> +#include <linux/platform_device.h>
>>
>> Hum ... looks like some things are missing here
>>
>> #include <linux/of_device.h>
>> #include <linux/clk-provider.h>
>>
>> ?
> #1
> There is <linux/clk-provider.h> in meson-eeclk.h file,
>
> and for A1 driver(a1.c/a1-pll.c) the head file is not requied.
>
> #2
> For A1 driver, the file "linux/of_device.h" is not required.
> It is required by meson-eeclk.c in fact.

You are using what is provided by these headers directly in this file
If meson-eeclk ever changes, your driver breaks

>>
>>> +#include "clk-pll.h"
>>> +#include "meson-eeclk.h"
>>> +#include "a1-pll.h"
>>
>> Alphanumeric order please
>>
> OK, I will change it in the next version.
>
>>> +
>>> +static struct clk_regmap a1_fixed_pll_dco =3D {
>>> +	.data =3D &(struct meson_clk_pll_data){
>>> +		.en =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>> +			.shift   =3D 28,
>>> +			.width   =3D 1,
>>> +		},
>>> +		.m =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>> +			.shift   =3D 0,
>>> +			.width   =3D 8,
>>> +		},
>>> +		.n =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>> +			.shift   =3D 10,
>>> +			.width   =3D 5,
>>> +		},
>>> +		.frac =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL1,
>>> +			.shift   =3D 0,
>>> +			.width   =3D 19,
>>> +		},
>>> +		.l =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>> +			.shift   =3D 31,
>>> +			.width   =3D 1,
>>> +		},
>>> +		.rst =3D {
>>> +			.reg_off =3D ANACTRL_FIXPLL_CTRL0,
>>> +			.shift   =3D 29,
>>> +			.width   =3D 1,
>>> +		},
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fixed_pll_dco",
>>> +		.ops =3D &meson_clk_pll_ro_ops,
>>> +		.parent_data =3D &(const struct clk_parent_data){
>>> +			.fw_name =3D "xtal_fixpll",
>>> +			.name =3D "xtal_fixpll",
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_fixed_pll =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D ANACTRL_FIXPLL_CTRL0,
>>> +		.bit_idx =3D 20,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "fixed_pll",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fixed_pll_dco.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * This clock is fclk_div2/3/4's parent,
>>> +		 * However, fclk_div2/3/5 feeds AXI/APB/DDR.
>>
>> is it fclk_div2/3/4 or fclk_div2/3/5 ?
>>
>>> +		 * It is required by the platform to operate correctly.
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>
>> Don't blindly copy/paste comments from other drivers. There is no driver
>> for the devices you are mentionning so the end of the comment is
>> confusing. The 3 first lines were enough
>>
> OK, I will remove the confusing comments
>
>>> +		.flags =3D CLK_IS_CRITICAL,
>>
>>>From your comment, I understand that some child are critical, not this
>> particular (or at least, not directly). So this can be removed AFAICT
>>
>> You should even need CLK_IGNORE_UNUSED for this one since the clock will
>> already be enabled before the late_init() kicks in
>>
> OK, I will replace it as CLK_IGNORE_UNUSED.
>>> +	},
>>> +};
>>> +
>>> +static const struct pll_mult_range a1_hifi_pll_mult_range =3D {
>>> +	.min =3D 32,
>>> +	.max =3D 64,
>>> +};
>>> +
>>> +static const struct reg_sequence a1_hifi_init_regs[] =3D {
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL1, .def =3D 0x01800000 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001100 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL3, .def =3D 0x100a1100 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL4, .def =3D 0x00302000 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x01f18440 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x11f18440, .delay_us =3D =
10 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL0, .def =3D 0x15f18440, .delay_us =3D =
40 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001140 },
>>> +	{ .reg =3D ANACTRL_HIFIPLL_CTRL2, .def =3D 0x00001100 },
>>> +};
>>> +
>>> +static struct clk_regmap a1_hifi_pll =3D {
>>> +	.data =3D &(struct meson_clk_pll_data){
>>> +		.en =3D {
>>> +			.reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>> +			.shift   =3D 28,
>>> +			.width   =3D 1,
>>> +		},
>>> +		.m =3D {
>>> +			.reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>> +			.shift   =3D 0,
>>> +			.width   =3D 8,
>>> +		},
>>> +		.n =3D {
>>> +			.reg_off =3D ANACTRL_HIFIPLL_CTRL0,
>>> +			.shift   =3D 10,
>>> +			.width   =3D 5,
>>> +		},
>>> +		.frac =3D {
>>> +			.reg_off =3D ANACTRL_HIFIPLL_CTRL1,
>>> +			.shift   =3D 0,
>>> +			.width   =3D 19,
>>> +		},
>>> +		.l =3D {
>>> +			.reg_off =3D ANACTRL_HIFIPLL_STS,
>>> +			.shift   =3D 31,
>>> +			.width   =3D 1,
>>> +		},
>>> +		.range =3D &a1_hifi_pll_mult_range,
>>> +		.init_regs =3D a1_hifi_init_regs,
>>> +		.init_count =3D ARRAY_SIZE(a1_hifi_init_regs),
>>> +		.strict_sequence =3D true,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "hifi_pll",
>>> +		.ops =3D &meson_clk_pll_ops,
>>> +		.parent_data =3D &(const struct clk_parent_data){
>>> +			.fw_name =3D "xtal_fixpll",
>>> +			.name =3D "xtal_fixpll",
>>
>> Both should provided when a controller transition from the old way of
>> describing parent to the new way. This is a new controller so it does
>> not apply.
> I do not understand why it does not apply, could you explain more?

Your driver is new, it is not something old transitioning from global
name to clock in DT !

>
> The xtal_fixpll clock is registered in another peripheral driver, If do n=
ot
> desribe the "name" member in parent_data, "fw_name" does not work because
> it has not been registered. the hifi_pll parent will be null in
> /sys/kernel/debug/clk/hifi_pll/clk_parent.
>
> HIFI PLL will be a orphan clock, but its parent should be xtal_fixpll.

There will be an orphan yes, temporarily, until both controllers are up.
Once both controller are up, the clock will be reparented if necessary.

>
> So both of "fw_name" of "name" should be described.

No

>
>>
>> Same for the other occurences.
>>
>> Also, I think you meant xtal_hifipll
> Yes,I will correct it.
>>
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_fixed_factor a1_fclk_div2_div =3D {
>>> +	.mult =3D 1,
>>> +	.div =3D 2,
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div2_div",
>>> +		.ops =3D &clk_fixed_factor_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fixed_pll.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_fclk_div2 =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D ANACTRL_FIXPLL_CTRL0,
>>> +		.bit_idx =3D 21,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div2",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fclk_div2_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * This clock is used by DDR clock in BL2 firmware
>>> +		 * and is required by the platform to operate correctly.
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>> +		.flags =3D CLK_IS_CRITICAL,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_fixed_factor a1_fclk_div3_div =3D {
>>> +	.mult =3D 1,
>>> +	.div =3D 3,
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div3_div",
>>> +		.ops =3D &clk_fixed_factor_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fixed_pll.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_fclk_div3 =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D ANACTRL_FIXPLL_CTRL0,
>>> +		.bit_idx =3D 22,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div3",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fclk_div3_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * This clock is used by APB bus which setted in Romcode
>>> +		 * and is required by the platform to operate correctly.
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>> +		.flags =3D CLK_IS_CRITICAL,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_fixed_factor a1_fclk_div5_div =3D {
>>> +	.mult =3D 1,
>>> +	.div =3D 5,
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div5_div",
>>> +		.ops =3D &clk_fixed_factor_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fixed_pll.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_fclk_div5 =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D ANACTRL_FIXPLL_CTRL0,
>>> +		.bit_idx =3D 23,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div5",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fclk_div5_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * This clock is used by AXI bus which setted in Romcode
>>> +		 * and is required by the platform to operate correctly.
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>> +		.flags =3D CLK_IS_CRITICAL,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_fixed_factor a1_fclk_div7_div =3D {
>>> +	.mult =3D 1,
>>> +	.div =3D 7,
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div7_div",
>>> +		.ops =3D &clk_fixed_factor_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fixed_pll.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_fclk_div7 =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D ANACTRL_FIXPLL_CTRL0,
>>> +		.bit_idx =3D 24,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "fclk_div7",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_fclk_div7_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>>> +/* Array of all clocks provided by this provider */
>>> +static struct clk_hw_onecell_data a1_pll_hw_onecell_data =3D {
>>> +	.hws =3D {
>>> +		[CLKID_FIXED_PLL_DCO]		=3D &a1_fixed_pll_dco.hw,
>>> +		[CLKID_FIXED_PLL]		=3D &a1_fixed_pll.hw,
>>> +		[CLKID_HIFI_PLL]		=3D &a1_hifi_pll.hw,
>>> +		[CLKID_FCLK_DIV2]		=3D &a1_fclk_div2.hw,
>>> +		[CLKID_FCLK_DIV3]		=3D &a1_fclk_div3.hw,
>>> +		[CLKID_FCLK_DIV5]		=3D &a1_fclk_div5.hw,
>>> +		[CLKID_FCLK_DIV7]		=3D &a1_fclk_div7.hw,
>>> +		[CLKID_FCLK_DIV2_DIV]		=3D &a1_fclk_div2_div.hw,
>>> +		[CLKID_FCLK_DIV3_DIV]		=3D &a1_fclk_div3_div.hw,
>>> +		[CLKID_FCLK_DIV5_DIV]		=3D &a1_fclk_div5_div.hw,
>>> +		[CLKID_FCLK_DIV7_DIV]		=3D &a1_fclk_div7_div.hw,
>>> +		[NR_PLL_CLKS]			=3D NULL,
>>> +	},
>>> +	.num =3D NR_PLL_CLKS,
>>> +};
>>> +
>>> +static struct clk_regmap *const a1_pll_regmaps[] =3D {
>>> +	&a1_fixed_pll_dco,
>>> +	&a1_fixed_pll,
>>> +	&a1_hifi_pll,
>>> +	&a1_fclk_div2,
>>> +	&a1_fclk_div3,
>>> +	&a1_fclk_div5,
>>> +	&a1_fclk_div7,
>>> +};
>>> +
>>> +static int meson_a1_pll_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret =3D meson_eeclkc_probe(pdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>
>> This function is useless.
>>
> OK, I will use meson_eeclkc_probe derectly.
>>> +
>>> +static const struct meson_eeclkc_data a1_pll_data =3D {
>>> +		.regmap_clks =3D a1_pll_regmaps,
>>> +		.regmap_clk_num =3D ARRAY_SIZE(a1_pll_regmaps),
>>> +		.hw_onecell_data =3D &a1_pll_hw_onecell_data,
>>> +};
>>> +static const struct of_device_id clkc_match_table[] =3D {
>>> +	{
>>> +		.compatible =3D "amlogic,a1-pll-clkc",
>>> +		.data =3D &a1_pll_data
>>> +	},
>>> +	{ /* sentinel */ }
>>
>> Nitpick: don't need to write this, just write the line like this
>>
> OK, remove it.
>> ' }, {}'
>>
>>> +};
>>> +
>>> +static struct platform_driver a1_driver =3D {
>>> +	.probe		=3D meson_a1_pll_probe,
>>> +	.driver		=3D {
>>> +		.name	=3D "a1-pll-clkc",
>>> +		.of_match_table =3D clkc_match_table,
>>> +	},
>>> +};
>>> +
>>> +builtin_platform_driver(a1_driver);
>>> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
>>> new file mode 100644
>>> index 0000000..99ee2a9
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/a1-pll.h
>>> @@ -0,0 +1,56 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> +/*
>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __A1_PLL_H
>>> +#define __A1_PLL_H
>>> +
>>> +/* PLL register offset */
>>> +#define ANACTRL_FIXPLL_CTRL0		0x80
>>> +#define ANACTRL_FIXPLL_CTRL1		0x84
>>> +#define ANACTRL_FIXPLL_CTRL2		0x88
>>> +#define ANACTRL_FIXPLL_CTRL3		0x8c
>>> +#define ANACTRL_FIXPLL_CTRL4		0x90
>>> +#define ANACTRL_FIXPLL_STS		0x94
>>> +#define ANACTRL_SYSPLL_CTRL0		0x100
>>> +#define ANACTRL_SYSPLL_CTRL1		0x104
>>> +#define ANACTRL_SYSPLL_CTRL2		0x108
>>> +#define ANACTRL_SYSPLL_CTRL3		0x10c
>>> +#define ANACTRL_SYSPLL_CTRL4		0x110
>>> +#define ANACTRL_SYSPLL_STS		0x114
>>> +#define ANACTRL_HIFIPLL_CTRL0		0x140
>>> +#define ANACTRL_HIFIPLL_CTRL1		0x144
>>> +#define ANACTRL_HIFIPLL_CTRL2		0x148
>>> +#define ANACTRL_HIFIPLL_CTRL3		0x14c
>>> +#define ANACTRL_HIFIPLL_CTRL4		0x150
>>> +#define ANACTRL_HIFIPLL_STS		0x154
>>> +#define ANACTRL_AUDDDS_CTRL0		0x180
>>> +#define ANACTRL_AUDDDS_CTRL1		0x184
>>> +#define ANACTRL_AUDDDS_CTRL2		0x188
>>> +#define ANACTRL_AUDDDS_CTRL3		0x18c
>>> +#define ANACTRL_AUDDDS_CTRL4		0x190
>>> +#define ANACTRL_AUDDDS_STS		0x194
>>> +#define ANACTRL_MISCTOP_CTRL0		0x1c0
>>> +#define ANACTRL_POR_CNTL		0x208
>>> +
>>> +/*
>>> + * CLKID index values
>>> + *
>>> + * These indices are entirely contrived and do not map onto the hardwa=
re.
>>> + * It has now been decided to expose everything by default in the DT h=
eader:
>>> + * include/dt-bindings/clock/a1-pll-clkc.h. Only the clocks ids we don=
't want
>>> + * to expose, such as the internal muxes and dividers of composite clo=
cks,
>>> + * will remain defined here.
>>> + */
>>> +#define CLKID_FIXED_PLL_DCO		0
>>> +#define CLKID_FCLK_DIV2_DIV		2
>>> +#define CLKID_FCLK_DIV3_DIV		3
>>> +#define CLKID_FCLK_DIV5_DIV		4
>>> +#define CLKID_FCLK_DIV7_DIV		5
>>> +#define NR_PLL_CLKS			11
>>> +
>>> +/* include the CLKIDs that have been made part of the DT binding */
>>> +#include <dt-bindings/clock/a1-pll-clkc.h>
>>> +
>>> +#endif /* __A1_PLL_H */
>>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>>> new file mode 100644
>>> index 0000000..86a4733
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/a1.c
>>> @@ -0,0 +1,2264 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>> + * Author: Jian Hu <jian.hu@amlogic.com>
>>> + */
>>> +
>>> +#include <linux/platform_device.h>
>>> +#include "clk-pll.h"
>>> +#include "clk-dualdiv.h"
>>> +#include "meson-eeclk.h"
>>> +#include "a1.h"
>>
>> Same as above
> OK, I will change the order.
> In fact, the clk-pll.h is not used in the current driver.
> I will remove it.
>>
>>> +
>>> +/* PLLs clock in gates, its parent is xtal */
>>> +static struct clk_regmap a1_xtal_clktree =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D SYS_OSCIN_CTRL,
>>> +		.bit_idx =3D 0,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "xtal_clktree",
>>> +		.ops =3D &clk_regmap_gate_ro_ops,
>>> +		.parent_data =3D &(const struct clk_parent_data) {
>>> +			.fw_name =3D "xtal",
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * switch for xtal clock
>>> +		 * Linux should not change it at runtime
>>> +		 */
>>
>> Comment not useful: it uses the Ro ops
>>
> OK,  remove the comments
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_xtal_fixpll =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D SYS_OSCIN_CTRL,
>>> +		.bit_idx =3D 1,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "xtal_fixpll",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_data =3D &(const struct clk_parent_data) {
>>> +			.fw_name =3D "xtal",
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_IS_CRITICAL,
>>> +		/*
>>> +		 * it feeds DDR,AXI,APB bus
>>> +		 * Linux should not change it at runtime
>>> +		 */
>>
>> Again, the child are critical, not directly this clock from your
>> comment.
>>
>> Remove CRITICAL, put RO is linux is not supposed to touch it.
>>
> repace as clk_regmap_gate_ro_ops
>>> +	},
>>> +};
>>> +
>
> [ ... ]
>
>>> +
>>> +/* dsp a clk */
>>> +static u32 mux_table_dsp_ab[] =3D { 0, 1, 2, 3, 4, 7 };
>>> +static const struct clk_parent_data dsp_ab_clk_parent_data[] =3D {
>>> +	{ .fw_name =3D "xtal", },
>>> +	{ .fw_name =3D "fclk_div2", },
>>> +	{ .fw_name =3D "fclk_div3", },
>>> +	{ .fw_name =3D "fclk_div5", },
>>> +	{ .fw_name =3D "hifi_pll", },
>>> +	{ .hw =3D &a1_rtc_clk.hw },
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_a_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.mask =3D 0x7,
>>> +		.shift =3D 10,
>>> +		.table =3D mux_table_dsp_ab,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspa_a_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D dsp_ab_clk_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(dsp_ab_clk_parent_data),
>>
>> .flags =3D CLK_SET_RATE_PARENT ?
> Yes, I miss the flag.
>>
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_a_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.shift =3D 0,
>>> +		.width =3D 10,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspa_a_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_a_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_a =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.bit_idx =3D 13,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspa_a",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_a_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_b_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.mask =3D 0x7,
>>> +		.shift =3D 26,
>>> +		.table =3D mux_table_dsp_ab,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspa_b_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D dsp_ab_clk_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(dsp_ab_clk_parent_data),
>>
>> .flags =3D CLK_SET_RATE_PARENT ?
>>
> Yes, I will add it.
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_b_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.shift =3D 16,
>>> +		.width =3D 10,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspa_b_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_b_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_b =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.bit_idx =3D 29,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspa_b",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_b_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPA_CLK_CTRL0,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 15,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspa_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D (const struct clk_parent_data []) {
>>> +			{ .hw =3D &a1_dspa_a.hw },
>>> +			{ .hw =3D &a1_dspa_b.hw },
>>> +		},
>>> +		.num_parents =3D 2,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_en_dspa =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPA_CLK_EN,
>>> +		.bit_idx =3D 1,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspa_en_dspa",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>
>> Why do you need CLK_IGNORE_UNUSED ?
>>
> I should remove it
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspa_en_nic =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPA_CLK_EN,
>>> +		.bit_idx =3D 0,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspa_en_nic",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspa_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>
>> Why do you need CLK_IGNORE_UNUSED ?
>>
> I should remove it
>>> +	},
>>> +};
>>> +
>>
>> Same question and remarks applies to DSP B
>>
> got it
>>> +/* dsp b clk */
>>> +static struct clk_regmap a1_dspb_a_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.mask =3D 0x7,
>>> +		.shift =3D 10,
>>> +		.table =3D mux_table_dsp_ab,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspb_a_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D dsp_ab_clk_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(dsp_ab_clk_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_a_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.shift =3D 0,
>>> +		.width =3D 10,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspb_a_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_a_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_a =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.bit_idx =3D 13,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspb_a",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_a_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_b_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.mask =3D 0x7,
>>> +		.shift =3D 26,
>>> +		.table =3D mux_table_dsp_ab,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspb_b_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D dsp_ab_clk_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(dsp_ab_clk_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_b_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.shift =3D 16,
>>> +		.width =3D 10,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspb_b_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_b_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_b =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.bit_idx =3D 29,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspb_b",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_b_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DSPB_CLK_CTRL0,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 15,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dspb_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_a.hw, &a1_dspb_b.hw,
>>> +		},
>>> +		.num_parents =3D 2,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_en_dspb =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPB_CLK_EN,
>>> +		.bit_idx =3D 1,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspb_en_dspb",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dspb_en_nic =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DSPB_CLK_EN,
>>> +		.bit_idx =3D 0,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dspb_en_nic",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dspb_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>> +	},
>>> +};
>>> +
>>> +/* 12M/24M clock */
>>> +static struct clk_regmap a1_24m =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D CLK12_24_CTRL,
>>> +		.bit_idx =3D 11,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "24m",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_data =3D &(const struct clk_parent_data) {
>>> +			.fw_name =3D "xtal",
>>> +		},
>>> +		.num_parents =3D 1,
>>> +	},
>>> +};
>>> +
>
> [ ... ]
>
>>> +static struct clk_regmap a1_saradc_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D SAR_ADC_CLK_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 9,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "saradc_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D (const struct clk_parent_data []) {
>>> +			{ .fw_name =3D "xtal", },
>>> +			{ .hw =3D &a1_sys_clk.hw, },
>>> +		},
>>> +		.num_parents =3D 2,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_saradc_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D SAR_ADC_CLK_CTRL,
>>> +		.shift =3D 0,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "saradc_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_saradc_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_saradc_clk =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D SAR_ADC_CLK_CTRL,
>>> +		.bit_idx =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "saradc_clk",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_saradc_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +/* pwm a/b/c/d parent data */
>>> +static const struct clk_parent_data pwm_parent_data[] =3D {
>>> +	{ .fw_name =3D "xtal", },
>>> +	{ .hw =3D &a1_sys_clk.hw },
>>> +};
>>
>> Looks like the same as SAR ADC
>>
> OK, I will describe it like SAR ADC for pwm a/b/c/d
>>> +
>>> +/* pwm a clk */
>>> +static struct clk_regmap a1_pwm_a_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 9,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_a_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_a_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.shift =3D 0,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_a_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_a_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_a =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.bit_idx =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_a",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_a_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * The CPU working voltage is controlled by pwm_a
>>> +		 * in BL2 firmware. add the CLK_IGNORE_UNUSED flag
>>> +		 * to avoid changing at runtime.
>>                                      ^ it
>>
>>> +		 * and is required by the platform to operate correctly.
>>                     "blabla. And" is strange
>>
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>
>> This only skips the late_init() disable of unused clocks
>>
>> Be aware that this is not fool-proof. If at any time a driver enable
>> then disable the clock, the clock will be disable and I guess your
>> platform will die if this provides the CPU voltage.
> OK, CLK_IS_CRITICAL is better.
>>
>>> +	},
>>> +};
>>> +
>>> +/* pwm b clk */
>>> +static struct clk_regmap a1_pwm_b_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 25,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_b_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_b_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.shift =3D 16,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_b_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_b_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_b =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_AB_CTRL,
>>> +		.bit_idx =3D 24,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_b",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_b_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +/* pwm c clk */
>>> +static struct clk_regmap a1_pwm_c_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 9,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_c_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_c_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.shift =3D 0,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_c_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_c_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_c =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.bit_idx =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_c",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_c_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +/* pwm d clk */
>>> +static struct clk_regmap a1_pwm_d_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 25,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_d_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_d_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.shift =3D 16,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_d_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_d_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_d =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_CD_CTRL,
>>> +		.bit_idx =3D 24,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_d",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_d_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static const struct clk_parent_data pwm_ef_parent_data[] =3D {
>>> +	{ .fw_name =3D "xtal", },
>>> +	{ .hw =3D &a1_sys_clk.hw },
>>> +	{ .fw_name =3D "fclk_div5", },
>>> +	{ .hw =3D &a1_rtc_clk.hw },
>>> +};
>>> +
>>> +/* pwm e clk */
>>> +static struct clk_regmap a1_pwm_e_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.mask =3D 0x3,
>>> +		.shift =3D 9,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_e_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_ef_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_ef_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_e_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.shift =3D 0,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_e_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_e_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_e =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.bit_idx =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_e",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_e_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +/* pwm f clk */
>>> +static struct clk_regmap a1_pwm_f_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.mask =3D 0x3,
>>> +		.shift =3D 25,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_f_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D pwm_ef_parent_data,
>>> +		.num_parents =3D ARRAY_SIZE(pwm_ef_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_f_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.shift =3D 16,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "pwm_f_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_f_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_pwm_f =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D PWM_CLK_EF_CTRL,
>>> +		.bit_idx =3D 24,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "pwm_f",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_pwm_f_div.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>
> [ ... ]
>
>>> +
>>> +/* dmc clk */
>>> +static struct clk_regmap a1_dmc_sel =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DMC_CLK_CTRL,
>>> +		.mask =3D 0x3,
>>> +		.shift =3D 9,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dmc_sel",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D sd_emmc_parents,
>>> +		.num_parents =3D 4,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dmc_div =3D {
>>> +	.data =3D &(struct clk_regmap_div_data){
>>> +		.offset =3D DMC_CLK_CTRL,
>>> +		.shift =3D 0,
>>> +		.width =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dmc_div",
>>> +		.ops =3D &clk_regmap_divider_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dmc_sel.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dmc_sel2 =3D {
>>> +	.data =3D &(struct clk_regmap_mux_data){
>>> +		.offset =3D DMC_CLK_CTRL,
>>> +		.mask =3D 0x1,
>>> +		.shift =3D 15,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data){
>>> +		.name =3D "dmc_sel2",
>>> +		.ops =3D &clk_regmap_mux_ops,
>>> +		.parent_data =3D (const struct clk_parent_data []) {
>>> +			{ .hw =3D &a1_dmc_div.hw },
>>> +			{ .fw_name =3D "xtal", },
>>> +		},
>>> +		.num_parents =3D 2,
>>> +		.flags =3D CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap a1_dmc =3D {
>>> +	.data =3D &(struct clk_regmap_gate_data){
>>> +		.offset =3D DMC_CLK_CTRL,
>>> +		.bit_idx =3D 8,
>>> +	},
>>> +	.hw.init =3D &(struct clk_init_data) {
>>> +		.name =3D "dmc",
>>> +		.ops =3D &clk_regmap_gate_ops,
>>> +		.parent_hws =3D (const struct clk_hw *[]) {
>>> +			&a1_dmc_sel2.hw
>>> +		},
>>> +		.num_parents =3D 1,
>>> +		/*
>>> +		 * This clock is used by DDR clock which setted in BL2
>>> +		 * and is required by the platform to operate correctly.
>>> +		 * Until the following condition are met, we need this clock to
>>> +		 * be marked as critical:
>>> +		 * a) Mark the clock used by a firmware resource, if possible
>>> +		 * b) CCF has a clock hand-off mechanism to make the sure the
>>> +		 *    clock stays on until the proper driver comes along
>>> +		 */
>>> +		.flags =3D CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>> +	},
>>> +};
>>
>> Should you put all this DMC stuff in RO until you got a driver for it ?
> OK, replace as clk_regmap_gate_ro_ops
>>
> [ ... ]
>>> +
>>> +static int meson_a1_periphs_probe(struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret =3D meson_eeclkc_probe(pdev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>
>> Again this function is function is useless and it makes me wonder if you
>> should really be using meson_eeclkc_probe()
>>
>> This makes you use syscon which is not correct unless you have a good
>> reason ?
>>
> If it can not use the meson_eeclkc_probe(), I will realize a probe functi=
on
> which is mostly duplicate with meson_eeclkc_probe() except
> "syscon_node_to_regmap"
>
> Maybe another common probe function and a new file are required for A1
> three drivers? =EF=BC=88include the CPU clock driver=EF=BC=89

Maybe

>
> Or using meson_eeclkc_probe is more easier?

It is not question of easiness, but correctness.

>
>> Is there anything but clocks and resets in these register region ?
> No, there is only clocks in the register region.
> the same does the PLL register region.

Then there is no reason to use syscon for those drivers

>>
>>> +
>>> +static const struct meson_eeclkc_data a1_periphs_data =3D {
>>> +		.regmap_clks =3D a1_periphs_regmaps,
>>> +		.regmap_clk_num =3D ARRAY_SIZE(a1_periphs_regmaps),
>>> +		.hw_onecell_data =3D &a1_periphs_hw_onecell_data,
>>> +};
>>> +static const struct of_device_id clkc_match_table[] =3D {
>>> +	{
>>> +		.compatible =3D "amlogic,a1-periphs-clkc",
>>> +		.data =3D &a1_periphs_data
>>> +	},
>>> +	{ /* sentinel */ }
>>> +};
>>> +
>>> +static struct platform_driver a1_driver =3D {
>>> +	.probe		=3D meson_a1_periphs_probe,
>>> +	.driver		=3D {
>>> +		.name	=3D "a1-periphs-clkc",
>>> +		.of_match_table =3D clkc_match_table,
>>> +	},
>>> +};
>>> +
>>> +builtin_platform_driver(a1_driver);
>>> diff --git a/drivers/clk/meson/a1.h b/drivers/clk/meson/a1.h
>>> new file mode 100644
>>> index 0000000..1ae5e04
>>> --- /dev/null
>>> +++ b/drivers/clk/meson/a1.h
>>> @@ -0,0 +1,120 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>>> +/*
>>> + * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +#ifndef __A1_H
>>> +#define __A1_H
>>> +
>>> +/* peripheral clock controller register offset */
>>> +#define SYS_OSCIN_CTRL			0x0
>>> +#define RTC_BY_OSCIN_CTRL0		0x4
>>> +#define RTC_BY_OSCIN_CTRL1		0x8
>>> +#define RTC_CTRL			0xc
>>> +#define SYS_CLK_CTRL0			0x10
>>> +#define AXI_CLK_CTRL0			0x14
>>> +#define SYS_CLK_EN0			0x1c
>>> +#define SYS_CLK_EN1			0x20
>>> +#define AXI_CLK_EN			0x24
>>> +#define DSPA_CLK_EN			0x28
>>> +#define DSPB_CLK_EN			0x2c
>>> +#define DSPA_CLK_CTRL0			0x30
>>> +#define DSPB_CLK_CTRL0			0x34
>>> +#define CLK12_24_CTRL			0x38
>>> +#define GEN_CLK_CTRL			0x3c
>>> +#define TIMESTAMP_CTRL0			0x40
>>> +#define TIMESTAMP_CTRL1			0x44
>>> +#define TIMESTAMP_CTRL2			0x48
>>> +#define TIMESTAMP_VAL0			0x4c
>>> +#define TIMESTAMP_VAL1			0x50
>>> +#define TIMEBASE_CTRL0			0x54
>>> +#define TIMEBASE_CTRL1			0x58
>>> +#define SAR_ADC_CLK_CTRL		0xc0
>>> +#define PWM_CLK_AB_CTRL			0xc4
>>> +#define PWM_CLK_CD_CTRL			0xc8
>>> +#define PWM_CLK_EF_CTRL			0xcc
>>> +#define SPICC_CLK_CTRL			0xd0
>>> +#define TS_CLK_CTRL			0xd4
>>> +#define SPIFC_CLK_CTRL			0xd8
>>> +#define USB_BUSCLK_CTRL			0xdc
>>> +#define SD_EMMC_CLK_CTRL		0xe0
>>> +#define CECA_CLK_CTRL0			0xe4
>>> +#define CECA_CLK_CTRL1			0xe8
>>> +#define CECB_CLK_CTRL0			0xec
>>> +#define CECB_CLK_CTRL1			0xf0
>>> +#define PSRAM_CLK_CTRL			0xf4
>>> +#define DMC_CLK_CTRL			0xf8
>>> +#define FCLK_DIV1_SEL			0xfc
>>> +#define TST_CTRL			0x100
>>> +
>>> +#define CLKID_XTAL_CLKTREE		0
>>> +#define CLKID_SYS_A_SEL			89
>>> +#define CLKID_SYS_A_DIV			90
>>> +#define CLKID_SYS_A			91
>>> +#define CLKID_SYS_B_SEL			92
>>> +#define CLKID_SYS_B_DIV			93
>>> +#define CLKID_SYS_B			94
>>> +#define CLKID_DSPA_A_SEL		95
>>> +#define CLKID_DSPA_A_DIV		96
>>> +#define CLKID_DSPA_A			97
>>> +#define CLKID_DSPA_B_SEL		98
>>> +#define CLKID_DSPA_B_DIV		99
>>> +#define CLKID_DSPA_B			100
>>> +#define CLKID_DSPB_A_SEL		101
>>> +#define CLKID_DSPB_A_DIV		102
>>> +#define CLKID_DSPB_A			103
>>> +#define CLKID_DSPB_B_SEL		104
>>> +#define CLKID_DSPB_B_DIV		105
>>> +#define CLKID_DSPB_B			106
>>> +#define CLKID_RTC_32K_CLKIN		107
>>> +#define CLKID_RTC_32K_DIV		108
>>> +#define CLKID_RTC_32K_XTAL		109
>>> +#define CLKID_RTC_32K_SEL		110
>>> +#define CLKID_CECB_32K_CLKIN		111
>>> +#define CLKID_CECB_32K_DIV		112
>>> +#define CLKID_CECB_32K_SEL_PRE		113
>>> +#define CLKID_CECB_32K_SEL		114
>>> +#define CLKID_CECA_32K_CLKIN		115
>>> +#define CLKID_CECA_32K_DIV		116
>>> +#define CLKID_CECA_32K_SEL_PRE		117
>>> +#define CLKID_CECA_32K_SEL		118
>>> +#define CLKID_DIV2_PRE			119
>>> +#define CLKID_24M_DIV2			120
>>> +#define CLKID_GEN_SEL			121
>>> +#define CLKID_GEN_DIV			122
>>> +#define CLKID_SARADC_DIV		123
>>> +#define CLKID_PWM_A_SEL			124
>>> +#define CLKID_PWM_A_DIV			125
>>> +#define CLKID_PWM_B_SEL			126
>>> +#define CLKID_PWM_B_DIV			127
>>> +#define CLKID_PWM_C_SEL			128
>>> +#define CLKID_PWM_C_DIV			129
>>> +#define CLKID_PWM_D_SEL			130
>>> +#define CLKID_PWM_D_DIV			131
>>> +#define CLKID_PWM_E_SEL			132
>>> +#define CLKID_PWM_E_DIV			133
>>> +#define CLKID_PWM_F_SEL			134
>>> +#define CLKID_PWM_F_DIV			135
>>> +#define CLKID_SPICC_SEL			136
>>> +#define CLKID_SPICC_DIV			137
>>> +#define CLKID_SPICC_SEL2		138
>>> +#define CLKID_TS_DIV			139
>>> +#define CLKID_SPIFC_SEL			140
>>> +#define CLKID_SPIFC_DIV			141
>>> +#define CLKID_SPIFC_SEL2		142
>>> +#define CLKID_USB_BUS_SEL		143
>>> +#define CLKID_USB_BUS_DIV		144
>>> +#define CLKID_SD_EMMC_SEL		145
>>> +#define CLKID_SD_EMMC_DIV		146
>>> +#define CLKID_SD_EMMC_SEL2		147
>>> +#define CLKID_PSRAM_SEL			148
>>> +#define CLKID_PSRAM_DIV			149
>>> +#define CLKID_PSRAM_SEL2		150
>>> +#define CLKID_DMC_SEL			151
>>> +#define CLKID_DMC_DIV			152
>>> +#define CLKID_DMC_SEL2			153
>>> +#define NR_CLKS				154
>>> +
>>> +#include <dt-bindings/clock/a1-clkc.h>
>>> +
>>> +#endif /* __A1_H */
>>
>> .
>>

