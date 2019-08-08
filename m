Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8526886927
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390346AbfHHSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 14:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbfHHSzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:55:05 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D8A21881;
        Thu,  8 Aug 2019 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290504;
        bh=0FYZ0E1fE3GWGwKkDK/WorE4xK8vdcj4fgwPP2WiwyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al0bA3ik+eeEKta3Wx1YrNgW3+8mEzbaBqoProx4ikMRPFT2gZZqZ26ESLTtxSq2S
         amD8qaPiAa7yoa4SpccqdOU9kxfClLBvOH3isPgL9V31JRfMPwLtDI+U53HPFmlYbT
         eB1G8C5nGjv1f1Kj41FhZZOkyDWQ3ORXaP9WIhjk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masanari Iida <standby24x7@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/10] perf tools: Fix a typo in a variable name in the Documentation Makefile
Date:   Thu,  8 Aug 2019 15:53:54 -0300
Message-Id: <20190808185358.20125-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masanari Iida <standby24x7@gmail.com>

This patch fix a spelling typo in a variable name in the Documentation Makefile.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190801032812.25018-1-standby24x7@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 6d148a40551c..adc5a7e44b98 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
 
--include $(OUPTUT)doc.dep
+-include $(OUTPUT)doc.dep
 
 _cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-ancillarymanipulators.txt \
-- 
2.21.0

