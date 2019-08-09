Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9180C87DF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407385AbfHIPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 11:24:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHIPYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58AA930C2425;
        Fri,  9 Aug 2019 15:24:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 95D7260600;
        Fri,  9 Aug 2019 15:24:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  9 Aug 2019 17:24:07 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:24:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 5/6] khugepaged: enable collapse pmd for pte-mapped
 THP
Message-ID: <20190809152404.GA21489@redhat.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-6-songliubraving@fb.com>
 <20190808163303.GB7934@redhat.com>
 <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770B3C29-CE8F-4228-8992-3C6E2B5487B6@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 09 Aug 2019 15:24:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08, Song Liu wrote:
>
> > On Aug 8, 2019, at 9:33 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> >> +	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
> >> +		pte_t *pte = pte_offset_map(pmd, addr);
> >> +		struct page *page;
> >> +
> >> +		if (pte_none(*pte))
> >> +			continue;
> >> +
> >> +		page = vm_normal_page(vma, addr, *pte);

just noticed... shouldn't you also check pte_present() before
vm_normal_page() ?

> >> +		if (!page || !PageCompound(page))
> >> +			return;
> >> +
> >> +		if (!hpage) {
> >> +			hpage = compound_head(page);
> >
> > OK,
> >
> >> +			if (hpage->mapping != vma->vm_file->f_mapping)
> >> +				return;
> >
> > is it really possible? May be WARN_ON(hpage->mapping != vm_file->f_mapping)
> > makes more sense ?
>
> I haven't found code paths lead to this,

Neither me, that is why I asked. I think this should not be possible,
but again this is not my area.

> but this is technically possible.
> This pmd could contain subpages from different THPs.

Then please explain how this can happen ?

> The __replace_page()
> function in uprobes.c creates similar pmd.

No it doesn't,

> Current uprobe code won't really create this problem, because
> !PageCompound() check above is sufficient. But it won't be difficult to
> modify uprobe code to break this.

I bet it will be a) difficult and b) the very idea to do this would be wrong.

> For this code to be accurate and safe,
> I think both this check and the one below are necessary.

I didn't suggest to remove these checks.

> Also, this code
> is not on any critical path, so the overhead should be negligible.

I do not care about overhead. But I do care about a poor reader like me
who will try to understand this code.

If you too do not understand how a THP page can have a different mapping
then use VM_WARN or at least add a comment to explain that this is not
supposed to happen!

> Does this make sense?

Not to me :/

Oleg.

