Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02A18D576
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCTRPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:15:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39498 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCTRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48kVl40Ggxz1qrfN;
        Fri, 20 Mar 2020 18:14:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48kVl365vBz1qrbg;
        Fri, 20 Mar 2020 18:14:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id VjzbTi-s-X4U; Fri, 20 Mar 2020 18:14:54 +0100 (CET)
X-Auth-Info: gttYc16SEC5d8uweW5kSjOieA30mQYvZH0Lr9j4MciM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 20 Mar 2020 18:14:54 +0100 (CET)
Subject: Re: [PATCH] mtd: rawnand: denali: add more delays before latching
 incoming data
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20200316104307.1891-1-yamada.masahiro@socionext.com>
 <20200320181159.5004099f@xps13>
From:   Marek Vasut <marex@denx.de>
Message-ID: <2d02c851-4249-053c-99e9-69b209bffad2@denx.de>
Date:   Fri, 20 Mar 2020 18:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320181159.5004099f@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 6:11 PM, Miquel Raynal wrote:
> Hi Marek,
> 
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Mon, 16 Mar
> 2020 19:43:07 +0900:
> 
>> The Denali IP have several registers to specify how many clock cycles
>> should be waited between falling/rising signals. You can improve the
>> NAND access performance by programming these registers with optimized
>> values.
>>
>> Because struct nand_sdr_timings represents the device requirement
>> in pico seconds, denali_setup_data_interface() computes the register
>> values by dividing the device timings with the clock period.
>>
>> Marek Vasut reported this driver in the latest kernel does not work
>> on his SOCFPGA board. (The on-board NAND chip is mode 5)
>>
>> The suspicious parameter is acc_clks, so this commit relaxes it.
>>
>> The Denali NAND Flash Memory Controller User's Guide describes this
>> register as follows:
>>
>>   acc_clks
>>     signifies the number of bus interface clk_x clock cycles,
>>     controller should wait from read enable going low to sending
>>     out a strobe of clk_x for capturing of incoming data.
>>
>> Currently, acc_clks is calculated only based on tREA, the delay on the
>> chip side. This does not include additional delays that come from the
>> data path on the PCB and in the SoC, load capacity of the pins, etc.
>>
>> This relatively becomes a big factor on faster timing modes like mode 5.
>>
>> Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
>> the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
>> the timing mode 5.
>>
>> We would not go back to the hard-coded acc_clks, but we need to include
>> this factor into the delay somehow. Let's say the amount of the additional
>> delay is 10000 pico sec.
>>
>> In the new calculation, acc_clks is determined by timings->tREA_max +
>> data_setup_on_host.
>>
>> Also, prolong the RE# low period to make sure the data hold is met.
>>
>> Finally, re-center the data latch timing for extra safety.
>>
>> [1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
>> [2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282
>>
>> Reported-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
> 
> Can you please give this patch a try and report the result?

It's on my list, don't worry.
