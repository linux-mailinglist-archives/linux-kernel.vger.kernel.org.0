Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40763D620
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392293AbfFKTBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388445AbfFKTBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:01:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 780F22184C;
        Tue, 11 Jun 2019 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279702;
        bh=Zb58os87fFWTy+zqgBLAEtBZ9lNg2G8En3ygFbO5ONk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9bmRCTeoXLofnvno/gqyLTib7e7yvWteX1p31kpGAX9mu70wBTVjx+IK28BWUm4y
         vQn/lvpHbkopmHgDlCc+IE+E71YmGHZIN6yS+ZlgnD7mHH0Waj+fA45AJXJzpkOC07
         HwQvK/o3xGA2o7clZFOViqj5jn5NaobF7BAKKRTE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 32/85] perf trace: Associate more argument names with the filename beautifier
Date:   Tue, 11 Jun 2019 15:58:18 -0300
Message-Id: <20190611185911.11645-33-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance, the rename* family uses "oldname", "newname", so check if
"name" is at the end and treat it as a filename.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wjy7j4bk06g7atzwoz1mid24@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 905e57c336b0..f7e4e50bddbd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1431,10 +1431,11 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		if (sc->fmt && sc->fmt->arg[idx].scnprintf)
 			continue;
 
+		len = strlen(field->name);
+
 		if (strcmp(field->type, "const char *") == 0 &&
-			 (strcmp(field->name, "filename") == 0 ||
-			  strcmp(field->name, "path") == 0 ||
-			  strcmp(field->name, "pathname") == 0))
+		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
+		     strstr(field->name, "path") != NULL))
 			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			sc->arg_fmt[idx].scnprintf = SCA_PTR;
@@ -1445,8 +1446,7 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
-			 (len = strlen(field->name)) >= 2 &&
-			 strcmp(field->name + len - 2, "fd") == 0) {
+			 len >= 2 && strcmp(field->name + len - 2, "fd") == 0) {
 			/*
 			 * /sys/kernel/tracing/events/syscalls/sys_enter*
 			 * egrep 'field:.*fd;' .../format|sed -r 's/.*field:([a-z ]+) [a-z_]*fd.+/\1/g'|sort|uniq -c
-- 
2.20.1

