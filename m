Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB6FB27D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 15:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKMOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 09:24:16 -0500
Received: from foss.arm.com ([217.140.110.172]:53370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKMOYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:24:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C5D7A7;
        Wed, 13 Nov 2019 06:24:15 -0800 (PST)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A14F3F6C4;
        Wed, 13 Nov 2019 06:24:14 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH -next] KVM: arm: remove duplicate include
To:     YueHaibing <yuehaibing@huawei.com>, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191113014045.15276-1-yuehaibing@huawei.com>
Message-ID: <daa269a8-17d2-b568-8287-7606ccd9e200@arm.com>
Date:   Wed, 13 Nov 2019 14:24:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113014045.15276-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2019 01:40, YueHaibing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks for spotting - I'm not sure how that happened! This
Fixes: 8564d6372a7d ("KVM: arm64: Support stolen time reporting via shared structure")
although I don't think it causes any actual harm.

Steve

> ---
>  virt/kvm/arm/arm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 12e0280..d910a03 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -20,8 +20,6 @@
>  #include <linux/irqbypass.h>
>  #include <linux/sched/stat.h>
>  #include <trace/events/kvm.h>
> -#include <kvm/arm_pmu.h>
> -#include <kvm/arm_psci.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> 

