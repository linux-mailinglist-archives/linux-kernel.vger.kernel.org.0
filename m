Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3ED107458
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 15:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKVO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 09:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfKVO5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B582072D;
        Fri, 22 Nov 2019 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434650;
        bh=Mgy+BNUYodHhlHnwY4TO3qQF0gUHiHgiGkEVL2JYrwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thDFCbtZhy7u00uhkeHnRQLxKaU7SpuRZQR6buizueFb5mecGE+QhHvFVT4iaT5Ob
         AYw+IcyxIkT7r5PWXDO13cBPb4IRNmARjPkZxu3qsHs0DwQSIU2diRT2hTO6CUWOdd
         JDYnDGNXIqTmdSOPMQ07rXX8mvagJWUkFgPUQ+qY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 04/26] perf dsos: Remove unused dsos__find() method
Date:   Fri, 22 Nov 2019 11:56:49 -0300
Message-Id: <20191122145711.3171-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Not used anywhere, nuke it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-teqz0eqcw43mnt7i3me44esw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dsos.c | 9 ---------
 tools/perf/util/dsos.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index ecf8d7346685..1d38d6ac6e5a 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -159,15 +159,6 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
 	return __dsos__findnew_by_longname(&dsos->root, name);
 }
 
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
-{
-	struct dso *dso;
-	down_read(&dsos->lock);
-	dso = __dsos__find(dsos, name, cmp_short);
-	up_read(&dsos->lock);
-	return dso;
-}
-
 static void dso__set_basename(struct dso *dso)
 {
 	char *base, *lname;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 32f1fbee0feb..fd7ba51fc965 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -24,7 +24,6 @@ void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
 struct dso *dsos__findnew(struct dsos *dsos, const char *name);
 
-- 
2.21.0

