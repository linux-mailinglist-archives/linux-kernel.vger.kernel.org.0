Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95AF5C72E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 04:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGBC1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 22:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfGBC1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E0221852;
        Tue,  2 Jul 2019 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034422;
        bh=nw/3dLXY+HUxm5V7t5UthDoL89MR/SHeZ+0mBQSZWkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bztYNAYT9Ed/ZDP4UNZJTKFgXCyJAD4Apv5MhSf6GMQKfOmioDOoGu1qjXuGErvHp
         aVdo+9R/e1myGdnNtT5bz+TkE2f5JeXjGZl5A+SmYVTjN28LtICmjUOgfd/EU5dpk3
         OiGG8KbEu88rFSgd1KRG6iJui8tIjapiROe0HWzs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/43] perf ctype: Remove unused 'graph_line' variable
Date:   Mon,  1 Jul 2019 23:25:45 -0300
Message-Id: <20190702022616.1259-13-acme@kernel.org>
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

Not being used at all anywhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1e567f8tn8m4ii7dy1w9dp39@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ctype.c      | 4 ----
 tools/perf/util/sane_ctype.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/tools/perf/util/ctype.c b/tools/perf/util/ctype.c
index ee4c1e8ed54b..8d90bf8d0d70 100644
--- a/tools/perf/util/ctype.c
+++ b/tools/perf/util/ctype.c
@@ -31,10 +31,6 @@ unsigned char sane_ctype[256] = {
 	/* Nothing in the 128.. range */
 };
 
-const char *graph_line =
-	"_____________________________________________________________________"
-	"_____________________________________________________________________"
-	"_____________________________________________________________________";
 const char *graph_dotted_line =
 	"---------------------------------------------------------------------"
 	"---------------------------------------------------------------------"
diff --git a/tools/perf/util/sane_ctype.h b/tools/perf/util/sane_ctype.h
index c2b42ff9ff32..894594fdedfb 100644
--- a/tools/perf/util/sane_ctype.h
+++ b/tools/perf/util/sane_ctype.h
@@ -2,7 +2,6 @@
 #ifndef _PERF_SANE_CTYPE_H
 #define _PERF_SANE_CTYPE_H
 
-extern const char *graph_line;
 extern const char *graph_dotted_line;
 extern const char *spaces;
 extern const char *dots;
-- 
2.20.1

