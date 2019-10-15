Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F44D6D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 05:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfJODLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 23:11:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbfJODLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:11:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1172FD442D4F658B0507;
        Tue, 15 Oct 2019 10:54:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 15 Oct 2019
 10:54:37 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] perf c2c: fix memory leak in build_cl_output()
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
Message-ID: <4d3c0178-5482-c313-98e1-f82090d2d456@huawei.com>
Date:   Tue, 15 Oct 2019 10:54:14 +0800
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

There is a memory leak problem in the failure paths of
build_cl_output(), so fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/builtin-c2c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3542b6a..e69f449 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2635,6 +2635,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	bool add_sym   = false;
 	bool add_dso   = false;
 	bool add_src   = false;
+	int ret = 0;

 	if (!buf)
 		return -ENOMEM;
@@ -2653,7 +2654,8 @@ static int build_cl_output(char *cl_sort, bool no_source)
 			add_dso = true;
 		} else if (strcmp(tok, "offset")) {
 			pr_err("unrecognized sort token: %s\n", tok);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err;
 		}
 	}

@@ -2676,13 +2678,15 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		add_sym ? "symbol," : "",
 		add_dso ? "dso," : "",
 		add_src ? "cl_srcline," : "",
-		"node") < 0)
-		return -ENOMEM;
+		"node") < 0) {
+		ret = -ENOMEM;
+		goto err;
+	}

 	c2c.show_src = add_src;
-
+err:
 	free(buf);
-	return 0;
+	return ret;
 }

 static int setup_coalesce(const char *coalesce, bool no_source)
-- 
2.7.4.3

