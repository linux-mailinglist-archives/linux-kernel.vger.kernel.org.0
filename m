Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6B5C73C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGBC1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfGBC1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C647B2183F;
        Tue,  2 Jul 2019 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034460;
        bh=MTGr4Wr3O0T6/SeIK/FuiSh+Gq6ZYdpm/3tYuPNiGEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbBgubxKb6S0VOlngYkYP5sdrCkmDGp0iBUKJoc8/zUOzkRXiFk4OR85w63iC6Ygq
         +Jxq/yT9eD8uwnagmmtviVKUcyrKQ14eH7yzcUFeBn9+2oa7Ay6EXIG9jYJ8UgpI+w
         n4vU1I5FVGYxcaGHkscCd4SbAzEl8/3T6bvU2314=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 25/43] perf header: Use skip_spaces() in __write_cpudesc()
Date:   Mon,  1 Jul 2019 23:25:58 -0300
Message-Id: <20190702022616.1259-26-acme@kernel.org>
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

No change in behaviour.

Cc: Stephane Eranian <eranian@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0dbfpi70aa66s6mtd8z6p391@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fca9dbaf61ae..1eb15f7517b0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/stringify.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
@@ -416,10 +417,8 @@ static int __write_cpudesc(struct feat_fd *ff, const char *cpuinfo_proc)
 	while (*p) {
 		if (isspace(*p)) {
 			char *r = p + 1;
-			char *q = r;
+			char *q = skip_spaces(r);
 			*p = ' ';
-			while (*q && isspace(*q))
-				q++;
 			if (q != (p+1))
 				while ((*r++ = *q++));
 		}
-- 
2.20.1

