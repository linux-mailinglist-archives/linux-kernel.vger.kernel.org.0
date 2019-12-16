Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C571202DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 11:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLPKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 05:45:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfLPKpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:45:36 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9DA3F80D36F74ABAD7E;
        Mon, 16 Dec 2019 18:45:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 16 Dec 2019 18:45:25 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <acme@redhat.com>, <jolsa@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH] perf c2c: remove unneeded semicolon
Date:   Mon, 16 Dec 2019 18:42:09 +0800
Message-ID: <20191216104209.2818-1-chenzhou10@huawei.com>
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

Fixes coccicheck warning:

./tools/perf/builtin-c2c.c:1706:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:1922:2-3: Unneeded semicolon
./tools/perf/builtin-c2c.c:2948:2-3: Unneeded semicolon

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f449..545f1f9 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1703,7 +1703,7 @@ static struct c2c_dimension *get_dimension(const char *name)
 
 		if (!strcmp(dim->name, name))
 			return dim;
-	};
+	}
 
 	return NULL;
 }
@@ -1919,7 +1919,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		FILTER_HITM(tot_hitm);
 	default:
 		break;
-	};
+	}
 
 #undef FILTER_HITM
 
@@ -2945,7 +2945,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
-- 
2.7.4

