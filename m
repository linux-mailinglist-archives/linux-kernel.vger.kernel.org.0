Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16015C73D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGBC1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfGBC1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416352184B;
        Tue,  2 Jul 2019 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034464;
        bh=0gp0hhSKGr51ybaJ2Ay2poQc8sbI4neS9U5RU3MTndo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaxmhF5Sx6HRLr2q1LlmMga4t92C213XrTAGMX04+FK88IcQXx8UC9p1pMKFV0Wrh
         fLNtXM5qz1lHFaC2NoFrMxmITZ/kcqhZDSu8EP2zXTaBpJZWmBY3KXKmYeHeBRK6rp
         X3d150St4fqwtlWyhtiYB78lOvPB9Ws/HpL+uT1E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 26/43] perf time-utils: Use skip_spaces()
Date:   Mon,  1 Jul 2019 23:25:59 -0300
Message-Id: <20190702022616.1259-27-acme@kernel.org>
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
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cpugv7qd5vzhbtvnlydo90jv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 369fa19dd596..c2abc259b51d 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
+#include <linux/string.h>
 #include <sys/time.h>
 #include <linux/time64.h>
 #include <time.h>
@@ -141,10 +142,7 @@ static int perf_time__parse_strs(struct perf_time_interval *ptime,
 	for (i = 0, p = str; i < num - 1; i++) {
 		arg = p;
 		/* Find next comma, there must be one */
-		p = strchr(p, ',') + 1;
-		/* Skip white space */
-		while (isspace(*p))
-			p++;
+		p = skip_spaces(strchr(p, ',') + 1);
 		/* Skip the value, must not contain space or comma */
 		while (*p && !isspace(*p)) {
 			if (*p++ == ',') {
-- 
2.20.1

