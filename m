Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7917395E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 15:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgB1OBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 09:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgB1OBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562B5246AE;
        Fri, 28 Feb 2020 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898489;
        bh=ucKHIT7ySSSze2KraKTyZmctHteAjwvZBbS/OOSK3/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0YqdwUsJcWd0nqfGAjQeXwUNphP2nPk7ZbCVBkZc3zLusPQTk+9CZTN1WdwSyXhJ
         UPi7EtBD7QO7QicZt2XZJkpS7PzkxSTIIBOCCmGDLz374LwUoiTZo7dbjniSeu9vHz
         4K8e7sa75ALno2O7r4+ivHJxrD1XbeSQFUmKLSRk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 15/15] perf annotate: Fix segfault with source toggle
Date:   Fri, 28 Feb 2020 11:00:14 -0300
Message-Id: <20200228140014.1236-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

While rendering annotate browser from perf report tui, we keep track
of total number of lines(asm + source) in annotation->nr_entries and
total number of asm lines in annotation->nr_asm_entries. But we don't
reset them before starting. Thus if user annotates same function
multiple times, we restart incrementing these fields with old values.

This causes a segfault when user tries to toggle source code after
annotating same function multiple times. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-5-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c816e5840166..0ea95be84b3b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2621,6 +2621,8 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	struct annotation_line *al;
 
 	notes->max_line_len = 0;
+	notes->nr_entries = 0;
+	notes->nr_asm_entries = 0;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		size_t line_len = strlen(al->line);
-- 
2.21.1

