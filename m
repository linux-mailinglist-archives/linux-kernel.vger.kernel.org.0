Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B52B5E703
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCOmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:42:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42677 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:42:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EgRd23329918
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:42:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EgRd23329918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164948;
        bh=REPtCQybbt8R8aUfLca/f++Cg/Z3d4m3zoteTq0P6Pw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AC2m+QhRZP+B15afKE1VZpBNJqnAyyLpKaXZ2lgYWwO3pXmlCJvFeKcPJNjMm7FHb
         K4C/cTB1W3lXJS/Xpg0d+YawpxgK+ki3kg/DAYi/HQMdB5NMwdmmyVZIXGjNC68XwM
         a8V5pbzQySOXTENliZEEOwQN3ULndwnM/R6T946nONeTp6RSKGC8Mz1PHjSJPoIo2v
         SeKabPv6vQ0w56udhS4kykrQ+isLI80+eu8H8NBVTSesvWg5oS8dSkLLtjym3YMXJ2
         X6GCGFwiDdLIes7U00rmBqwqJvyN3Wpy4bLkkHIWfm6a5p4cemnQQSn+6KyPzUNnmT
         ZSh3HKuOwdUzg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EgRan3329914;
        Wed, 3 Jul 2019 07:42:27 -0700
Date:   Wed, 3 Jul 2019 07:42:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-9c344d15f5783260f57c711f3fce72dd744bebe2@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, ak@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          ak@linux.intel.com, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20190628220737.13259-2-andi@firstfloor.org>
References: <20190628220737.13259-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Avoid extra : for --raw metrics
Git-Commit-ID: 9c344d15f5783260f57c711f3fce72dd744bebe2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9c344d15f5783260f57c711f3fce72dd744bebe2
Gitweb:     https://git.kernel.org/tip/9c344d15f5783260f57c711f3fce72dd744bebe2
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 15:07:36 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:16 -0300

perf list: Avoid extra : for --raw metrics

When printing the metrics raw, don't print : after the metricgroups.
This helps the command line completion to complete those too.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index bc25995255ab..7d36435fa84c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -375,7 +375,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
-			printf("%s%s%s", me->name, metrics ? ":" : "", raw ? " " : "\n");
+			printf("%s%s%s", me->name, metrics && !raw ? ":" : "", raw ? " " : "\n");
 		if (metrics)
 			metricgroup__print_strlist(me->metrics, raw);
 		next = rb_next(node);
