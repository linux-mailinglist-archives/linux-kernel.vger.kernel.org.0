Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65255D930
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 02:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGCAhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 20:37:21 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:34973 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:37:21 -0400
Received: by mail-oi1-f202.google.com with SMTP id i132so327885oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MklO/nCO3vTONhpU2/Xc+PDQxZ8geoXuw22CpQ4sZO8=;
        b=qKiWSMCySfNKdrYjXhmrf6cfPbbz+oWEXvqnz1cpm0Z7vknJMNKnxJ+lQlVEm0E3hG
         RB9MJVn2xxeW/3haHy4B43l9sOPJSz9tekq/KPZSWh1be1FAzolI0qebmS2oJK4IXslI
         E1L/+HV1EWoRH9KnyHD4xeVzCWprAVojb7MrOxidOZ8BROzux7QmYFoYmx/+uLK1SX2D
         58G/T2wFKuZgk4DoXdfPCyK4TGp42G+xC48rMy1I7hzqFMoEyzh+cb+CIkDARyYfI1h1
         T5urZELFI4Fv+PnARlvjBvJrNSrFCRqIrsztsO3BARX88+dqkQv2cu5IH+wuoQj1vloo
         wACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MklO/nCO3vTONhpU2/Xc+PDQxZ8geoXuw22CpQ4sZO8=;
        b=gR57aEpcHA4yPef3ZsbLIBgXeGb+Jl65Peur8ClH+IK0AMZVGC6Rz3yp092Uhm9mXr
         33IdlWu5Kdsz/jvbOOvMB/l19nDFv5+6H6TRHOtPf8YbVkWpVite2d5WbC5lK0yqnUqM
         brITJGZfCwNR1hhwaxEySuDechTOvIMh8yfwAmyGuleOVgKS36Hux9f/a9Q96sWoe0rf
         W4CEsshHre9S5HslQV45RJaUkz2bBoYMrg1JUBtgQgOcMxvnYiu3gq8wQJVbpN6zDK7M
         BXQZtBeqLHNppBx0m69PVTYtF1+VIG1RYFtAsUDaHm4UytOPZIWqfSrlnbi01i52gWrr
         XEJQ==
X-Gm-Message-State: APjAAAWSc3vZdqB20OCZQ/qKz09yNTm2KIt4f+1YE0hhJ2rkER7aAnBP
        dPawm9UMGXc3YCqiMLM7rmcQ4JE96tLhSzbm
X-Google-Smtp-Source: APXvYqwxWC5LdWcl2/XKPgh1zut3SpHgJ3FIJ714nB1MgOY6lhh76l/rN5P/M8Kednj/Tx9T/ZAwDQyC84jyWjts
X-Received: by 2002:a65:6106:: with SMTP id z6mr20033643pgu.250.1562110550143;
 Tue, 02 Jul 2019 16:35:50 -0700 (PDT)
Date:   Tue,  2 Jul 2019 16:35:38 -0700
Message-Id: <20190702233538.52793-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3] mm/z3fold.c: Lock z3fold page before  __SetPageMovable()
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following zsmalloc.c's example we call trylock_page() and unlock_page(). 
Also make z3fold_page_migrate() assert that newpage is passed in locked,
as per the documentation.

Link: http://lkml.kernel.org/r/20190702005122.41036-1-henryburns@google.com
Signed-off-by: Henry Burns <henryburns@google.com>
Suggested-by: Vitaly Wool <vitalywool@gmail.com>
Acked-by: Vitaly Wool <vitalywool@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Vitaly Vul <vitaly.vul@sony.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Xidong Wang <wangxidong_97@163.com>
Cc: Jonathan Adams <jwadams@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 Changelog since v2:
 - Removed the WARN_ON entirely, as it is an expected code path.

 Changelog since v1:
 - Added an if statement around WARN_ON(trylock_page(page)) to avoid
   unlocking a page locked by a someone else.

 mm/z3fold.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index e174d1549734..eeb3fe7f5ca3 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -918,7 +918,16 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 		set_bit(PAGE_HEADLESS, &page->private);
 		goto headless;
 	}
-	__SetPageMovable(page, pool->inode->i_mapping);
+	if (can_sleep) {
+		lock_page(page);
+		__SetPageMovable(page, pool->inode->i_mapping);
+		unlock_page(page);
+	} else {
+		if (!trylock_page(page)) {
+			__SetPageMovable(page, pool->inode->i_mapping);
+			unlock_page(page);
+		}
+	}
 	z3fold_page_lock(zhdr);
 
 found:
@@ -1325,6 +1334,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
 
 	zhdr = page_address(page);
 	pool = zhdr_to_pool(zhdr);
-- 
2.22.0.410.gd8fdbe21b5-goog

