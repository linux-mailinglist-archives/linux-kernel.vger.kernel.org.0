Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABAC137B41
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 03:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgAKCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 21:51:48 -0500
Received: from regular1.263xmail.com ([211.150.70.196]:44268 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgAKCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:51:47 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 5298AAEF;
        Sat, 11 Jan 2020 10:51:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.22.134] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P18165T140049637156608S1578711084676609_;
        Sat, 11 Jan 2020 10:51:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <98790e13baf9cbe1ec69e6a1659298c4>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5E193828.1070000@rock-chips.com>
Date:   Sat, 11 Jan 2020 10:51:20 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Robin Murphy <robin.murphy@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] arch_topology: Adjust initial CPU capacities with
 current freq
References: <20200109075214.31943-1-jeffy.chen@rock-chips.com> <20200110113711.GB39451@bogus> <5475692c-e72b-74c1-bd6e-95278703249b@arm.com> <15ab46e5-a2b4-eb96-1217-2b2ef8827f64@arm.com>
In-Reply-To: <15ab46e5-a2b4-eb96-1217-2b2ef8827f64@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for the clarification :)

On 01/10/2020 08:28 PM, Robin Murphy wrote:
> On 2020-01-10 12:01 pm, Dietmar Eggemann wrote:
>> On 10/01/2020 12:37, Sudeep Holla wrote:
>>> On Thu, Jan 09, 2020 at 03:52:14PM +0800, Jeffy Chen wrote:
>>>> The CPU freqs are not supposed to change before cpufreq policies
>>>> properly registered, meaning that they should be used to calculate the
>>>> initial CPU capacities.
>>>>
>>>> Doing this helps choosing the best CPU during early boot, especially
>>>> for the initramfs decompressing.
>>>>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>
>>> [...]
>>>
>>>> @@ -146,10 +153,15 @@ bool __init topology_parse_cpu_capacity(struct
>>>> device_node *cpu_node, int cpu)
>>>>                   return false;
>>>>               }
>>>>           }
>>>> -        capacity_scale = max(cpu_capacity, capacity_scale);
>>>>           raw_capacity[cpu] = cpu_capacity;
>>>>           pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
>>>>               cpu_node, raw_capacity[cpu]);
>>>> +
>>>> +        cpu_clk = of_clk_get(cpu_node, 0);
>>>> +        if (!PTR_ERR_OR_ZERO(cpu_clk))
>>>> +            per_cpu(max_freq, cpu) = clk_get_rate(cpu_clk) / 1000;
>>>> +
>>>> +        clk_put(cpu_clk);
>>>
>>> I don't like to assume DVFS to be supplied only using 'clk'. So NACK!
>>> We have other non-clk mechanism for CPU DVFS and this needs to simply
>>> use cpufreq APIs to get frequency value if required.
>>
>> To support this, it's failing on my Arm64 Juno board.
>>
>> ...
>> [    0.084858] CPU1 cpu_clk=-517
>> [    0.087961] CPU2 cpu_clk=-517
>> [    0.091005] CPU0 cpu_clk=-517
>> [    0.094121] CPU3 cpu_clk=-517
>> [    0.097248] CPU4 cpu_clk=-517
>> [    0.100415] CPU5 cpu_clk=-517

It there any other way to get the initial cpu capacity for this case?

Or can we just assuming all the cores running at the same freq here?

>> ...
>>
>> Since you're on a big.LITTLE platform, did you specify
>> 'capacity-dmips-mhz' for CPUs to be able to distinguish big and little
>> CPUs before CPUfreq kicks in?
>
> Indeed, and that's the "problem" - the capacities are there, but with
> the broken firmware the kernel starts with the little (boot) cluster
> clocked at either 400 or 200MHz, but the big cluster at just 12MHz. At
> that speed, a full distro config can take about 3 minutes to get to the
> point of loading cpufreq as a module, and I've seen at least one distro
> reverting 97df3aa76b4a to 'fix' the symptom :(

Right, for the big cluster, the bootrom(maskrom) will init the clock to 
24MHz, and if the bootloader(u-boot for example) doesn't bump it, it 
would become 12MHz after kernel initialized the whole clk tree.

And in rockchip's BSP 4.4 kernel, there are hacks to bump it to 
800MHz(higher freq might require regulator changing) in clk tree 
initialization, the BSP u-boot also added that recently.

The chromeos's coreboot looks fine, but upstream u-boot seems missing 
that part too, i'll try to send a patch for that :)

>
> Robin.
>
>>
>> $ grep capacity-dmips-mhz ./arch/arm64/boot/dts/arm/juno.dts
>>             capacity-dmips-mhz = <1024>;
>>             capacity-dmips-mhz = <1024>;
>>             capacity-dmips-mhz = <578>;
>>             capacity-dmips-mhz = <578>;
>>             capacity-dmips-mhz = <578>;
>>             capacity-dmips-mhz = <578>;
>>
>
>
>
>



