Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6DB9216
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbfITO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 10:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbfITO00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 663FF217F5;
        Fri, 20 Sep 2019 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989586;
        bh=HeUldKG4McMuV/jy06xeKdn1oLQpD6XToRv2wv5eNto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTCarQYhRxWHzfudPstdny8S5eba0DIptlEJb3bdXbUK03HWqlC4L5o0dLyOAVpQi
         wMXxzqgFPwTOx0ffBzadiOZyyy8NZZwEpayCNOPuCVCTnEoLPv/qS6Jt9izhpyvKuT
         kMm8nxGbSIuvBdyICP3NIE1qdKmw2U3ifNDySKc0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/31] perf symbols: Add missing dso.h header
Date:   Fri, 20 Sep 2019 11:25:23 -0300
Message-Id: <20190920142542.12047-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This was being obtained only indirectly, by luck.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xeolxwr3iftwfw9kmw26shfe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8b9199c343dd..6fbfdf8bf61f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
+#include "dso.h"
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
-- 
2.21.0

