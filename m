Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A223812765
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfECF7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 01:59:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57629 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:59:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435x7do2618924
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:59:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435x7do2618924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556863147;
        bh=rAGeVewppmnWfX2UxBNvQWcL/n8RNUi8zIWw96y10HY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=iPq7sMO4So9yo7kP/iR3mjHKqUfNWrmTc7WqZ/mSaaeR09A1SeuGHPuJjgohdDj0H
         CU8QtCawMPyRCCX2RAL/2a/fPP1I1lyLQ8FCb6zHN2/Uk9+pb+2CgyIzisDe+AUxNF
         GP4wERIc6pFikyLwepaBRNx3ADberJCslZ8AjShZ4rChMSSJ8T94I+EuZczwNx1ztI
         jJ7DIZlF99TDZMFO2WEHVO21UrM/+4BLLK/sf3VJJJFqG1t2zjnbeqok3AcU3z9Alz
         WMjxUs5vh3P0fATDUCYEtZ/zUZraPd2VvW78/HmUGOkf/hDXyUj/0qgTrwm27Eh/lB
         kDGDVlyfhChyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435x6Gq2618921;
        Thu, 2 May 2019 22:59:06 -0700
Date:   Thu, 2 May 2019 22:59:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        arnd@arndb.de, acme@redhat.com, arnaldo.melo@gmail.com,
        mingo@kernel.org, Vineet.Gupta1@synopsys.com, dalias@libc.org,
        tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
          dalias@libc.org, Vineet.Gupta1@synopsys.com, mingo@kernel.org,
          acme@redhat.com, arnaldo.melo@gmail.com, arnd@arndb.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Remove needless asm/unistd.h include
 fixing build in some places
Git-Commit-ID: 7e221b811f1472d0c58c7d4e0fe84fcacd22580a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7e221b811f1472d0c58c7d4e0fe84fcacd22580a
Gitweb:     https://git.kernel.org/tip/7e221b811f1472d0c58c7d4e0fe84fcacd22580a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 May 2019 09:26:23 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf tools: Remove needless asm/unistd.h include fixing build in some places

We were including sys/syscall.h and asm/unistd.h, since sys/syscall.h
includes asm/unistd.h, sometimes this leads to the redefinition of
defines, breaking the build.

Noticed on ARC with uCLibc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Link: https://lkml.kernel.org/n/tip-xjpf80o64i2ko74aj2jih0qg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cloexec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index ca0fff6272be..06f48312c5ed 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,7 +7,6 @@
 #include "asm/bug.h"
 #include "debug.h"
 #include <unistd.h>
-#include <asm/unistd.h>
 #include <sys/syscall.h>
 
 static unsigned long flag = PERF_FLAG_FD_CLOEXEC;
