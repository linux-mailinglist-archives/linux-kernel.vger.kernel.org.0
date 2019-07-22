Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1016470793
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfGVRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 13:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfGVRjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:35 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C30A21985;
        Mon, 22 Jul 2019 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817174;
        bh=07kmdvtAjq+P6lKb4NfPv1qRZVvaGFBnnOj5BVi+pjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6PawSNQlI3RbAjCFfU1t7mZ+ygnxIn9OIIO8MXN0Eu7ni4HHv4xGKrBCXXEyOMPM
         uer8ChWWiNGZ4NpSfOtjCDiO+sL9SbyVchSxI4uGBs9i3fS9dT6iWL6SUXiyIoI8Gt
         2vlJhkUilHB5wA9HBmOqkh20ZIk2Z2Gawz5uvW04=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 06/37] perf trace: Order -e syscalls table
Date:   Mon, 22 Jul 2019 14:38:08 -0300
Message-Id: <20190722173839.22898-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The ev_qualifier is an array with the syscall ids passed via -e on the
command line, sort it as we'll search it when setting up the
BPF_MAP_TYPE_PROG_ARRAY.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c8hprylp3ai6e0z9burn2r3s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bfd739a321d1..9bd5ecd6a8dd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1528,6 +1528,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
+static int intcmp(const void *a, const void *b)
+{
+	const int *one = a, *another = b;
+
+	return *one - *another;
+}
+
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
@@ -1591,6 +1598,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 	}
 
 	trace->ev_qualifier_ids.nr = nr_used;
+	qsort(trace->ev_qualifier_ids.entries, nr_used, sizeof(int), intcmp);
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
-- 
2.21.0

