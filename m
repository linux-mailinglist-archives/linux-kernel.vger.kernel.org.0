Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B945C741
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfGBC2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfGBC2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5687E2184E;
        Tue,  2 Jul 2019 02:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034483;
        bh=1A/E8mR4yCzy4yjCi6dD/9e2VptaQ1jfGNgA0TZLovw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALw7Wge97mb4MhwxPqVwDIr2qGlEmT0Ody9t6GhPQafYgNo9UNlLXA/CcUGhPl8oo
         lyuzN0NJ7PJtCw5vmQXl2cZhGvyj7+zb02LZuiZbjpkEQWgrLQcISf7Bmt+OujKbve
         AxxD09SF9Bc6lbpiY3gpAlL/WiN5AlDdYyfnKrb4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 30/43] perf report: Use skip_spaces()
Date:   Mon,  1 Jul 2019 23:26:03 -0300
Message-Id: <20190702022616.1259-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

No change in behaviour intended.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lcywlfqbi37nhegmhl1ar6wg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 91a3762b4211..aef59f318a67 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -941,8 +941,7 @@ parse_time_quantum(const struct option *opt, const char *arg,
 		pr_err("time quantum cannot be 0");
 		return -1;
 	}
-	while (isspace(*end))
-		end++;
+	end = skip_spaces(end);
 	if (*end == 0)
 		return 0;
 	if (!strcmp(end, "s")) {
-- 
2.20.1

