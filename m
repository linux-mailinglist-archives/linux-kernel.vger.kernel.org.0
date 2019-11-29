Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8610D07A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 02:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK2B7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 20:59:32 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:43577 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK2B7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:59:32 -0500
X-Greylist: delayed 1800 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2019 20:59:31 EST
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 29 Nov 2019 10:29:30 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.31.96)
        by 156.147.1.151 with ESMTP; 29 Nov 2019 10:29:30 +0900
X-Original-SENDERIP: 10.178.31.96
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        seungho1.park@lge.com, Inkyu Hwang <inkyu.hwang@lge.com>,
        Jinsuk Choi <jjinsuk.choi@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] mm/zsmalloc.c: fix the migrated zspage statistics.
Date:   Fri, 29 Nov 2019 10:29:27 +0900
Message-Id: <1574990967-23391-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When zspage is migrated to the other zone, the zone page state should
be updated as well.

Signed-off-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Jinsuk Choi <jjinsuk.choi@lge.com>
---
 mm/zsmalloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2b2b9aa..22d17ec 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2069,6 +2069,11 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		zs_pool_dec_isolated(pool);
 	}
 
+	if (page_zone(newpage) != page_zone(page)) {
+		dec_zone_page_state(page, NR_ZSPAGES);
+		inc_zone_page_state(newpage, NR_ZSPAGES);
+	}
+
 	reset_page(page);
 	put_page(page);
 	page = newpage;
-- 
2.7.4

