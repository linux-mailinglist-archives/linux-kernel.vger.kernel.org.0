Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C82A4936
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfIAMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfIAMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B39823431;
        Sun,  1 Sep 2019 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340703;
        bh=hMjftbwFQL7MRPoo81ac3G69VRq6T8wY29QobKT44Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4SK68EEw8qG+9vyxl28eOk67zJb5wNIlMZG+FsfsAr9zRTZZgl14ognmf8jQRTf9
         5k9C70InKFARj47b2HqW2g4wBQp1x6eKNHI5kpCR6iZqM8LKAaF+pX6hmW4ZWlWI4y
         uSKd8Bt8qVQohZU00rXtqI+5XqgJqU0no7a62b0o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 30/47] perf probe: No need for symbol.h, symbol_conf is enough
Date:   Sun,  1 Sep 2019 09:23:09 -0300
Message-Id: <20190901122326.5793-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Remove one more unneeded use of symbol.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vrda1tuem1o8pk82t2kfjtun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6dce1724a378..26bc5923e6b5 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -21,7 +21,7 @@
 #include "util/build-id.h"
 #include "util/strlist.h"
 #include "util/strfilter.h"
-#include "util/symbol.h"
+#include "util/symbol_conf.h"
 #include "util/debug.h"
 #include <subcmd/parse-options.h>
 #include "util/probe-finder.h"
-- 
2.21.0

