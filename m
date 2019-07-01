Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3720035755
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFEHDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 03:03:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfFEHDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:03:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D4C8ADE0;
        Wed,  5 Jun 2019 07:03:14 +0000 (UTC)
Date:   Wed, 5 Jun 2019 09:03:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605070312.GB15685@dhcp22.suse.cz>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605060229.GA9468@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-06-19 11:32:29, Bharath Vedartham wrote:
> In __alloc_pages_node, there is a VM_BUG_ON on the condition (nid < 0 ||
> nid >= MAX_NUMNODES). Remove this VM_BUG_ON and add a VM_WARN_ON, if the
> condition fails and fail the allocation if an invalid NUMA node id is
> passed to __alloc_pages_node.

What is the motivation of the patch? VM_BUG_ON is not enabled by default
and your patch adds a branch to a really hot path. Why is this an
improvement for something that shouldn't happen in the first place?

> 
> The check (nid < 0 || nid >= MAX_NUMNODES) also considers NUMA_NO_NODE
> as an invalid nid, but the caller of __alloc_pages_node is assumed to
> have checked for the case where nid == NUMA_NO_NODE.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  include/linux/gfp.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 5f5e25f..075bdaf 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -480,7 +480,11 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order, int preferred_nid)
>  static inline struct page *
>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>  {
> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> +	if (nid < 0 || nid >= MAX_NUMNODES) {
> +		VM_WARN_ON(nid < 0 || nid >= MAX_NUMNODES);
> +		return NULL; 
> +	}
> +
>  	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
>  
>  	return __alloc_pages(gfp_mask, order, nid);
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
