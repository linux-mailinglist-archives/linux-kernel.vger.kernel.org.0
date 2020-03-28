Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586681967B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC1QqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:46:11 -0400
Received: from mx.sdf.org ([205.166.94.20]:50100 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbgC1Qn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:26 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhPTa005210
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:25 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhPmY017434;
        Sat, 28 Mar 2020 16:43:25 GMT
Message-Id: <202003281643.02SGhPmY017434@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Thu, 3 Oct 2019 05:51:56 -0400
Subject: [RFC PATCH v1 46/50] mm/shuffle.c: use get_random_max()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have it, this is an example of where it helps.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/shuffle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index b3fe97fd66541..e0ed247f8d907 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -135,7 +135,7 @@ void __meminit __shuffle_zone(struct zone *z)
 			 * in the zone.
 			 */
 			j = z->zone_start_pfn +
-				ALIGN_DOWN(get_random_long() % z->spanned_pages,
+				ALIGN_DOWN(get_random_max(z->spanned_pages),
 						order_pages);
 			page_j = shuffle_valid_page(j, order);
 			if (page_j && page_j != page_i)
-- 
2.26.0

