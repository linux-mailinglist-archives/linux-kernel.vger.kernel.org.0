Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1460BE50A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503699AbfJYP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 11:58:43 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:47772 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503625AbfJYP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:58:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TgBMTJi_1572019105;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TgBMTJi_1572019105)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 23:58:28 +0800
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map
 gone
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191025153618.ajcecye3bjm5abax@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <74becfc0-3c34-bdd2-02cd-25b763c92f3b@linux.alibaba.com>
Date:   Fri, 25 Oct 2019 08:58:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191025153618.ajcecye3bjm5abax@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 8:36 AM, Kirill A. Shutemov wrote:
> On Fri, Oct 25, 2019 at 01:27:46AM +0800, Yang Shi wrote:
>> File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
>> the flag is never cleared until the THP is freed.  This result in
>> unbalanced state although it is not a big deal.
>>
>> Clear the flag when the last compound_mapcount is gone.  It should be
>> cleared when all the PTE maps are gone (become PMD mapped only) as well,
>> but this needs check all subpage's _mapcount every time any subpage's
>> rmap is removed, the overhead may be not worth.  The anonymous THP also
>> just clears PageDoubleMap flag when the last PMD map is gone.
> NAK, sorry.
>
> The key difference with anon THP that file THP can be mapped again with
> PMD after all PMD (or all) mappings are gone.
>
> Your patch breaks the case when you map the page with PMD again while the
> page is still mapped with PTEs. Who would set PageDoubleMap() in this
> case?

Aha, yes, you are right. I missed that point. However, I'm wondering we 
might move this up a little bit like this:

diff --git a/mm/rmap.c b/mm/rmap.c
index d17cbf3..ac046fd 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1230,15 +1230,17 @@ static void page_remove_file_rmap(struct page 
*page, bool compound)
                         if (atomic_add_negative(-1, &page[i]._mapcount))
                                 nr++;
                 }
+
+               /* No PTE map anymore */
+               if (nr == HPAGE_PMD_NR)
+                       ClearPageDoubleMap(compound_head(page));
+
                 if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
                         goto out;
                 if (PageSwapBacked(page))
                         __dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
                 else
                         __dec_node_page_state(page, NR_FILE_PMDMAPPED);
-
-               /* The last PMD map is gone */
-               ClearPageDoubleMap(compound_head(page));
         } else {
                 if (!atomic_add_negative(-1, &page->_mapcount))
                         goto out;


This should guarantee no PTE map anymore, it should be safe to clear the 
flag.

>

