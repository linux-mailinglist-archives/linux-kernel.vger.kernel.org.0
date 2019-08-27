Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7A29DB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 03:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfH0Bgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 21:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfH0Bgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02872173E;
        Tue, 27 Aug 2019 01:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869808;
        bh=b+jpFN8XDClY4zIaTKmHBPi7oDYn3qbsZcXmRv81NB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oa2ajJ0HgA7Xq6r0oMeQohDFOwNiwE5ylvjfkXsXDBsMA3IQcqUhWKg8NMW9f6eIr
         zVEri6yUibkTIgLmdQjS1fEBlBwvR7xlcI2AJy8lKffbfk7IJQEsUDWy8Rq2M1EyO8
         5ieZKLOsnBlvDaTSLVny3EfpdnizTgcZKrSiQo18=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/33] perf stat: Remove needless headers from stat.h
Date:   Mon, 26 Aug 2019 22:36:03 -0300
Message-Id: <20190827013634.3173-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just a forward declaration for 'struct timespec' is needed, ditch the
rest.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6shdqw801oqe7ax6r307k27r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index bcb376e1b3a7..9e425ecd82d9 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -5,13 +5,12 @@
 #include <linux/types.h>
 #include <stdio.h>
 #include <sys/types.h>
-#include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 #include "rblist.h"
-#include "perf.h"
 #include "event.h"
 
+struct timespec;
+
 struct stats {
 	double n, mean, M2;
 	u64 max, min;
-- 
2.21.0

