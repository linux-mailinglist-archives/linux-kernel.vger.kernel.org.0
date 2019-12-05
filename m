Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7238B114098
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 13:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfLEMKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 07:10:39 -0500
Received: from foss.arm.com ([217.140.110.172]:60410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfLEMKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:10:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4C7A31B;
        Thu,  5 Dec 2019 04:10:38 -0800 (PST)
Received: from [192.168.1.124] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BF4C3F68E;
        Thu,  5 Dec 2019 04:10:36 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        James Tai <james.tai@realtek.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191205082555.22633-1-james.tai@realtek.com>
 <20191205082555.22633-3-james.tai@realtek.com>
 <4040ffcf-5c54-fb44-b0a8-ce0c8c21b93f@suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c2703787-2d0b-4d78-f4e3-8b77ba636bb4@arm.com>
Date:   Thu, 5 Dec 2019 12:10:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4040ffcf-5c54-fb44-b0a8-ce0c8c21b93f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-05 10:58 am, Andreas Färber wrote:
[...]
>> +	arm_pmu: pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
>> +			<&cpu3>;
>> +	};
> 
> @Robin, is this single PPI interrupt better than previous single SPI?

Yes, a PPI is ideal (since it allows core to see its own local interrupt).

> Is "arm,armv8-pmuv3" the correct one to use for Cortex-A55? There's no
> "arm,cortex-a55-pmu" binding - is that still in the works?

Hmm, I had thought that had been done already, but apparently not. Looks 
like it's high time for another round of event map updates for the 
latest Cortex and Neoverse cores, so I guess I'll add that to our 
backlog internally - although the PMU events should be in the public 
TRMs so if anyone else *did* fancy ploughing through them to spin 
patches they're always welcome to :)

In the meantime the generic PMUv3 compatible will at least expose the 
subset of mandatory architectural events, which is arguably more useful 
than nothing.

>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
> 
> @Lorenzo: Same question as left unanswered for RTD1619:
> Should this be "arm,psci-1.0", "arm-psci-0.2"?
> 
> The YAML schema allows both, without clearly documenting which one shall
> be used in new DTs, and there's no psci-1.0 example either.

FWIW the age of the DT shouldn't really be relevant - it's a question of 
whether the platform's EL3 firmware actually implements the PSCI 1.0 (or 
later) spec, or is some fossilised binary based on the older version.

Robin.
