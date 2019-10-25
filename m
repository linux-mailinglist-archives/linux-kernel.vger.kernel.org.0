Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF19E41FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 05:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbfJYDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 23:16:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732607AbfJYDQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:16:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE266CE46B02804BCB4D;
        Fri, 25 Oct 2019 11:16:11 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 11:16:05 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <peterz@infradead.org>, <jolsa@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <ilubashe@akamai.com>, <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>
CC:     <hushiyuan@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] perf tools: Call closedir to release the resource before we return
Date:   Thu, 24 Oct 2019 23:16:05 -0400
Message-ID: <20191025031605.23658-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should close the directory on pattern failure before the return
of rm_rf_depth_pat.

Fixes: cdb6b0235f170 ("perf tools: Add pattern name checking to rm_rf")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/perf/util/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e19c947..1aadca8c43f3 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
+		if (!match_pat(d->d_name, pat)) {
+			closedir(dir);
 			return -2;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
-- 
2.19.1

