Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812EA103754
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 11:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfKTKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 05:20:22 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:41902 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728384AbfKTKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:20:22 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iXN5w-0001Hp-MP; Wed, 20 Nov 2019 11:20:20 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v4 2/8] irqchip: Add Realtek RTD1295 mux driver
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Nov 2019 10:20:20 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aleix Roca Nonell <kernelrocks@gmail.com>,
        James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <d7416bdb-e20a-42e1-daff-c61369f359fa@suse.de>
References: <20191119021917.15917-1-afaerber@suse.de>
 <20191119021917.15917-3-afaerber@suse.de>
 <a34e00cac16899b53d0b6445f0e81f4c@www.loen.fr>
 <e98364c5-a859-7981-8ccf-f8e5b5069379@suse.de> <20191119222956.23665e5d@why>
 <d7416bdb-e20a-42e1-daff-c61369f359fa@suse.de>
Message-ID: <e4d30ff2485c3f9ffd2b934f1f757d19@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernelrocks@gmail.com, james.tai@realtek.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 23:33, Andreas Färber wrote:
> Am 19.11.19 um 23:29 schrieb Marc Zyngier:
>> On Tue, 19 Nov 2019 21:56:48 +0100
>> Andreas Färber <afaerber@suse.de> wrote:
>>> Am 19.11.19 um 13:01 schrieb Marc Zyngier:
>>>> On 2019-11-19 02:19, Andreas Färber wrote:
>>>>> +static void rtd1195_mux_enable_irq(struct irq_data *data)
>>>>> +{
>>>>> +    struct rtd1195_irq_mux_data *mux_data =
>>>>> irq_data_get_irq_chip_data(data);
>>>>> +    unsigned long flags;
>>>>> +    u32 mask;
>>>>> +
>>>>> +    mask = mux_data->info->isr_to_int_en_mask[data->hwirq];
>>>>> +    if (!mask)
>>>>> +        return;
>>>>
>>>> How can this happen? You've mapped the interrupt, so it exists.
>>>> I can't see how you can decide to fail such enable.
>>>
>>> The [UMSK_]ISR bits and the SCPU_INT_EN bits are not (all) the 
>>> same.
>>>
>>> My ..._isr_to_scpu_int_en[] arrays have 32 entries for O(1) lookup, 
>>> but
>>> are sparsely populated. So there are circumstances such as WDOG_NMI 
>>> as
>>> well as reserved bits that we cannot enable.
>>
>> But the you should have failed the map. The moment you allow the
>> mapping to occur, you have accepted the contract that this interrupt 
>> is
>> usable.
>>
>>> This check should be
>>> identical to v3; the equivalent mask check inside the interrupt 
>>> handler
>>> was extended with "mask &&" to do the same in this v4.
>>
>> Spurious interrupts are a different matter. What I'm objecting to 
>> here
>> is a simple question of logic, whether or not you are allowed to 
>> fail
>> enabling an interrupt that you've otherwise allowed to be populated.
>
> Then what are you suggesting instead? I don't see how my array map
> lookup could fail other than returning a zero value, given its static
> initialization. Check for a zero mask in 
> rtd1195_mux_irq_domain_map()?
> Then we wouldn't be able to use the mentioned WDOG_NMI. Add another
> per-mux info field for which interrupts are valid to map?

I'm suggesting that you fail the map if you're unable to allow the
interrupt to be enabled.

         M.
-- 
Jazz is not dead. It just smells funny...
