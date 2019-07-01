Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADF10B80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEAQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:44:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46062 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfEAQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:44:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so25173169wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ja32Gyq70+OBBkHaIRUUmyD6+MuN36kZtNVGyzR7Kds=;
        b=QJyowOmmTnmNnf6AH+FAsnGcUOr0ytafxT9RK+CxEOHwC8ap6vZ1zWX6O2Kk17ZriZ
         XGH30PYRWbToBQfGlunFmVkU0RBqbNPiOMxRycGvT1O5nYiFPXxBa0lMhTobDaEYw6Vw
         z39iPKjdnkYVMhilXAkAr+4yLUaSdZyWJ2/XmkwFi+srx9lWJt1VA/inNBl3b5ZL4dNS
         igK1MQ96s39JGKc//FzFelocBPmJFgOdPC+k4CnxTT4BqtzjhokDS/dkgWza9fq2Hslr
         oiQBecKo+PgXcdgfXsb/xIfSrJJCdzWR4v6LN03qylgMdeD7InfHppIwXbLoyHu5rNN9
         kGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ja32Gyq70+OBBkHaIRUUmyD6+MuN36kZtNVGyzR7Kds=;
        b=MQIRlgW8wnP8wMrs06qN6hwikv0BXMNFb+bVvIcNR2PE6hHnOVuPATZJY6fHwBwCd7
         e8JklvXaJkv4pNUojheFl0EPJYuD6LBbZA1b4BekdYvF/uwqMzW4gFq74/qyMKYV+mB9
         hxgt3y26PLSOkSitDC1F+2v99F8Q15kK+GBFxlIaBs/e/S0TgM1dtRFFyB8ovrpRFbcD
         tF9zz6/Mrwrm40DloNq6PLbV03Q/VRQudA5IVu1Mrv/7zUKXvmYm4qBQd5J5XCcBzalF
         DEoiibtLxL5zSBTgta1C5CePITStEp2VFA9RHpoS8K6Djl+Ch6P+5LDcaKkAXbH4cb24
         KI0w==
X-Gm-Message-State: APjAAAXHPT8UYTydf4EcWmFgfqetrU2GgTxlzsaVhXv3/DikiXSLwL1K
        1dDEWLxV8bdgKsgV11VIuKE=
X-Google-Smtp-Source: APXvYqyGKXUa+HsFCcDWAa+oHzRiEjPOGUKi3uVOgfUUfdd9cbxpa6W7tPnpufDQcC3/nMAKB8QO8g==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr1738675wru.202.1556729037901;
        Wed, 01 May 2019 09:43:57 -0700 (PDT)
Received: from [10.67.50.73] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v2sm21710353wrq.12.2019.05.01.09.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:43:56 -0700 (PDT)
Subject: Re: [PATCH] arm64: Demote boot and shutdown messages to pr_debug
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk, Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>
References: <20190430223835.23513-1-f.fainelli@gmail.com>
 <20190501104733.GB11740@lakrids.cambridge.arm.com>
 <61e61f14-c991-179f-66a9-a98dcee6c10b@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <f99ffea3-598a-4ac9-52ff-b1501a6cfc04@gmail.com>
Date:   Wed, 1 May 2019 09:43:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <61e61f14-c991-179f-66a9-a98dcee6c10b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 4:02 AM, Robin Murphy wrote:
> On 01/05/2019 11:47, Mark Rutland wrote:
>> On Tue, Apr 30, 2019 at 03:38:31PM -0700, Florian Fainelli wrote:
>>> Similar to commits c68b0274fb3cf ("ARM: reduce "Booted secondary
>>> processor" message to debug level") and 035e787543de7 ("ARM: 8644/1:
>>> Reduce "CPU:
>>> shutdown" message to debug level"), demote the secondary_start_kernel()
>>> and __cpu_die() messages from info, respectively notice to debug. While
>>> we are at it, also do this for cpu_psci_cpu_kill() which is redundant
>>> with __cpu_die().
>>>
>>> This helps improve the amount of possible hotplug cycles by around +50%
>>> on ARCH_BRCMSTB.
>>
>> Could you elaborate on why that matters?
> 
> Yeah, in general if you have a slow serial console then removing all the
> prints from the kernel makes lots of things much faster, but that's not
> necessarily a good argument for doing so. If that's a problem that
> really concerns users then I'd have to ask why they aren't using a
> stricter loglevel or a different console to begin with.

See my response to Mark for specific use cases. Teaching users about
changing their default print levels is certainly an option, although
they will likely start wondering why other messages are now gone as
well. There is not unfortunately a choice of a faster console on those
platforms.

The print levels are not necessarily consistent (info vs. notice) and we
have plenty of messages for when the CPU does not come online so telling
us when it does is completely superfluous and does not bring much value
and just gets in the way of being able to do that more often.

> 
>> e.g. is this just for testing, or does this matter in some shutdown or
>> hibernate scenario?
>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>   arch/arm64/kernel/psci.c | 2 +-
>>>   arch/arm64/kernel/smp.c  | 4 ++--
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>>> index 8cdaf25e99cd..a78581046c80 100644
>>> --- a/arch/arm64/kernel/psci.c
>>> +++ b/arch/arm64/kernel/psci.c
>>> @@ -96,7 +96,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>>       for (i = 0; i < 10; i++) {
>>>           err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>>           if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>>> -            pr_info("CPU%d killed.\n", cpu);
>>> +            pr_debug("CPU%d killed.\n", cpu);
>>>               return 0;
>>>           }
>>>   diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>> index 824de7038967..71fd2b5a3f0e 100644
>>> --- a/arch/arm64/kernel/smp.c
>>> +++ b/arch/arm64/kernel/smp.c
>>> @@ -259,7 +259,7 @@ asmlinkage notrace void secondary_start_kernel(void)
>>>        * the CPU migration code to notice that the CPU is online
>>>        * before we continue.
>>>        */
>>> -    pr_info("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
>>> +    pr_debug("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
>>>                        cpu, (unsigned long)mpidr,
>>>                        read_cpuid_id());
>>
>> I generally agree that we don't need to be verbose, and demoting these
>> to debug is fine, but it's a shame that these won't be accessible in
>> defconfig.
>>
>> I wonder if we should enable DYNAMIC_DEBUG so that we can turn these on
>> from the kernel command line, or if we should have something like a
>> verbose_hotplug option specifically for these messages.
> 
> We've had DYNAMIC_DEBUG=y in defconfig for a while already :/
> 
> Robin.
> 
>>
>> Thanks,
>> Mark.
>>
>>>       update_cpu_boot_status(CPU_BOOT_SUCCESS);
>>> @@ -348,7 +348,7 @@ void __cpu_die(unsigned int cpu)
>>>           pr_crit("CPU%u: cpu didn't die\n", cpu);
>>>           return;
>>>       }
>>> -    pr_notice("CPU%u: shutdown\n", cpu);
>>> +    pr_debug("CPU%u: shutdown\n", cpu);
>>>         /*
>>>        * Now that the dying CPU is beyond the point of no return w.r.t.
>>> -- 
>>> 2.17.1
>>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>


-- 
Florian
