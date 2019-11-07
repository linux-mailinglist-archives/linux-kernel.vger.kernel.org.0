Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01609F37E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfKGTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:05:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfKGTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:58 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF31F2085B;
        Thu,  7 Nov 2019 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153498;
        bh=2GjoY1mbQmJ1MIjhHcVL2b66qWSckvRQqjOxvCd7vok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FndtvtpjBAKkY/L/b1e4c8NP3ivmSMVnQMjrzjsYXBknomapcBqbviI9ushzpQysh
         /T+Va38opJGLwYLlOO/uTr5sp8OO6xQytn8sIgrJ1bmCxz6Tub9BWi1Sm2g7Cpupgz
         dM0C5UpCxUJpkx1oTXdmAuqQkszu36cDFO8lJmS4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <James.Clark@arm.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, nd <nd@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/63] libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
Date:   Thu,  7 Nov 2019 15:59:40 -0300
Message-Id: <20191107190011.23924-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <James.Clark@arm.com>

Move EXTRA_WARNINGS and EXTRA_FLAGS to the end of the compilation line,
otherwise they cannot be used to override the default values.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: nd <nd@arm.com>
Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..352c6062deba 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
 
 LIBFILE = $(OUTPUT)libsubcmd.a
 
-CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
 
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -43,6 +42,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
 
+CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
 all:
-- 
2.21.0

