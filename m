Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5DF112A51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfLDLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 06:38:19 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:38469 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfLDLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:38:19 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icSz1-0001Pc-Ih; Wed, 04 Dec 2019 12:38:15 +0100
To:     Robin Murphy <robin.murphy@arm.com>
Subject: Re: perf record doesn't work on rtd129x SoC
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 04 Dec 2019 11:38:15 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Wang YanQing <udknight@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-realtek-soc@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <1b2d2bc3-afcf-02c3-ccd6-e2a227c23fd3@arm.com>
References: <20191204045559.GA10458@udknight>
 <f90748d0-8112-3aa8-0c88-e35a8d6e72d3@suse.de>
 <1b2d2bc3-afcf-02c3-ccd6-e2a227c23fd3@arm.com>
Message-ID: <1892ab83960fbdcdbb49c141577f2c11@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, afaerber@suse.de, udknight@gmail.com, mark.rutland@arm.com, linux-realtek-soc@lists.infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-04 11:20, Robin Murphy wrote:
> On 2019-12-04 7:28 am, Andreas Färber wrote:
>> Hi YanQing,
>> + LAKML + Mark + Will
>> Am 04.12.19 um 05:55 schrieb Wang YanQing:
>>> I use "perf record" to debug performance issue on RTD1296 SOC, it 
>>> does't work, but
>>> the "perf stat" is ok!
>> Thanks for the report - which board, branch and (base) tag are you
>> testing against? And are you building perf yourself from kernel 
>> sources,
>> or are you using some distro package?
>> I only have Busybox in my initrd on DS418; I have not tested perf.
>>
>>> After some dig in the kernel, I find the reason is no pmu overflow 
>>> interrupt, I think
>>> below pmu configuration isn't right for RTD1296:
>>> "
>>>          arm_pmu: arm-pmu {
>>>                  compatible = "arm,cortex-a53-pmu";
>>>                  interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>>>          };
>>> "
>>>
>>> We need 4 PMU SPI for RTD1296 (4 cores), and I guess the 48 isn't 
>>> right too.
>> Note that above rtd129x.dtsi snippet is not complete. See 
>> rtd1296.dtsi:
>> &arm_pmu {
>> 	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
>> };
>
> That doesn't help much, since 4 affinities for one SPI is rather 
> nonsensical.
>
>> 48 and high/4 match what I see in the latest BSP:
>> 
>> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/master/linux-rtk/arch/arm64/boot/dts/realtek/rtd129x/rtd-1296.dtsi#L116
>>
>>> Any suggestion is welcome.
>>>
>>> Thanks!
>> The only difference I see is "arm,cortex-a53-pmu" vs. 
>> "arm,armv8-pmuv3".
>> By my reading of arch/arm64/kernel/perf_event.c the only difference
>> between the two should be the name and an extra cache_map. You could 
>> try
>> the other compatible string in your .dts, but I doubt it'll help.
>> Hopefully the Realtek or Arm guys can shed some light.
>
> If the SoC really has all 4 overflow interrupts combined into a
> single SPI line, then sampling just isn't going to be supported - 
> it's
> unreasonably difficult to handle overflow when the IRQ may be taken 
> on
> the wrong CPU.

Indeed. And I've recently found this exact design blunder on a brand 
new
Amlogic SoC, where the per-core interrupts have been OR'd together.
And not just for the PMU! It is the same situation for the GIC, CTI,
and a couple of other things. The only sane interrupts are the timers.

(sound of a PCB hitting the bin...)

         M.
-- 
Jazz is not dead. It just smells funny...
