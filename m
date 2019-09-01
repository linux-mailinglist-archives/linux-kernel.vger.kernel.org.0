Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75789A4931
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfIAMYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 08:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfIAMYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B77E2377B;
        Sun,  1 Sep 2019 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340688;
        bh=3YNhh06olVrzl+i+ppOuyDrMgx/l/L3cUcfv2RvlmFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUVY5W6yyXlFRwlWC3ymYslVU1hbQ8DvZz+e3H8s9b/8IeKLAsW5Phyq75dOsV0B8
         H+iJ8+5dZmW1DeyoUZDVZvrLMMAw3VbvjB9NrIsgArvir0sBtVPE6TduvSxjm//V72
         pYzBFEQL0IbVLOYtEfMVij7kORDBqhZlh7Ha8jvM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 24/47] perf symbols: Add missing linux/refcount.h to symbol.h
Date:   Sun,  1 Sep 2019 09:23:03 -0300
Message-Id: <20190901122326.5793-25-acme@kernel.org>
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

We use refcount_t there, so we need that header or else it'll break when
we remove dso.h, that is from where it is getting that definition now...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5albrk0uve6x9cf6x3ebwpae@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bcc0d84a42b8..22660c7614a5 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -3,6 +3,7 @@
 #define __PERF_SYMBOL 1
 
 #include <linux/types.h>
+#include <linux/refcount.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <linux/list.h>
-- 
2.21.0

