Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30603D606
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407109AbfFKS7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 14:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKS7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:59:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11AB217D6;
        Tue, 11 Jun 2019 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279593;
        bh=y32ND79M7u2/BMPbWnu2eoxX9u3coP17BfywC4JN+DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5AMe3gSWQM0WIf1AITE6WvMB2znbqVbb8/7jz8C3y9BbnJ5UcBkWO1LnLCIs6/zp
         CQLXBC8Xz4FgMIMAJap2y9Lc2eJwc58Di71tZ/4q151jYYm+kt8x2XQ0K7gtnk5UZ4
         nZOb/gq2YJZ5vBKxn7uYHoTi+sktzug9H6aKA1g0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/85] perf tools: Add IPC information to perf_sample
Date:   Tue, 11 Jun 2019 15:57:55 -0300
Message-Id: <20190611185911.11645-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add counts of instructions and cycles, in order to represent
instructions-per-cycle (IPC).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 9e999550f247..1f1da6082806 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -204,6 +204,8 @@ struct perf_sample {
 	u64 period;
 	u64 weight;
 	u64 transaction;
+	u64 insn_cnt;
+	u64 cyc_cnt;
 	u32 cpu;
 	u32 raw_size;
 	u64 data_src;
-- 
2.20.1

