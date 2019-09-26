Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF6BE9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 02:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbfIZAfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 20:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390002AbfIZAft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:49 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D67222C3;
        Thu, 26 Sep 2019 00:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458148;
        bh=dVyZPjQRfv3xE5/V0kqvWWL9NliAit4cOL5rMsrTlys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xedUBjDA1GS6N1Ezms3bKodD7WVLWlxTUFZJiqRLhKa6KmtLT0TU5K+/KS8VRcDi2
         fbxKDzNC445jf4BcBdOeHnkZpslugr6WZ9iYqRq9HSqEr0FCSh3KDrqbnq5PYeqfyp
         7YPDtZvRLugRZ5lqJ8UMDXvFpPnV+KluS8eIlXsU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 47/66] perf tools: No need to include internal/lib.h from util/util.h
Date:   Wed, 25 Sep 2019 21:32:25 -0300
Message-Id: <20190926003244.13962-48-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That was done just to have users of writen() and readn(), that before
had their prototypes in util/util.h to get it without having to add an
include for internal/lib.h, but the right way is to add it and by now
all places already do it.

Fix a fallout were readlink() was used but unistd.h was being obtained
by luck thru util.h -> internal/lib.h, now to check why unistd.h is
being included there...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lcnytgrtafey3kwlfog2rzzj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sdt.c | 1 +
 tools/perf/util/util.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index cf1bd57d3023..60f0e9ee04fb 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -3,6 +3,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <sys/epoll.h>
 #include <util/symbol.h>
 #include <linux/filter.h>
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index d6ae394e67c4..b78b73e5bb32 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,7 +11,6 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
-#include <internal/lib.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-- 
2.21.0

