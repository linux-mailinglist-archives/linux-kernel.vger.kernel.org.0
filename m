Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22E5137641
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgAJSlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 13:41:52 -0500
Received: from foss.arm.com ([217.140.110.172]:49904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgAJSlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:41:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D11E830E;
        Fri, 10 Jan 2020 10:41:51 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8B03F6C4;
        Fri, 10 Jan 2020 10:41:50 -0800 (PST)
Subject: Re: [PATCH v2 2/7] arm64: fpsimd: Make sure SVE setup is complete
 before SIMD is used
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        dave.martin@arm.com, ard.biesheuvel@linaro.org,
        christoffer.dall@arm.com, Will Deacon <will.deacon@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
 <20191217183402.2259904-3-suzuki.poulose@arm.com>
 <20200110115132.GA8786@arrakis.emea.arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <aa5a4242-7684-4212-f03e-fdf3a5784dfb@arm.com>
Date:   Fri, 10 Jan 2020 18:41:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110115132.GA8786@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2020 11:51, Catalin Marinas wrote:
> On Tue, Dec 17, 2019 at 06:33:57PM +0000, Suzuki K Poulose wrote:
>> In-kernel users of NEON rely on may_use_simd() to check if the SIMD
>> can be used. However, we must initialize the SVE before SIMD can
>> be used. Add a sanity check to make sure that we have completed the
>> SVE setup before anyone uses the SIMD.
>>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Discussion here : https://lkml.kernel.org/r/20191014145204.GS27757@arm.com
> 
> Re-reading this thread, I think the conclusion was more towards having a
> WARN_ON in system_supports_fpsimd() (or may_use_simd()). We don't expect
> code to start using neon before the SMP is initialised (other than
> early_initcall(), the rest run after the secondary CPUs are brought up).

Thanks for pointing out. I missed this from the Dave's last email.
I have added a WARN_ON(!system_capabilities_finalized()) to
may_use_simd() for the next version.

Thanks for the review !

Suzuki
