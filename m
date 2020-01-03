Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A8C12F897
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgACNF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 08:05:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:23936 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgACNF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 08:05:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 05:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="214460872"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2020 05:05:52 -0800
Date:   Fri, 3 Jan 2020 21:05:54 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20200103130554.GA20078@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20200103071846.GA16057@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103071846.GA16057@richard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 03:18:46PM +0800, Wei Yang wrote:
>On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
>>When page is not NULL, function is called by try_to_unmap_one() with
>>TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
>>with TTU_SPLIT_HUGE_PMD set:
>>
>>  * unmap_page()
>>  * shrink_page_list()
>>
>>In both case, the page passed to try_to_unmap_one() is PageHead() of the
>>THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
>>aligned, this means the THP is not mapped as PMD THP in this process.
>>This could happen when we do mremap() a PMD size range to an un-aligned
>>address.
>>
>>Currently, this case is handled by following check in __split_huge_pmd()
>>luckily.
>>
>>  page != pmd_page(*pmd)
>>
>>This patch checks the address to skip some work.
>
>I am sorry to forget address Kirill's comment in 1st version.
>
>The first one is the performance difference after this change for a PTE
>mappged THP.
>
>Here is the result:(in cycle)
>
>        Before     Patched
>
>        963        195
>        988        40
>        895        78
>
>Average 948        104
>
>So the change reduced 90% time for function split_huge_pmd_address().
>
>For the 2nd comment, the vma check. Let me take a further look to analysis.
>
>Thanks for Kirill's suggestion.
>

For 2nd comment, check vma could hold huge page.

You mean do this check ?

  vma->vm_start <= address && vma->vm_end >= address + HPAGE_PMD_SIZE

This happens after munmap a partial of the THP range? After doing so, we can
skip split_pmd for this case.

>>
>>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>
>>---
>>v2: move the check into split_huge_pmd_address().
>>---
>> mm/huge_memory.c | 16 ++++++++++++++++
>> 1 file changed, 16 insertions(+)
>>
>>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>index 893fecd5daa4..2b9c2f412b32 100644
>>--- a/mm/huge_memory.c
>>+++ b/mm/huge_memory.c
>>@@ -2342,6 +2342,22 @@ void split_huge_pmd_address(struct vm_area_struct *vma, unsigned long address,
>> 	pud_t *pud;
>> 	pmd_t *pmd;
>> 
>>+	/*
>>+	 * When page is not NULL, function is called by try_to_unmap_one()
>>+	 * with TTU_SPLIT_HUGE_PMD set. There are two places set
>>+	 * TTU_SPLIT_HUGE_PMD
>>+	 *
>>+	 *     unmap_page()
>>+	 *     shrink_page_list()
>>+	 *
>>+	 * In both cases, the "page" here is the PageHead() of a THP.
>>+	 *
>>+	 * If the page is not a PMD mapped huge page, e.g. after mremap(), it
>>+	 * is not necessary to split it.
>>+	 */
>>+	if (page && !IS_ALIGNED(address, HPAGE_PMD_SIZE))
>>+		return;
>>+
>> 	pgd = pgd_offset(vma->vm_mm, address);
>> 	if (!pgd_present(*pgd))
>> 		return;
>>-- 
>>2.17.1
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
