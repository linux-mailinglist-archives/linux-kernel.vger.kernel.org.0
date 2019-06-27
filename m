Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8531058E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfF0XZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 19:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfF0XZN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:25:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F5120B7C;
        Thu, 27 Jun 2019 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561677912;
        bh=kNW9UJec5ndIC20H3O0Fi4cKff5mPU8oiMT2u9UKNAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vMJvFxPKezf+akCGBbS2o82bRQ7sHszgHAXZOe3/FHVG9GsJ/sIbmXcG2uVbE1HLh
         CNlsy5NMinvlRYEnkynhONCRaUAGWckCTwiZYlA5C2v43HxFd6ruuGrLMZ1f4QOR47
         oGngagpjO/hSp5S+6GDLPxYyDwe5gdN2ByAsgjso=
Date:   Thu, 27 Jun 2019 16:25:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5] mm/gup: speed up check_and_migrate_cma_pages() on
 huge page
Message-Id: <20190627162511.1cf10f5b04538c955c329408@linux-foundation.org>
In-Reply-To: <1561612545-28997-1-git-send-email-kernelfans@gmail.com>
References: <1561612545-28997-1-git-send-email-kernelfans@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 13:15:45 +0800 Pingfan Liu <kernelfans@gmail.com> wrote:

> Both hugetlb and thp locate on the same migration type of pageblock, since
> they are allocated from a free_list[]. Based on this fact, it is enough to
> check on a single subpage to decide the migration type of the whole huge
> page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> similar on other archs.
> 
> Furthermore, when executing isolate_huge_page(), it avoid taking global
> hugetlb_lock many times, and meanless remove/add to the local link list
> cma_page_list.
>

Thanks, looks good to me.  Have any timing measurements been taken?
 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1336,25 +1336,30 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  					struct vm_area_struct **vmas,
>  					unsigned int gup_flags)
>  {
> -	long i;
> +	long i, step;

I'll make these variables unsigned long - to match nr_pages and because
we have no need for them to be negative.

> ...
