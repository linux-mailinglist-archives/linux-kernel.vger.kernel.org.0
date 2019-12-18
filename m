Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426B11241F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfLRIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 03:41:12 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:57240 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:41:11 -0500
Received: from [10.28.39.99] (10.28.39.99) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 18 Dec
 2019 16:37:50 +0800
Subject: Re: [PATCH v4 2/6] clk: meson: add support for A1 PLL clock ops
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
 <20191206074052.15557-3-jian.hu@amlogic.com>
 <1j8snhluhg.fsf@starbuckisacylon.baylibre.com>
 <741284be-2ae8-1102-22bc-c510e822c883@amlogic.com>
 <1jk16vb8qm.fsf@starbuckisacylon.baylibre.com>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <0bc6176f-c0b8-5c31-4c6b-d3686eefe56e@amlogic.com>
Date:   Wed, 18 Dec 2019 16:37:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1jk16vb8qm.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.99]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/17 17:29, Jerome Brunet wrote:
> 
> On Tue 17 Dec 2019 at 09:41, Jian Hu <jian.hu@amlogic.com> wrote:
> 
>> On 2019/12/12 18:16, Jerome Brunet wrote:
>>>
>>> On Fri 06 Dec 2019 at 08:40, Jian Hu <jian.hu@amlogic.com> wrote:
>>>
>>>> The A1 PLL design is different with previous SoCs. The PLL
>>>> internal analog modules Power-on sequence is different
>>>> with previous, and thus requires a strict register sequence to
>>>> enable the PLL.
>>>>
>>>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>>>> ---
>>>>    drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
>>>>    drivers/clk/meson/clk-pll.h |  1 +
>>>>    drivers/clk/meson/parm.h    |  1 +
>>>>    3 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>>> index ddb1e5634739..4aff31a51589 100644
>>>> --- a/drivers/clk/meson/clk-pll.c
>>>> +++ b/drivers/clk/meson/clk-pll.c
>>>> @@ -318,6 +318,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>>>    	struct clk_regmap *clk = to_clk_regmap(hw);
>>>>    	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>>>>    +	/*
>>>> +	 * The A1 design is different with previous SoCs.The PLL
>>>> +	 * internal analog modules Power-on sequence is different with
>>>> +	 * previous, and thus requires a strict register sequence to
>>>> +	 * enable the PLL.
>>>
>>> The code does something more, not completly different. This comment is
>>> not aligned with what the code does
>> ok, I will correct the comment.
>>>
>>>> +	 */
>>>> +	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>>>> +		/* Enable the pll */
>>>> +		meson_parm_write(clk->map, &pll->en, 1);
>>>> +		udelay(10);
>>>> +		/* Enable the pll self-adaption module current */
>>>> +		meson_parm_write(clk->map, &pll->current_en, 1);
>>>> +		udelay(40);
>>>> +		meson_parm_write(clk->map, &pll->rst, 1);
>>>> +		meson_parm_write(clk->map, &pll->rst, 0);
>>>
>>> Here you enable the PLL and self adaptation module then reset the PLL.
>>> However:
>>> #1 when you enter this function, the PLL should already by in reset
>>> and disabled
>>> #2 the code after that will reset the PLL again
>> For A1 PLLs, There is no reset bit, It will not reset the PLL.
>> And in V2, you mentioned PARM 'rst' can be used for one toggling, And 'rst'
>> is used for BIT(6) in CTRL2.
>>
> 
> oh my ! What is it then ? Why do you need to toggle it ? What does is do ?
> 
The PLL enable flow:
      step1: enable the PLL
      step2: enable the self adaptation module
      step3: reset the lock detect module, let the lock detect module 
            work，And then the PLL will work.

Toggle the bit 6 in CTRL2 can reset the lock detect module.
>> Quote V2 the HIFI PLL init_regs definition：
>>
>>
>> +static const struct reg_sequence a1_hifi_init_regs[] = {
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x01800000 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x100a1100 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x00302000 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x01f18440 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x11f18440, .delay_us = 10 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0x15f18440, .delay_us = 40 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001140 },
>> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00001100 },
>> +};
>>
>> So maybe another new PARM should be defined to avoid the ambiguity.
>> What do you think about it?
> 
> This is not the point of my comment Jian !
> 
> I'm assuming here that you have tested your v4 before sending and that
> it work (hopefully)
> 
Yes, it works wells. I have tested the drivers before sending every 
patchset version.
> The fact is that with this code, when disabled the bit behind rst
> (whatever it is) is set. So when you get to enable the bit is already set.
> The code you sent does the same as the snip I gave you in the reply.
> 
> Now, if your PLL is THAT different, maybe it would be best if you could
> clearly explain how it works, what bit should be set and why. Then we
> will be able to figure out how the driver has to be restructured.
> 
the same as 'The PLL enable flow' above
>>
>>>
>>> So if what you submited works, inserting the following should accomplish
>>> the same thing:
>>>
>>> ---8<---
>>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>>> index 489092dde3a6..9b38df0a7682 100644
>>> --- a/drivers/clk/meson/clk-pll.c
>>> +++ b/drivers/clk/meson/clk-pll.c
>>> @@ -330,6 +330,13 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>>>           /* Enable the pll */
>>>           meson_parm_write(clk->map, &pll->en, 1);
>>>
>>> +       if (MESON_PARM_APPLICABLE(&pll->current_en)) {
>>> +               udelay(10);
>>> +               /* Enable the pll self-adaption module current */
>>> +               meson_parm_write(clk->map, &pll->current_en, 1);
>>> +               udelay(40);
>>> +       }
>>> +
>>>           /* Take the pll out reset */
>>>           meson_parm_write(clk->map, &pll->rst, 0);
>>> --->8---
>>>
>>>
>>>
>>>
>>>> +	}
>>>> +
>>>>    	/* do nothing if the PLL is already enabled */
>>>>    	if (clk_hw_is_enabled(hw))
>>>>    		return 0;
>>>
>>> In any case, nothing should be done on the clock before this check
>>> otherwise you might just break the clock
>>>
>> OK, I will put the enabled check ahead.
>>>> @@ -347,6 +364,10 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
>>>>      	/* Disable the pll */
>>>>    	meson_parm_write(clk->map, &pll->en, 0);
>>>> +
>>>> +	/* Disable PLL internal self-adaption module current */
>>>> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
>>>> +		meson_parm_write(clk->map, &pll->current_en, 0);
>>>>    }
>>>>      static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long
>>>> rate,
>>>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>>>> index 367efd0f6410..30f039242a65 100644
>>>> --- a/drivers/clk/meson/clk-pll.h
>>>> +++ b/drivers/clk/meson/clk-pll.h
>>>> @@ -36,6 +36,7 @@ struct meson_clk_pll_data {
>>>>    	struct parm frac;
>>>>    	struct parm l;
>>>>    	struct parm rst;
>>>> +	struct parm current_en;
>>>>    	const struct reg_sequence *init_regs;
>>>>    	unsigned int init_count;
>>>>    	const struct pll_params_table *table;
>>>> diff --git a/drivers/clk/meson/parm.h b/drivers/clk/meson/parm.h
>>>> index 3c9ef1b505ce..c53fb26577e3 100644
>>>> --- a/drivers/clk/meson/parm.h
>>>> +++ b/drivers/clk/meson/parm.h
>>>> @@ -20,6 +20,7 @@
>>>>    	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
>>>>      #define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
>>>> +#define MESON_PARM_CURRENT(p)			(!!((p)->width))
>>>
>>> Why do we need that ?
>> OK, I will remove it ,and use 'MESON_PARM_APPLICABLE' instead
>>>
>>>>      struct parm {
>>>>    	u16	reg_off;
>>>
>>> .
>>>
> 
> .
> 
