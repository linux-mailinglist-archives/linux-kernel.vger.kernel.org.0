Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A506C352
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 00:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfGQWzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 18:55:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:55:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMtXC01722356
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:55:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMtXC01722356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404134;
        bh=KRz/lBWcsWdcbGnQ8dG3dRVdwUhBoVBM5mcDEOO1gzk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Cr0sTGKgakI3tsvNllDwBPgPRdyoFV5/b15dJ3IKmxTawJhRSO5+LydozPTcQQ1jb
         Vq7fE8wDEp8Egz8gfK5mTEPNaUOerVyEEjWL0nLxI6+DdOoHVJYnOeJYT94O1ZLdZ3
         T8rJzlA2roTFrqK2WGf6yHytgpwKRJtBdXXstjXhvlM5BcXFTjEL0wg8dUpdE4KIKZ
         UdsN3xerM3/TxdsJ0l3VFHyEVHYvePUJsXJyP+XbF6T5+syVhHpecTHRaBnFk6WY9R
         sZKwFrs8BTPGIKSZHlVF2akUW2uWHCOzdRa1AXVoUPh1JYBT26C4m6czp5lmF4pzWc
         CTRrmkEppsrkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMtXgW1722353;
        Wed, 17 Jul 2019 15:55:33 -0700
Date:   Wed, 17 Jul 2019 15:55:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a5defb2f3984e0f056e4113b54c461782796c7be@git.kernel.org>
Cc:     jolsa@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          acme@redhat.com, jolsa@redhat.com
In-Reply-To: <20190710085810.1650-8-adrian.hunter@intel.com>
References: <20190710085810.1650-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Fix a white space issue in
 db_export__sample()
Git-Commit-ID: a5defb2f3984e0f056e4113b54c461782796c7be
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_48_96,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a5defb2f3984e0f056e4113b54c461782796c7be
Gitweb:     https://git.kernel.org/tip/a5defb2f3984e0f056e4113b54c461782796c7be
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:56 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:12:56 -0300

perf db-export: Fix a white space issue in db_export__sample()

Fix a white space issue in db_export__sample()

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 78f62a733b9d..2c3a4ad68428 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -274,7 +274,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct perf_evsel *evsel,
 		      struct addr_location *al)
 {
-	struct thread* thread = al->thread;
+	struct thread *thread = al->thread;
 	struct export_sample es = {
 		.event = event,
 		.sample = sample,
