Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15B3D5E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 11:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfJNJMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 05:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730656AbfJNJMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 716A7B8EF;
        Mon, 14 Oct 2019 09:12:44 +0000 (UTC)
Date:   Mon, 14 Oct 2019 11:12:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        jgg@ziepe.ca, aarcange@redhat.com, yang.shi@linux.alibaba.com,
        zhongjiang@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Cristopher Lameter <cl@linux.com>
Subject: Re: [PATCH] mm: mempolicy: fix the absence of the last bit of
 nodemask
Message-ID: <20191014091243.GD317@dhcp22.suse.cz>
References: <1570882789-20579-1-git-send-email-zhangpan26@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570882789-20579-1-git-send-email-zhangpan26@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Christopher - th initial emails is http://lkml.kernel.org/r/1570882789-20579-1-git-send-email-zhangpan26@huawei.com]

On Sat 12-10-19 20:19:48, Pan Zhang wrote:
>     When I want to use set_mempolicy to get the memory from each node on the numa machine,
>     and the MPOL_INTERLEAVE flag seems to achieve this goal.
>     However, during the test, it was found that the use result of node was unbalanced.
>     The memory was allocated evenly from the nodes except the last node,
>     which obviously did not match the expectations.
> 
>     You can test as follows:
> 1.  Create a file that needs to be mmap ped:
>     dd if=/dev/zero of=./test count=1024 bs=1M

This will already poppulate the page cache and if it fits into memory
(which seems to be the case in your example output) then your mmap later
will not allocate any new memory.

I suspect that using numactl --interleave 0,1 dd if=/dev/zero of=./test count=1024 bs=1M

will produce an output much closer to your expectation. Right?

[...]
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 4ae967b..a23509f 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1328,9 +1328,11 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  	unsigned long nlongs;
>  	unsigned long endmask;
>  
> -	--maxnode;
>  	nodes_clear(*nodes);
> -	if (maxnode == 0 || !nmask)
> +	/*
> +	 * If the user specified only one node, no need to set nodemask
> +	 */
> +	if (maxnode - 1 == 0 || !nmask)
>  		return 0;
>  	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
>  		return -EINVAL;

I am afraid this is a wrong fix. It is really hard to grasp the code but my
understanding is that the caller is supposed to provide maxnode larger
than than the nodemask. So if you want 2 nodes then maxnode should be 3.
Have a look at the libnuma (which is a reference implementation)

static void setpol(int policy, struct bitmask *bmp)
{
	if (set_mempolicy(policy, bmp->maskp, bmp->size + 1) < 0)
		numa_error("set_mempolicy");
}

The semantic is quite awkward but it is that way for years.
-- 
Michal Hocko
SUSE Labs
