Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E439DB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfH0Bh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfH0BhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73B322CBB;
        Tue, 27 Aug 2019 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869844;
        bh=H9EbqBnwIZezyKkpEqZLoVVjIR3m2WWP0OVEGXntGpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bfxxjs4k9/3V8d/4OlwmnKZcjOuTGsukTR+BE8g3/LgEcI6XF3dLxmRdepJ/kXx7z
         4epr/41PPc1HbcXS8eb3sHj13ZvD7BuV153HNlDxCKaVRci6dz0Ks0VjFgcEZNmqWy
         z3eoOWJnBXnu9RoLYfk5hhnqunCwyeYgGbZjWplk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/33] perf report: Use timestamp__scnprintf_nsec() for time sort key
Date:   Mon, 26 Aug 2019 22:36:15 -0300
Message-Id: <20190827013634.3173-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Use timestamp__scnprintf_nsec() to print nanoseconds for the time sort
key, instead of open coding.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190823210338.12360-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c522bdde3f71..83eb3fa6f941 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -670,17 +670,11 @@ sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
 static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	unsigned long secs;
-	unsigned long long nsecs;
 	char he_time[32];
 
-	nsecs = he->time;
-	secs = nsecs / NSEC_PER_SEC;
-	nsecs -= secs * NSEC_PER_SEC;
-
 	if (symbol_conf.nanosecs)
-		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
-			 secs, nsecs);
+		timestamp__scnprintf_nsec(he->time, he_time,
+					  sizeof(he_time));
 	else
 		timestamp__scnprintf_usec(he->time, he_time,
 					  sizeof(he_time));
-- 
2.21.0

