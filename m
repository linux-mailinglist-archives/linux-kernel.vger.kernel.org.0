Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE361967B1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgC1QqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:46:07 -0400
Received: from mx.sdf.org ([205.166.94.20]:50095 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbgC1Qn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:27 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhJns017800
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:19 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhJ8Y024747;
        Sat, 28 Mar 2020 16:43:19 GMT
Message-Id: <202003281643.02SGhJ8Y024747@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 16:44:33 -0500
Subject: [RFC PATCH v1 31/50] lib/nodemask.c: Use cheaper prandom_u32_max() in
 node_random()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is to spread things around uniformly; cryptographic
unguessability is not required.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mel Gorman <mgorman@suse.de>
---
 lib/nodemask.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/nodemask.c b/lib/nodemask.c
index 3aa454c54c0de..330f9c7d3da97 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -25,7 +25,7 @@ int node_random(const nodemask_t *maskp)
 	w = nodes_weight(*maskp);
 	if (w)
 		bit = bitmap_ord_to_pos(maskp->bits,
-			get_random_int() % w, MAX_NUMNODES);
+			prandom_u32_max(w), MAX_NUMNODES);
 	return bit;
 }
 #endif
-- 
2.26.0

