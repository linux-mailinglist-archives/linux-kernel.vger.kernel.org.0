Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10F72DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 13:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfGXLhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 07:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfGXLhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 07:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 748FC30BD1B1;
        Wed, 24 Jul 2019 11:37:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53FB760BCE;
        Wed, 24 Jul 2019 11:37:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Jul 2019 13:37:14 +0200 (CEST)
Date:   Wed, 24 Jul 2019 13:37:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, peterz@infradead.org,
        rostedt@goodmis.org, kernel-team@fb.com,
        william.kucharski@oracle.com
Subject: Re: [PATCH v8 2/4] uprobe: use original page when all uprobes are
 removed
Message-ID: <20190724113711.GE21599@redhat.com>
References: <20190724083600.832091-1-songliubraving@fb.com>
 <20190724083600.832091-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724083600.832091-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 11:37:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24, Song Liu wrote:
>
>  	lock_page(old_page);
> @@ -177,15 +180,24 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>  	mmu_notifier_invalidate_range_start(&range);
>  	err = -EAGAIN;
>  	if (!page_vma_mapped_walk(&pvmw)) {
> -		mem_cgroup_cancel_charge(new_page, memcg, false);
> +		if (!orig)
> +			mem_cgroup_cancel_charge(new_page, memcg, false);
>  		goto unlock;
>  	}
>  	VM_BUG_ON_PAGE(addr != pvmw.address, old_page);
>  
>  	get_page(new_page);
> -	page_add_new_anon_rmap(new_page, vma, addr, false);
> -	mem_cgroup_commit_charge(new_page, memcg, false, false);
> -	lru_cache_add_active_or_unevictable(new_page, vma);
> +	if (orig) {
> +		lock_page(new_page);  /* for page_add_file_rmap() */
> +		page_add_file_rmap(new_page, false);


Shouldn't we re-check new_page->mapping after lock_page() ? Or we can't
race with truncate?


and I am worried this code can try to lock the same page twice...
Say, the probed application does MADV_DONTNEED and then writes "int3"
into vma->vm_file at the same address to fool verify_opcode().

Oleg.

