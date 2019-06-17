Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53848D82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfFQTHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:07:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFQTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:07:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJ71lF3557549
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:07:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJ71lF3557549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798422;
        bh=5Rgvl+vqguVWbRfKMzU+AUkIVav3zTQGHMhcqEOJMZ8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KxARHoJvwTA9jzX8qACPTEEMB9flG6ElGkoXXT0mw3+PS0ewmcskUKIGn/cOmFNxu
         Hy0uId8gRz5uqyQpf23fmvulU1SHyFkM3W1RH4OrJfYb22UhiJYodk5bNjL2XPuwat
         IL+JprQKHc1p5NDc/i2zhRkBlOJett52mTRPgwy5JlkI0egB1En1oE3e4BFETZC4u4
         dtUiWokZ5ysMUcU3eYvbKDtezGy1UywRgJOUp26MkSTX4QgMdxr833gKcmaJRQ9BCj
         kYhgsH4+iPnmSd+zMl7BEzPf49edVr+LVlt0UUJ+ywXVzHgI0rFIIBRoH9udSipv0F
         YIj+RIlRS4O6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJ71Ww3557546;
        Mon, 17 Jun 2019 12:07:01 -0700
Date:   Mon, 17 Jun 2019 12:07:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-52a2ab6fa99df9288f2c8c7f461b815550b9b366@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, jolsa@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190520113728.14389-16-adrian.hunter@intel.com>
References: <20190520113728.14389-16-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf db-export: Export IPC information
Git-Commit-ID: 52a2ab6fa99df9288f2c8c7f461b815550b9b366
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

Commit-ID:  52a2ab6fa99df9288f2c8c7f461b815550b9b366
Gitweb:     https://git.kernel.org/tip/52a2ab6fa99df9288f2c8c7f461b815550b9b366
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:21 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:57 -0300

perf db-export: Export IPC information

Export cycle and instruction counts on samples and call-returns.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 22f52b669871..6acb379b53ec 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1111,7 +1111,7 @@ static int python_export_sample(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(22);
+	t = tuple_new(24);
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
@@ -1135,6 +1135,8 @@ static int python_export_sample(struct db_export *dbe,
 	tuple_set_s32(t, 19, es->sample->flags & PERF_BRANCH_MASK);
 	tuple_set_s32(t, 20, !!(es->sample->flags & PERF_IP_FLAG_IN_TX));
 	tuple_set_u64(t, 21, es->call_path_id);
+	tuple_set_u64(t, 22, es->sample->insn_cnt);
+	tuple_set_u64(t, 23, es->sample->cyc_cnt);
 
 	call_object(tables->sample_handler, t, "sample_table");
 
@@ -1173,7 +1175,7 @@ static int python_export_call_return(struct db_export *dbe,
 	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
 	PyObject *t;
 
-	t = tuple_new(12);
+	t = tuple_new(14);
 
 	tuple_set_u64(t, 0, cr->db_id);
 	tuple_set_u64(t, 1, cr->thread->db_id);
@@ -1187,6 +1189,8 @@ static int python_export_call_return(struct db_export *dbe,
 	tuple_set_u64(t, 9, cr->cp->parent->db_id);
 	tuple_set_s32(t, 10, cr->flags);
 	tuple_set_u64(t, 11, cr->parent_db_id);
+	tuple_set_u64(t, 12, cr->insn_count);
+	tuple_set_u64(t, 13, cr->cyc_count);
 
 	call_object(tables->call_return_handler, t, "call_return_table");
 
