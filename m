Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07E71484
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfGWJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 05:01:46 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:59981 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387734AbfGWJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:01:45 -0400
X-Greylist: delayed 2135 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 05:01:45 EDT
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1hpq7Z-0006kD-Aa; Tue, 23 Jul 2019 10:26:05 +0200
To:     Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v2] KVM: arm/arm64: Introduce =?UTF-8?Q?kvm=5Fpmu=5Fvc?=  =?UTF-8?Q?pu=5Finit=28=29=20to=20setup=20PMU=20counter=20idx?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Jul 2019 09:26:04 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>, <james.morse@arm.com>,
        <suzuki.poulose@arm.com>, <julien.thierry.kdev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <andrew.murray@arm.com>
In-Reply-To: <f3f6f9a9-9735-e253-7b5b-3ccf97619a16@arm.com>
References: <1563437710-30756-1-git-send-email-yuzenghui@huawei.com>
 <f3f6f9a9-9735-e253-7b5b-3ccf97619a16@arm.com>
Message-ID: <d5c0d757232935c6446aeaca9afe4416@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: julien.thierry@arm.com, yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, james.morse@arm.com, suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, andrew.murray@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-23 09:17, Julien Thierry wrote:
> Hi Zenghui,
>
> On 18/07/2019 09:15, Zenghui Yu wrote:
>> We use "pmc->idx" and the "chained" bitmap to determine if the pmc 
>> is
>> chained, in kvm_pmu_pmc_is_chained().  But idx might be 
>> uninitialized
>> (and random) when we doing this decision, through a 
>> KVM_ARM_VCPU_INIT
>> ioctl -> kvm_pmu_vcpu_reset(). And the test_bit() against this 
>> random
>> idx will potentially hit a KASAN BUG [1].
>>
>> In general, idx is the static property of a PMU counter that is not
>> expected to be modified across resets, as suggested by Julien.  It
>> looks more reasonable if we can setup the PMU counter idx for a vcpu
>> in its creation time. Introduce a new function - kvm_pmu_vcpu_init()
>> for this basic setup. Oh, and the KASAN BUG will get fixed this way.
>>
>> [1] https://www.spinics.net/lists/kvm-arm/msg36700.html
>>
>> Fixes: 80f393a23be6 ("KVM: arm/arm64: Support chained PMU counters")
>> Suggested-by: Andrew Murray <andrew.murray@arm.com>
>> Suggested-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>
>> Changes since v1:
>>  - Introduce kvm_pmu_vcpu_init() in vcpu's creation time, move the
>>    assignment of pmc->idx into it.
>>  - Thus change the subject. The old one is "KVM: arm/arm64: Assign
>>    pmc->idx before kvm_pmu_stop_counter()".
>>
>> Julien, I haven't collected your Acked-by into this version. If 
>> you're
>> still happy with the change, please Ack again. Thanks!
>>
>
> Thanks for making the change. This looks good to me:
>
> Acked-by: Julien Thierry <julien.thierry@arm.com>

Applied, thanks both.

         M.
-- 
Jazz is not dead. It just smells funny...
