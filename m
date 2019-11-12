Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC87F98E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKLSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLSiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:15 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A3021783;
        Tue, 12 Nov 2019 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583895;
        bh=G2yJCRFFdXK5M+LrYl75Kiay27RH2VwdUmFCJMrE3nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1+ykmG+qmz/CnU8utC4c0LpYL40qON1tLbVxlP35zmULuS0KC7wxHgJcV5LOzZHz
         OLdIuKNHSp1yFAv9dof8Jv2NkbACmDNIolLE/fj4aLXFES9X488vRvX+3Atf5IsuKU
         zp11TeZRbtF78hsND1W7EjVVtGNA+TrzLe0YYkwM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/15] perf map: Use map->dso->kernel + map__kmaps() in map__kmaps()
Date:   Tue, 12 Nov 2019 15:37:43 -0300
Message-Id: <20191112183757.28660-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its equivalent to using map->groups to obtain the machine struct.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bdbazuj4ggrmzxdviaqdrdwh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 466c9b035e19..a4d889c0fa88 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -244,18 +244,11 @@ struct map *map__new2(u64 start, struct dso *dso)
 	return map;
 }
 
-/*
- * Use this and __map__is_kmodule() for map instances that are in
- * machine->kmaps, and thus have map->groups->machine all properly set, to
- * disambiguate between the kernel and modules.
- *
- * When the need arises, introduce map__is_{kernel,kmodule)() that
- * checks (map->groups != NULL && map->groups->machine != NULL &&
- * map->dso->kernel) before calling __map__is_{kernel,kmodule}())
- */
 bool __map__is_kernel(const struct map *map)
 {
-	return machine__kernel_map(map->groups->machine) == map;
+	if (!map->dso->kernel)
+		return false;
+	return machine__kernel_map(map__kmaps((struct map *)map)->machine) == map;
 }
 
 bool __map__is_extra_kernel_map(const struct map *map)
-- 
2.21.0

