Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3462017A3D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 12:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCELMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 06:12:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbgCELMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 06:12:36 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D0716A99F7048320C62;
        Thu,  5 Mar 2020 19:12:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Mar 2020 19:12:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] perf jevents: Fix leak of mapfile memory
Date:   Thu, 5 Mar 2020 19:08:01 +0800
Message-ID: <1583406486-154841-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory for global pointer is never freed during normal program
execution, so let's do that in the main function exit as a good programming
practice.

A stray blank line is also removed.

Reported-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b6a2fd..27b4da80f751 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -1082,10 +1082,9 @@ static int process_one_file(const char *fpath, const struct stat *sb,
  */
 int main(int argc, char *argv[])
 {
-	int rc;
+	int rc, ret = 0;
 	int maxfds;
 	char ldirname[PATH_MAX];
-
 	const char *arch;
 	const char *output_file;
 	const char *start_dirname;
@@ -1156,7 +1155,8 @@ int main(int argc, char *argv[])
 		/* Make build fail */
 		fclose(eventsfp);
 		free_arch_std_events();
-		return 1;
+		ret = 1;
+		goto out_free_mapfile;
 	} else if (rc) {
 		goto empty_map;
 	}
@@ -1174,14 +1174,17 @@ int main(int argc, char *argv[])
 		/* Make build fail */
 		fclose(eventsfp);
 		free_arch_std_events();
-		return 1;
+		ret = 1;
 	}
 
-	return 0;
+
+	goto out_free_mapfile;
 
 empty_map:
 	fclose(eventsfp);
 	create_empty_mapping(output_file);
 	free_arch_std_events();
-	return 0;
+out_free_mapfile:
+	free(mapfile);
+	return ret;
 }
-- 
2.17.1

