Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8236C2FE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfE3Oyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 10:54:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:62323 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfE3Oyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:54:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 07:54:45 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2019 07:54:45 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/5] perf header: Rename "sibling cores" to "sibling sockets"
Date:   Thu, 30 May 2019 07:53:48 -0700
Message-Id: <1559228029-5876-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
References: <1559228029-5876-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The "sibling cores" actually shows the sibling CPUs of a socket.
The name "sibling cores" is very misleading.

Rename "sibling cores" to "sibling sockets"

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 tools/perf/util/header.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index c731416..dd85163 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -168,7 +168,7 @@ struct {
 };
 
 Example:
-	sibling cores   : 0-8
+	sibling sockets : 0-8
 	sibling dies	: 0-3
 	sibling dies	: 4-7
 	sibling threads : 0-1
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6497625..06ddb66 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1460,7 +1460,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 	str = ph->env.sibling_cores;
 
 	for (i = 0; i < nr; i++) {
-		fprintf(fp, "# sibling cores   : %s\n", str);
+		fprintf(fp, "# sibling sockets : %s\n", str);
 		str += strlen(str) + 1;
 	}
 
-- 
2.7.4

