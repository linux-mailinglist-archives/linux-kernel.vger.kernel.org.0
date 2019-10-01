Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBBC2F75
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfJAJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 05:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbfJAJCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:02:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0702373A62;
        Tue,  1 Oct 2019 09:02:05 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-182.ams2.redhat.com [10.36.117.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 824F0611DE;
        Tue,  1 Oct 2019 09:02:01 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v1 3/3] xen/balloon: Clear PG_offline in balloon_retrieve()
Date:   Tue,  1 Oct 2019 11:01:52 +0200
Message-Id: <20191001090152.1770-4-david@redhat.com>
In-Reply-To: <20191001090152.1770-1-david@redhat.com>
References: <20191001090152.1770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Oct 2019 09:02:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the clearing to balloon_retrieve(). In
bp_state increase_reservation(), we now clear the flag a little earlier
than before, however, this should not matter for XEN.

Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/balloon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 8c245e99bb06..5bae515c8e25 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -189,6 +189,7 @@ static struct page *balloon_retrieve(bool require_lowmem)
 	else
 		balloon_stats.balloon_low--;
 
+	__ClearPageOffline(page);
 	return page;
 }
 
@@ -440,7 +441,6 @@ static enum bp_state increase_reservation(unsigned long nr_pages)
 		xenmem_reservation_va_mapping_update(1, &page, &frame_list[i]);
 
 		/* Relinquish the page back to the allocator. */
-		__ClearPageOffline(page);
 		free_reserved_page(page);
 	}
 
@@ -606,7 +606,6 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	while (pgno < nr_pages) {
 		page = balloon_retrieve(true);
 		if (page) {
-			__ClearPageOffline(page);
 			pages[pgno++] = page;
 #ifdef CONFIG_XEN_HAVE_PVMMU
 			/*
-- 
2.21.0

