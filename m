Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DC4158D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 12:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBKLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 06:39:10 -0500
Received: from relay.sw.ru ([185.231.240.75]:54562 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgBKLjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:39:10 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j1TsX-0007P4-KK; Tue, 11 Feb 2020 14:38:57 +0300
Subject: [PATCH] mm: Add missed mem_cgroup_iter_break() into
 shrink_node_memcgs()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, guro@fb.com, vvs@virtuozzo.com,
        ktkhai@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Feb 2020 14:38:57 +0300
Message-ID: <158142103093.888182.8911729633457501747.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving mem_cgroup_iter() loop requires mem_cgroup_iter_break().

Fixes: bf8d5d52ffe8 "memcg: introduce memory.min"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1863de475fb..f6efe2348ba3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2653,8 +2653,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 				continue;
 			}
 			memcg_memory_event(memcg, MEMCG_LOW);
-			break;
+			/* fallthrough */
 		case MEMCG_PROT_NONE:
+			mem_cgroup_iter_break(target_memcg, memcg);
 			/*
 			 * All protection thresholds breached. We may
 			 * still choose to vary the scan pressure


