Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE42A67F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEYS2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 14:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfEYS2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:28:53 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAB320863;
        Sat, 25 May 2019 18:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558808932;
        bh=o915ziI83Wq3DsJM16MhIJ37dE0MX7hNkXvLF1mxSSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c268qRQWAtxOlxLXaieeHQKVwLydKfkQ1kaOAyUmD8rZ5kPgeuW35L3VundqMz2ws
         TKpWRCTzZ8coWST9lgDMHXMzGATDQxarTquKm4ZuZQkbKIhDrGjeXU+rXigaTuPjPT
         LPC2G49gKq0gH2eeygnFjTHww2cX8TsGOwqjPKMc=
Date:   Sat, 25 May 2019 11:28:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <osalvador@suse.de>, <khandual@linux.vnet.ibm.com>,
        <mhocko@suse.com>, <mgorman@techsingularity.net>,
        <aarcange@redhat.com>, <rcampbell@nvidia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mempolicy: Fix an incorrect rebind node in
 mpol_rebind_nodemask
Message-Id: <20190525112851.ee196bcbbc33bf9e0d869236@linux-foundation.org>
In-Reply-To: <1558768043-23184-1-git-send-email-zhongjiang@huawei.com>
References: <1558768043-23184-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc Vlastimil)

On Sat, 25 May 2019 15:07:23 +0800 zhong jiang <zhongjiang@huawei.com> wrote:

> We bind an different node to different vma, Unluckily,
> it will bind different vma to same node by checking the /proc/pid/numa_maps.   
> Commit 213980c0f23b ("mm, mempolicy: simplify rebinding mempolicies when updating cpusets")
> has introduced the issue.  when we change memory policy by seting cpuset.mems,
> A process will rebind the specified policy more than one times. 
> if the cpuset_mems_allowed is not equal to user specified nodes. hence the issue will trigger.
> Maybe result in the out of memory which allocating memory from same node.
> 
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -345,7 +345,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
>  	else {
>  		nodes_remap(tmp, pol->v.nodes,pol->w.cpuset_mems_allowed,
>  								*nodes);
> -		pol->w.cpuset_mems_allowed = tmp;
> +		pol->w.cpuset_mems_allowed = *nodes;
>  	}
>  
>  	if (nodes_empty(tmp))

hm, I'm not surprised the code broke.  What the heck is going on in
there?  It used to have a perfunctory comment, but Vlastimil deleted
it.

Could someone please propose a comment for the above code block
explaining why we're doing what we do?

