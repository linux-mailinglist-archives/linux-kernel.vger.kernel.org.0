Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DFB15F6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbgBNTaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:30:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39337 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:29:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so5340115pfy.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7eUMgQaKaihKgMoljstQiDj/fqDJCSe3MTjoLlLm6K8=;
        b=HbbNon0JXPwzqtzf+TMmfozNLvk2sykTlLtEXI+26GH1OYbdkXNgi6o7hpBOxidwOB
         KFFKv3yVPme1VXg0ifx4fLw0VYUqou0zJ8xp59IxrVnuUaSRbvz2wYFzBQo5UaNRyhjC
         R4GSCSFJHhxSq+IVen3hu7jDW7PZhKBnVDf7sNOwWIYA0PNocC/J/o5+wvkK75BWM8kk
         PHsUODEcORexiHE2806/gn0jETf1I/15l+7lXOiU48cNY8wDBzvDlc/bB4ss1/ciKRKW
         8syOy6ehxmQ34sZC+ogIHfRiWdYCiZLiLHXdxnIzIhwvAysEpXdIqFbDnChhPZjXatTy
         04sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7eUMgQaKaihKgMoljstQiDj/fqDJCSe3MTjoLlLm6K8=;
        b=t6pR7GISKDIe1kmvlBZedNjTw84f/s7kTNs1qM4o5VVuMnFUM96AuvIlQROtkByw0s
         pBkoE3rtblvkZKeQz/6TkVUrJuXyiazO1AEu4zEbKdsB5z3ZN0tnltiTLaaMEhHDv/EA
         xdUXJcFA+cbwozWJ4iKs5pLI1gD1IuOglhG0+bNVEcYVqrS2iWVakn1lUOc8VDq0/1vE
         HDW4BzJbrveAbxdRppEdkC4eZ2jKYYq/F3aoSeQbyaSos3TzZK2/LobGDWUAbA0Sh2cy
         OKFzvJm3ur/Bm5bSUHLmcwSgcnKaQK7Otd/TOTgL16yqf3855O5FHmRbuVPF7/H19n5+
         UYJQ==
X-Gm-Message-State: APjAAAXkY0b9fYVyONFqNAdpawzndg4/jFulb/dU8DvuCrWsXnJD2Pt6
        cJHmEvtBV5oDJ3b/UWGxUbg=
X-Google-Smtp-Source: APXvYqyPF4iOUKloQHTVRqBKuM+cBSu+Va0Xza4+5VjIfvLUiAOKoGEM9GatToa/1WIUHDsKygU70A==
X-Received: by 2002:a63:4823:: with SMTP id v35mr4960198pga.177.1581708597756;
        Fri, 14 Feb 2020 11:29:57 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d4sm7219795pjz.12.2020.02.14.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:29:56 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 2/2] mm: fix long time stall from mm_populate
Date:   Fri, 14 Feb 2020 11:29:51 -0800
Message-Id: <20200214192951.29430-2-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214192951.29430-1-minchan@kernel.org>
References: <20200214192951.29430-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically, fault handler releases mmap_sem before requesting readahead
and then it is supposed to retry lookup the page from page cache with
FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.

However, what happens if the fault handler find a page from page
cache and the page has readahead marker but are waiting under
writeback? Plus one more condition, it happens under mm_populate
which repeats faulting unless it encounters error. So let's assemble
conditions below.

       CPU 1                                                        CPU 2

- first loop
    mm_populate
     for ()
       ..
       ret = populate_vma_page_range
         __get_user_pages
           faultin_page
             handle_mm_fault
               filemap_fault
                 do_async_mmap_readahead
                   if (PageReadahead(pageA))
                     maybe_unlock_mmap_for_io
                       up_read(mmap_sem)
					                    shrink_page_list
                                                              pageout
                                                                SetPageReclaim(=SetPageReadahead)(pageA)
                                                                writepage
                                                                  SetPageWriteback(pageA)

                     page_cache_async_readahead()
		       ClearPageReadahead(pageA)
                 do_async_mmap_readahead
		 lock_page_maybe_drop_mmap
		   goto out_retry

					                    the pageA is reclaimed
							    and new pageB is populated to the file offset
							    and finally has become PG_readahead

- second loop

	  __get_user_pages
           faultin_page
             handle_mm_fault
               filemap_fault
                 do_async_mmap_readahead
                   if (PageReadahead(pageB))
                     maybe_unlock_mmap_for_io
                       up_read(mmap_sem)
					                    shrink_page_list
                                                              pageout
                                                                SetPageReclaim(=SetPageReadahead)(pageB)
                                                                writepage
                                                                  SetPageWriteback(pageB)

                     page_cache_async_readahead()
		       ClearPageReadahead(pageB)
                 do_async_mmap_readahead
		 lock_page_maybe_drop_mmap
		   goto out_retry

It could be repeated forever so it's livelock. without involving reclaim,
it could happens if ra_pages become zero by fadvise/other threads who
have same fd one doing randome while the other one is sequential
because page_cache_async_readahead has following condition check like
PageWriteback and ra_pages are never synchrnized with fadvise and
shrink_readahead_size_eio from other threads.

void page_cache_async_readahead(struct address_space *mapping,
                           unsigned long req_size)
{
        /* no read-ahead */
        if (!ra->ra_pages)
                return;

Thus, we need to limit fault retry from mm_populate like page
fault handler.

Fixes: 6b4c9f446981 ("filemap: drop the mmap_sem for all blocking operations")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/gup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 1b521e0ac1de..6f6548c63ad5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1133,7 +1133,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
- * return 0 on success, negative error code on error.
+ * return number of pages pinned on success, negative error code on error.
  *
  * vma->vm_mm->mmap_sem must be held.
  *
@@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	bool tried = false;
 
 	end = start + len;
 
@@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * double checks the vma flags, so that it won't mlock pages
 		 * if the vma was already munlocked.
 		 */
-		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		ret = populate_vma_page_range(vma, nstart, nend,
+						tried ? NULL : &locked);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;
 				continue;	/* continue at next VMA */
 			}
 			break;
-		}
+		} else if (ret == 0)
+			tried = true;
+		else
+			tried = false;
 		nend = nstart + ret * PAGE_SIZE;
 		ret = 0;
 	}
-- 
2.25.0.265.gbab2e86ba0-goog

