Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5559A1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 23:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404706AbfHVVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 17:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404669AbfHVVBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:33 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E00023401;
        Thu, 22 Aug 2019 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507693;
        bh=4+U28/ZoIpsrqQWSHdlu9+OL4ZkQwq9VvMqokWb70SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRA8dxUayC/Y0ZrJoIyRaGTZnf8PnMAQSbyvmOXaWh+4UjJBURW86hX6Xc/xI9GHi
         VuzIVAxatrUv1wexwvlkZcwooDT7hnATpsoy6JSDPnI9pwCzz0jjeFCFf5hesTEhjK
         ONEsFmz/E85DjGHqszDYhwXExJpTEjY2imp6wKWc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/25] perf arm64: Add missing debug.h header
Date:   Thu, 22 Aug 2019 18:00:40 -0300
Message-Id: <20190822210100.3461-6-acme@kernel.org>
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

This file uses pr_debug() but isn't including debug.h, getting it by
luck, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t7pisnsdfh88kclpw52jcwl7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/header.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 602caf550e7f..e41defaaa2e6 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <api/fs/fs.h>
+#include "debug.h"
 #include "header.h"
 
 #define MIDR "/regs/identification/midr_el1"
-- 
2.21.0

