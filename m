Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4156A48DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfFQTQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:16:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:16:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJGiDA3559655
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:16:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJGiDA3559655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799004;
        bh=eUCp9JhHf8WkAAyD5RlGQtULz04H9ubyJ88+fv+pyuA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HANCXcA7rNX8grwCmfFwLPWQWNzg2+sgC1PMl2GDjl1DXOFMMfZdbLKurAbE4sTsW
         19frMvgAsE54CyWqMlyfrfg6ok0FEqDwxHoq9kvyfkq6fUpM8vLrS6QRGzE8fE5j4t
         vTodHIrofaa+lCRaJyNpM8irmQYYgwdYFTkMMfZb9Li1Qlzk6lMJ76K9u523n+889P
         bOVMjBj16enFA50m9Z2yhzICsvHBV1HEvh7w83TznwrruIMv1a43pVZlmuWt8eYpW5
         8v+09dPbU80nL28La8K47pv0JLy8DZocQnK73qv71HMgCq2GuE/Sd9oAPyXpzAYpBj
         BBhL1gqzDAuNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJGhbI3559652;
        Mon, 17 Jun 2019 12:16:43 -0700
Date:   Mon, 17 Jun 2019 12:16:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wjy7j4bk06g7atzwoz1mid24@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Associate more argument names with the
 filename beautifier
Git-Commit-ID: dea87bfb7b280e8b14519eb6b5e8bafbbf4c66f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dea87bfb7b280e8b14519eb6b5e8bafbbf4c66f2
Gitweb:     https://git.kernel.org/tip/dea87bfb7b280e8b14519eb6b5e8bafbbf4c66f2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 5 Jun 2019 10:53:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 10:53:06 -0300

perf trace: Associate more argument names with the filename beautifier

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
