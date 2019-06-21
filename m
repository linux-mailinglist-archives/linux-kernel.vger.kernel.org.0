Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE54EDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 19:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFURkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 13:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfFURkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:46 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF18A208CA;
        Fri, 21 Jun 2019 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138846;
        bh=FL42HRIkynlf5B218/KBo3nT/+5L0TGZCKqZ5DgCUzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASVUHpvSttaQSpn4dvYOFvJw0rYQ0KFulbNQmizhswGEI+9OJYA1l+HtNCiEOWWt1
         ++XkdpLu5QxMYf+4NpJ1T3VXM3RVnie/Z+luNLg2ZdBHLl2tTen02qMVdsugQygmMf
         E1RAMS+jKxo8bspt/TNosJyc4L8uW/HKf2QLfh5U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 17/25] tools build feature tests: Add missing SPDX headers
Date:   Fri, 21 Jun 2019 14:38:23 -0300
Message-Id: <20190621173831.13780-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3h6fa866w6ao0wsbyqz9nrm8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-fortify-source.c | 1 +
 tools/build/feature/test-hello.c          | 1 +
 tools/build/feature/test-setns.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-fortify-source.c b/tools/build/feature/test-fortify-source.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-fortify-source.c
+++ b/tools/build/feature/test-fortify-source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-hello.c b/tools/build/feature/test-hello.c
index c9f398d87868..c8a57194f9f2 100644
--- a/tools/build/feature/test-hello.c
+++ b/tools/build/feature/test-hello.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 
 int main(void)
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 4a1581ae7a55..2757c201ed50 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 #include <sched.h>
 
-- 
2.20.1

