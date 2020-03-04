Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD28E178E14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgCDKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 05:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:59588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgCDKMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:12:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC46B30E;
        Wed,  4 Mar 2020 02:12:50 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 037CD3F534;
        Wed,  4 Mar 2020 02:12:47 -0800 (PST)
Subject: Re: [PATCH V14 1/2] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "david@redhat.com" <david@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <1583296123-18546-1-git-send-email-anshuman.khandual@arm.com>
 <1583296123-18546-2-git-send-email-anshuman.khandual@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <91e4cbd0-0f1d-30c6-2796-d2fb91ba6720@arm.com>
Date:   Wed, 4 Mar 2020 10:12:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583296123-18546-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2020 04:28, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
> 
> Intermediate levels of table may by freed during memory hot-remove,
> which will be enabled by a subsequent patch. To avoid racing with
> this, take the memory hotplug lock when walking the kernel page table.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

> ---
>  arch/arm64/mm/ptdump_debugfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index 1f2eae3e988b..d29d722ec3ec 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/debugfs.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/seq_file.h>
>  
>  #include <asm/ptdump.h>
> @@ -7,7 +8,10 @@
>  static int ptdump_show(struct seq_file *m, void *v)
>  {
>  	struct ptdump_info *info = m->private;
> +
> +	get_online_mems();
>  	ptdump_walk(m, info);
> +	put_online_mems();
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(ptdump);
> 

