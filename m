Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3931C829AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 04:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfHFCcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 22:32:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731306AbfHFCcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:32:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BC7D11547BD51E5C9F0;
        Tue,  6 Aug 2019 10:32:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Tue, 6 Aug 2019 10:31:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>
Subject: [PATCH] mm/mempolicy.c: Remove unnecessary nodemask check in kernel_migrate_pages()
Date:   Tue, 6 Aug 2019 10:36:34 +0800
Message-ID: <20190806023634.55356-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) task_nodes = cpuset_mems_allowed(current);
   -> cpuset_mems_allowed() guaranteed to return some non-empty
      subset of node_states[N_MEMORY].

2) nodes_and(*new, *new, task_nodes);
   -> after nodes_and(), the 'new' should be empty or appropriate
      nodemask(online node and with memory).

After 1) and 2), we could remove unnecessary check whether the 'new'
AND node_states[N_MEMORY] is empty.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

[QUESTION]

SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
                const unsigned long __user *, old_nodes,
                const unsigned long __user *, new_nodes)
{
        return kernel_migrate_pages(pid, maxnode, old_nodes, new_nodes);
}

The migrate_pages() takes pid argument, witch is the ID of the process
whose pages are to be moved. should the cpuset_mems_allowed(current) be
cpuset_mems_allowed(task)?

 mm/mempolicy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f48693f75b37..fceb44066184 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1467,10 +1467,6 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 	if (nodes_empty(*new))
 		goto out_put;
 
-	nodes_and(*new, *new, node_states[N_MEMORY]);
-	if (nodes_empty(*new))
-		goto out_put;
-
 	err = security_task_movememory(task);
 	if (err)
 		goto out_put;
-- 
2.20.1

