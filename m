Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A83DD8B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391602AbfJPIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:39:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfJPIjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:39:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E7ABE0BD387906DB3AB;
        Wed, 16 Oct 2019 16:39:07 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 16:38:57 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] perf kmem: Fix memory leak in compact_gfp_flags()
Message-ID: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
Date:   Wed, 16 Oct 2019 16:38:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory @orig_flags is allocated by strdup(), it is freed on the
normal path, but leak to free on the error path.

Fix this by adding free(orig_flags) on the error path.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/builtin-kmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 1e61e353f579..9661671cc26e 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
 			new = realloc(new_flags, len + strlen(cpt) + 2);
 			if (new == NULL) {
 				free(new_flags);
+				free(orig_flags);
 				return NULL;
 			}

-- 
2.7.4.3

