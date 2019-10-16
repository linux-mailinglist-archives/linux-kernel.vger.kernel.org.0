Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14504D8A27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbfJPHsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:48:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfJPHsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:48:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0F24B9D2CACB8FF994F;
        Wed, 16 Oct 2019 15:47:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 15:47:26 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <john.garry@huawei.com>,
        <ak@linux.intel.com>, <lukemujica@google.com>,
        <kan.liang@linux.intel.com>, <yuzenghui@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] perf jevents: Fix resource leak in process_mapfile()
Message-ID: <bf113089-e3cd-50f9-f7ed-17d07512a702@huawei.com>
Date:   Wed, 16 Oct 2019 15:47:23 +0800
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

There are memory leaks and file descriptor resource leaks in
process_mapfile().

Fix this by adding free() and fclose() on the error paths.

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e2837260ca4d..6e60d4cff592 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -758,6 +758,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	char *line, *p;
 	int line_num;
 	char *tblname;
+	int ret = 0;

 	pr_info("%s: Processing mapfile %s\n", prog, fpath);

@@ -769,6 +770,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 	if (!mapfp) {
 		pr_info("%s: Error %s opening %s\n", prog, strerror(errno),
 				fpath);
+		free(line);
 		return -1;
 	}

@@ -795,7 +797,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 			/* TODO Deal with lines longer than 16K */
 			pr_info("%s: Mapfile %s: line %d too long, aborting\n",
 					prog, fpath, line_num);
-			return -1;
+			ret = -1;
+			goto out;
 		}
 		line[strlen(line)-1] = '\0';

@@ -825,7 +828,9 @@ static int process_mapfile(FILE *outfp, char *fpath)

 out:
 	print_mapping_table_suffix(outfp);
-	return 0;
+	fclose(mapfp);
+	free(line);
+	return ret;
 }

 /*
-- 
2.7.4.3

