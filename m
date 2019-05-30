Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3FA2FA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfE3KmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 06:42:10 -0400
Received: from foss.arm.com ([217.140.101.70]:34096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3KmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:42:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10609374;
        Thu, 30 May 2019 03:42:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E85343F5AF;
        Thu, 30 May 2019 03:42:05 -0700 (PDT)
Date:   Thu, 30 May 2019 11:42:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com, mhocko@suse.com,
        ira.weiny@intel.com, david@redhat.com, cai@lca.pw,
        logang@deltatee.com, james.morse@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        mgorman@techsingularity.net, osalvador@suse.de,
        ard.biesheuvel@arm.com
Subject: Re: [PATCH V5 2/3] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Message-ID: <20190530104203.GC56046@lakrids.cambridge.arm.com>
References: <1559121387-674-1-git-send-email-anshuman.khandual@arm.com>
 <1559121387-674-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559121387-674-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:46:26PM +0530, Anshuman Khandual wrote:
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
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/ptdump_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index 064163f..80171d1 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -7,7 +7,10 @@
>  static int ptdump_show(struct seq_file *m, void *v)
>  {
>  	struct ptdump_info *info = m->private;
> +
> +	get_online_mems();
>  	ptdump_walk_pgd(m, info);
> +	put_online_mems();

We need to explicitly include <linux/memory_hotplug.h> to get the
prototypes of {get,put}_online_mems().

With that fixed up:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I understand from [1] that Michal is ok with using these here, and we're
open to reworking this if/when the hotplug locking is changed.

Mark.

[1] https://lkml.kernel.org/r/20190527072001.GB1658@dhcp22.suse.cz

>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(ptdump);
> -- 
> 2.7.4
> 
