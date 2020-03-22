Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74BB18E8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 13:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCVM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 08:27:07 -0400
Received: from out28-97.mail.aliyun.com ([115.124.28.97]:42449 "EHLO
        out28-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgCVM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:27:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07447577|-1;CH=green;DM=||false|;DS=CONTINUE|ham_system_inform|0.418236-0.000470919-0.581293;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3RDnPI_1584879915;
Received: from 192.168.10.227(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3RDnPI_1584879915)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 22 Mar 2020 20:25:16 +0800
Subject: Re: [PATCH v6 2/6] clk: Ingenic: Adjust cgu code to make it
 compatible with X1830.
To:     Paul Cercueil <paul@crapouillou.net>
References: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1584865262-25297-4-git-send-email-zhouyanjie@wanyeetech.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <5E775929.8080100@wanyeetech.com>
Date:   Sun, 22 Mar 2020 20:25:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1584865262-25297-4-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2020年03月22日 20:04, Paul Cercueil wrote:
> Hi Zhou,
>
> Le dim. 22 mars 2020 à 16:20, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> The PLL of X1830 Soc from Ingenic has been greatly changed,
>> the bypass control is placed in another register, so now two
>> registers may needed to control the PLL. To this end, the
>> original "reg" was changed to "pll_reg", and a new "bypass_reg"
>> was introduced. In addition, when calculating rate, the PLL of
>> X1830 introduced an extra 2x multiplier, so a new "rate_multiplier"
>> was introduced. And adjust the code in jz47xx-cgu.c and x1000-cgu.c,
>> make it to be compatible with the new cgu code.
>>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>
> I think you need to update the commit message...
>

Oops, forgot to update it, I'll update it in next version.

Thanks and best regards!

> With that fixed,
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>
> -Paul
>
>> ---
>>
>> Notes:
>>     v1->v2:
>>     1.Use two fields (pll_reg & bypass_reg) instead of the 2-values
>>       array (reg[2]).
>>     2.Remove the "pll_info->version" and add a 
>> "pll_info->rate_multiplier".
>>     3.Fix the coding style and add more detailed commit message.
>>     4.Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
>>       to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
>>       the old mailbox is in an unstable state.
>>
>>     v2->v3:
>>     Adjust order from [1/5] in v2 to [2/5] in v3.
>>
>>     v3->v4:
>>     Merge [3/5] in v3 into this patch.
>>
>>     v4->v5:
>>     Rebase on top of kernel 5.6-rc1.
>>
>>     v5->v6:
>>     Revert "pll_reg" to "reg" to minimize patch as Paul Cercueil's 
>> suggest.
>>
>>  drivers/clk/ingenic/cgu.c         | 16 +++++++++++++---
>>  drivers/clk/ingenic/cgu.h         |  4 ++++
>>  drivers/clk/ingenic/jz4725b-cgu.c |  2 ++
>>  drivers/clk/ingenic/jz4740-cgu.c  |  2 ++
>>  drivers/clk/ingenic/jz4770-cgu.c  |  6 +++++-
>>  drivers/clk/ingenic/jz4780-cgu.c  |  2 ++
>>  drivers/clk/ingenic/x1000-cgu.c   |  4 ++++
>>  7 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
>> index ab1302a..d7981b6 100644
>> --- a/drivers/clk/ingenic/cgu.c
>> +++ b/drivers/clk/ingenic/cgu.c
>> @@ -90,6 +90,9 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned 
>> long parent_rate)
>>      n += pll_info->n_offset;
>>      od_enc = ctl >> pll_info->od_shift;
>>      od_enc &= GENMASK(pll_info->od_bits - 1, 0);
>> +
>> +    ctl = readl(cgu->base + pll_info->bypass_reg);
>> +
>>      bypass = !pll_info->no_bypass_bit &&
>>           !!(ctl & BIT(pll_info->bypass_bit));
>>
>> @@ -103,7 +106,8 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, 
>> unsigned long parent_rate)
>>      BUG_ON(od == pll_info->od_max);
>>      od++;
>>
>> -    return div_u64((u64)parent_rate * m, n * od);
>> +    return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
>> +        n * od);
>>  }
>>
>>  static unsigned long
>> @@ -136,7 +140,8 @@ ingenic_pll_calc(const struct 
>> ingenic_cgu_clk_info *clk_info,
>>      if (pod)
>>          *pod = od;
>>
>> -    return div_u64((u64)parent_rate * m, n * od);
>> +    return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
>> +        n * od);
>>  }
>>
>>  static inline const struct ingenic_cgu_clk_info *to_clk_info(
>> @@ -209,9 +214,14 @@ static int ingenic_pll_enable(struct clk_hw *hw)
>>      u32 ctl;
>>
>>      spin_lock_irqsave(&cgu->lock, flags);
>> -    ctl = readl(cgu->base + pll_info->reg);
>> +    ctl = readl(cgu->base + pll_info->bypass_reg);
>>
>>      ctl &= ~BIT(pll_info->bypass_bit);
>> +
>> +    writel(ctl, cgu->base + pll_info->bypass_reg);
>> +
>> +    ctl = readl(cgu->base + pll_info->reg);
>> +
>>      ctl |= BIT(pll_info->enable_bit);
>>
>>      writel(ctl, cgu->base + pll_info->reg);
>> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
>> index 0dc8004..2c75ef4 100644
>> --- a/drivers/clk/ingenic/cgu.h
>> +++ b/drivers/clk/ingenic/cgu.h
>> @@ -17,6 +17,7 @@
>>  /**
>>   * struct ingenic_cgu_pll_info - information about a PLL
>>   * @reg: the offset of the PLL's control register within the CGU
>> + * @rate_multiplier: the multiplier needed by pll rate calculation
>>   * @m_shift: the number of bits to shift the multiplier value by 
>> (ie. the
>>   *           index of the lowest bit of the multiplier value in the 
>> PLL's
>>   *           control register)
>> @@ -37,6 +38,7 @@
>>   * @od_encoding: a pointer to an array mapping post-VCO divider 
>> values to
>>   *               their encoded values in the PLL control register, 
>> or -1 for
>>   *               unsupported values
>> + * @bypass_reg: the offset of the bypass control register within the 
>> CGU
>>   * @bypass_bit: the index of the bypass bit in the PLL control register
>>   * @enable_bit: the index of the enable bit in the PLL control register
>>   * @stable_bit: the index of the stable bit in the PLL control register
>> @@ -44,10 +46,12 @@
>>   */
>>  struct ingenic_cgu_pll_info {
>>      unsigned reg;
>> +    unsigned rate_multiplier;
>>      const s8 *od_encoding;
>>      u8 m_shift, m_bits, m_offset;
>>      u8 n_shift, n_bits, n_offset;
>>      u8 od_shift, od_bits, od_max;
>> +    unsigned bypass_reg;
>>      u8 bypass_bit;
>>      u8 enable_bit;
>>      u8 stable_bit;
>> diff --git a/drivers/clk/ingenic/jz4725b-cgu.c 
>> b/drivers/clk/ingenic/jz4725b-cgu.c
>> index a3b4635..4799627 100644
>> --- a/drivers/clk/ingenic/jz4725b-cgu.c
>> +++ b/drivers/clk/ingenic/jz4725b-cgu.c
>> @@ -54,6 +54,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4725b_cgu_clocks[] = {
>>          .parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
>>          .pll = {
>>              .reg = CGU_REG_CPPCR,
>> +            .rate_multiplier = 1,
>>              .m_shift = 23,
>>              .m_bits = 9,
>>              .m_offset = 2,
>> @@ -65,6 +66,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4725b_cgu_clocks[] = {
>>              .od_max = 4,
>>              .od_encoding = pll_od_encoding,
>>              .stable_bit = 10,
>> +            .bypass_reg = CGU_REG_CPPCR,
>>              .bypass_bit = 9,
>>              .enable_bit = 8,
>>          },
>> diff --git a/drivers/clk/ingenic/jz4740-cgu.c 
>> b/drivers/clk/ingenic/jz4740-cgu.c
>> index 4f0e92c..16f7e1e 100644
>> --- a/drivers/clk/ingenic/jz4740-cgu.c
>> +++ b/drivers/clk/ingenic/jz4740-cgu.c
>> @@ -69,6 +69,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4740_cgu_clocks[] = {
>>          .parents = { JZ4740_CLK_EXT, -1, -1, -1 },
>>          .pll = {
>>              .reg = CGU_REG_CPPCR,
>> +            .rate_multiplier = 1,
>>              .m_shift = 23,
>>              .m_bits = 9,
>>              .m_offset = 2,
>> @@ -80,6 +81,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4740_cgu_clocks[] = {
>>              .od_max = 4,
>>              .od_encoding = pll_od_encoding,
>>              .stable_bit = 10,
>> +            .bypass_reg = CGU_REG_CPPCR,
>>              .bypass_bit = 9,
>>              .enable_bit = 8,
>>          },
>> diff --git a/drivers/clk/ingenic/jz4770-cgu.c 
>> b/drivers/clk/ingenic/jz4770-cgu.c
>> index 956dd65..1976008 100644
>> --- a/drivers/clk/ingenic/jz4770-cgu.c
>> +++ b/drivers/clk/ingenic/jz4770-cgu.c
>> @@ -102,6 +102,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4770_cgu_clocks[] = {
>>          .parents = { JZ4770_CLK_EXT },
>>          .pll = {
>>              .reg = CGU_REG_CPPCR0,
>> +            .rate_multiplier = 1,
>>              .m_shift = 24,
>>              .m_bits = 7,
>>              .m_offset = 1,
>> @@ -112,6 +113,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4770_cgu_clocks[] = {
>>              .od_bits = 2,
>>              .od_max = 8,
>>              .od_encoding = pll_od_encoding,
>> +            .bypass_reg = CGU_REG_CPPCR0,
>>              .bypass_bit = 9,
>>              .enable_bit = 8,
>>              .stable_bit = 10,
>> @@ -124,6 +126,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4770_cgu_clocks[] = {
>>          .parents = { JZ4770_CLK_EXT },
>>          .pll = {
>>              .reg = CGU_REG_CPPCR1,
>> +            .rate_multiplier = 1,
>>              .m_shift = 24,
>>              .m_bits = 7,
>>              .m_offset = 1,
>> @@ -134,9 +137,10 @@ static const struct ingenic_cgu_clk_info 
>> jz4770_cgu_clocks[] = {
>>              .od_bits = 2,
>>              .od_max = 8,
>>              .od_encoding = pll_od_encoding,
>> +            .bypass_reg = CGU_REG_CPPCR1,
>> +            .no_bypass_bit = true,
>>              .enable_bit = 7,
>>              .stable_bit = 6,
>> -            .no_bypass_bit = true,
>>          },
>>      },
>>
>> diff --git a/drivers/clk/ingenic/jz4780-cgu.c 
>> b/drivers/clk/ingenic/jz4780-cgu.c
>> index ea905ff..5102432 100644
>> --- a/drivers/clk/ingenic/jz4780-cgu.c
>> +++ b/drivers/clk/ingenic/jz4780-cgu.c
>> @@ -221,6 +221,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4780_cgu_clocks[] = {
>>
>>  #define DEF_PLL(name) { \
>>      .reg = CGU_REG_ ## name, \
>> +    .rate_multiplier = 1, \
>>      .m_shift = 19, \
>>      .m_bits = 13, \
>>      .m_offset = 1, \
>> @@ -232,6 +233,7 @@ static const struct ingenic_cgu_clk_info 
>> jz4780_cgu_clocks[] = {
>>      .od_max = 16, \
>>      .od_encoding = pll_od_encoding, \
>>      .stable_bit = 6, \
>> +    .bypass_reg = CGU_REG_ ## name, \
>>      .bypass_bit = 1, \
>>      .enable_bit = 0, \
>>  }
>> diff --git a/drivers/clk/ingenic/x1000-cgu.c 
>> b/drivers/clk/ingenic/x1000-cgu.c
>> index b22d87b..6f0ec9d 100644
>> --- a/drivers/clk/ingenic/x1000-cgu.c
>> +++ b/drivers/clk/ingenic/x1000-cgu.c
>> @@ -58,6 +58,7 @@ static const struct ingenic_cgu_clk_info 
>> x1000_cgu_clocks[] = {
>>          .parents = { X1000_CLK_EXCLK, -1, -1, -1 },
>>          .pll = {
>>              .reg = CGU_REG_APLL,
>> +            .rate_multiplier = 1,
>>              .m_shift = 24,
>>              .m_bits = 7,
>>              .m_offset = 1,
>> @@ -68,6 +69,7 @@ static const struct ingenic_cgu_clk_info 
>> x1000_cgu_clocks[] = {
>>              .od_bits = 2,
>>              .od_max = 8,
>>              .od_encoding = pll_od_encoding,
>> +            .bypass_reg = CGU_REG_APLL,
>>              .bypass_bit = 9,
>>              .enable_bit = 8,
>>              .stable_bit = 10,
>> @@ -79,6 +81,7 @@ static const struct ingenic_cgu_clk_info 
>> x1000_cgu_clocks[] = {
>>          .parents = { X1000_CLK_EXCLK, -1, -1, -1 },
>>          .pll = {
>>              .reg = CGU_REG_MPLL,
>> +            .rate_multiplier = 1,
>>              .m_shift = 24,
>>              .m_bits = 7,
>>              .m_offset = 1,
>> @@ -89,6 +92,7 @@ static const struct ingenic_cgu_clk_info 
>> x1000_cgu_clocks[] = {
>>              .od_bits = 2,
>>              .od_max = 8,
>>              .od_encoding = pll_od_encoding,
>> +            .bypass_reg = CGU_REG_MPLL,
>>              .bypass_bit = 6,
>>              .enable_bit = 7,
>>              .stable_bit = 0,
>> -- 
>> 2.7.4
>>
>

