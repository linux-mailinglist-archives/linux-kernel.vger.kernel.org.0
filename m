Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF0137645
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgAJSml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 13:42:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgAJSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:42:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934AC30E;
        Fri, 10 Jan 2020 10:42:40 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6EA3F6C4;
        Fri, 10 Jan 2020 10:42:39 -0800 (PST)
Subject: Re: [PATCH v2 5/7] arm64: ptrace: nofpsimd: Fail FP/SIMD regset
 operations
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Will Deacon <will.deacon@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-6-suzuki.poulose@arm.com>
 <20200110151231.GG8786@arrakis.emea.arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <2078734b-fba5-8207-a73a-3eee4b899256@arm.com>
Date:   Fri, 10 Jan 2020 18:42:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110151231.GG8786@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2020 15:12, Catalin Marinas wrote:
> On Tue, Dec 17, 2019 at 06:34:00PM +0000, Suzuki K Poulose wrote:
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 6771c399d40c..0135b944b8db 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -637,6 +637,9 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
>>   		   unsigned int pos, unsigned int count,
>>   		   void *kbuf, void __user *ubuf)
>>   {
>> +	if (!system_supports_fpsimd())
>> +		return -EINVAL;
>> +
>>   	if (target == current)
>>   		fpsimd_preserve_current_state();
> 
> I checked the coredump code (fill_thread_core_info) and works correctly
> if we return -EINVAL here. But for completeness, we could add an
> fpr_active() callback to aarch{32,64}_regsets (x86 does the same).
> 

Sure, makes sense. I have now added fpr_active() hook for the FP
regsets.

Suzuki
