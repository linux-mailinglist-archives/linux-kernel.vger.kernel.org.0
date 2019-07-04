Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F095FA5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGDO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 10:56:58 -0400
Received: from foss.arm.com ([217.140.110.172]:43238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfGDO46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:56:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E6428;
        Thu,  4 Jul 2019 07:56:57 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880B03F738;
        Thu,  4 Jul 2019 07:56:53 -0700 (PDT)
Subject: Re: [RFC v2 11/14] arm64: Move the ASID allocator code in a separate
 file
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        julien.thierry@arm.com, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
References: <20190620130608.17230-1-julien.grall@arm.com>
 <20190620130608.17230-12-julien.grall@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3e6c6636-8522-ab4a-0183-ae0198a7a047@arm.com>
Date:   Thu, 4 Jul 2019 15:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620130608.17230-12-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 20/06/2019 14:06, Julien Grall wrote:
> We will want to re-use the ASID allocator in a separate context (e.g
> allocating VMID). So move the code in a new file.
> 
> The function asid_check_context has been moved in the header as a static
> inline function because we want to avoid add a branch when checking if the
> ASID is still valid.

> diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
> index 3df63a28856c..b745cf356fe1 100644
> --- a/arch/arm64/mm/context.c
> +++ b/arch/arm64/mm/context.c
> @@ -23,46 +23,21 @@

> -#define ASID_FIRST_VERSION(info)	NUM_ASIDS(info)

> diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
> new file mode 100644
> index 000000000000..7252e4fdd5e9
> --- /dev/null
> +++ b/arch/arm64/lib/asid.c
> @@ -0,0 +1,185 @@

> +#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))

(oops!)


> @@ -344,7 +115,7 @@ static int asids_init(void)
>  	if (!asid_allocator_init(&asid_info, bits, ASID_PER_CONTEXT,
>  				 asid_flush_cpu_ctxt))
>  		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
> -		      1UL << bits);
> +		      NUM_ASIDS(&asid_info));

Could this go in the patch that adds NUM_ASIDS()?


Thanks,

James
