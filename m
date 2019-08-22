Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A96799A198
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393435AbfHVVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393410AbfHVVCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:01 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648822341C;
        Thu, 22 Aug 2019 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507720;
        bh=1MwG7RIv1THNr+WQTKVe5dsKMYphuScsrFdHJxj/3Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6uumdBS24V8kxPsSLUZMM9DGNjzRQ1lQCrfGwxbkRGjQqYs+LvJmWoyqVgWcfDuR
         RhLO1XgCJknMZBHtMEyE1WphX1+pbkECLq/hd/Vm5g5l7QSflyvjDTe7HuI/f5oBnm
         nQPispl9L6r2z5lfhJzqZmcdL9hv0xssDqOLWxD0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/25] perf script: Add missing counts.h
Date:   Thu, 22 Aug 2019 18:00:47 -0300
Message-Id: <20190822210100.3461-13-acme@kernel.org>
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

It is getting this via evsel.h, that don't strictly need counts.h, just
forward declarations for some structs, so add it here before we remove
it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q4shpvlxyjqz7val1hyrdak9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 1764efd16cd4..e957b870869b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3,6 +3,7 @@
 
 #include "perf.h"
 #include "util/cache.h"
+#include "util/counts.h"
 #include "util/debug.h"
 #include <subcmd/exec-cmd.h>
 #include "util/header.h"
-- 
2.21.0

