Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859898DD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfHNSoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:25 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF722173E;
        Wed, 14 Aug 2019 18:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808265;
        bh=26s+Eu75MbYmAVeBgL0b5vSkx33by5tDreuGUyZXoNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsVa7Jugb2QKC2WlQwFOhMENQyM8tPirj1AjprBzVXpcc8xwiDMwmoj/CjphtM4Kw
         5I/oSv1nNZAYkAv1KOx2/G/Y23UPHiX2gXF18e7XzseZGNVENVEDbGsSTSBENgDyoB
         MAQPS0XQ2zKDrm0JtNkVN6US2xTiitsdvh9HYj5k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        James Morris <jmorris@namei.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>
Subject: [PATCH 15/28] perf tools: Add CAP_SYSLOG define for older systems
Date:   Wed, 14 Aug 2019 15:40:38 -0300
Message-Id: <20190814184051.3125-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Some of the systems I test don't have that define, provide it
conditionally since we'll use it in the kptr_restrict checks in the next
patch.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-dcize2v6jjab7tds5ngz97dk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index 10af94e473da..051dc590ceee 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -24,4 +24,9 @@ static inline bool perf_cap__capable(int cap __maybe_unused)
 
 #endif /* HAVE_LIBCAP_SUPPORT */
 
+/* For older systems */
+#ifndef CAP_SYSLOG
+#define CAP_SYSLOG	34
+#endif
+
 #endif /* __PERF_CAP_H */
-- 
2.21.0

