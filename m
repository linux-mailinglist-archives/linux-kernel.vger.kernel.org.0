Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBB9A197
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393404AbfHVVCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393383AbfHVVB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:57 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8142E23402;
        Thu, 22 Aug 2019 21:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507716;
        bh=8MBi4J11QXg+Nw3fMASk8wV3rYOoGa64GhozdjPK20Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2XcE6Alz0G5nJafL9m11ShkrvOja+5b99k89106sbdevO3muolg2s8nZFTVqrmfN
         XrEAshSIZi289WIy6X0MMf7EbFU4KiCqkjr/9rplYzkRJ2M9iZ0rApp7kiqlFyUDaB
         EX821FfiFQpZb0dM5rDjzdz4IFLLYnfqKsgQjXJ4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 11/25] perf evlist: Add missing xyarray.h header
Date:   Thu, 22 Aug 2019 18:00:46 -0300
Message-Id: <20190822210100.3461-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It gets it very indirectly, via evsel.h -> counts.h, and since counts.h
doesn't need xyarray.h at all, add it here before we remove it there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hkizv6gojwfklj9ezaiiztll@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8582560b59af..68b7c949017e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -37,6 +37,8 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 
+#include <internal/xyarray.h>
+
 #ifdef LACKS_SIGQUEUE_PROTOTYPE
 int sigqueue(pid_t pid, int sig, const union sigval value);
 #endif
-- 
2.21.0

