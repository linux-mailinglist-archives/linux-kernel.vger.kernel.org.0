Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9F62F85F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE3IOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:14:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfE3IOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:14:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8E4512904717
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:14:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8E4512904717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204045;
        bh=YocNR03LztEIRwgfs2gHJqyMB8B1v6MAyp624O+VnD4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=KSESlhYvCJZCQwpDtsiRjusrRE2dtP2bDnhzNci9UGr1M10zOTNN2EGr/2j5VtdoD
         +HbO3A8DdaT7/AVt7y9xJfy5BvdbfGvdfQXOfZgbA8LshxH8TspKF+cTQb2/gSh0BM
         KJT1EuOljOd5MaEVV1Xt3+78duetBJ6xI6mYqB9ASK9iVNB46LLUkE1YWoyzGdlIUr
         /jasnH2hq5SH0LfGwj7TL5JiUpVrRavqLyMzGrQSnryuJoDYQFBMKSzWAApZC3PlQB
         QoCn4UKLcn/RJCs+x2rk/A8EEcGrhFXfPEmoBwE4taYz+QjQRZHYcaRJX5dLCM+hJm
         1Y1z+sriHPPAw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8E4F62904714;
        Thu, 30 May 2019 01:14:04 -0700
Date:   Thu, 30 May 2019 01:14:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p4yun2nxlo7eeeohyx5v4kw7@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, namhyung@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, jolsa@kernel.org,
          acme@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf version: Append 12 git SHA chars to the
 version string
Git-Commit-ID: 80ec26d110c5c5a81b60c444db851e5734dee09a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  80ec26d110c5c5a81b60c444db851e5734dee09a
Gitweb:     https://git.kernel.org/tip/80ec26d110c5c5a81b60c444db851e5734dee09a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 24 May 2019 15:50:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf version: Append 12 git SHA chars to the version string

Bumping it from just 4:

Before:

  $ perf -v
  perf version 5.2.rc1.g80978f
  $

After:

  $ perf -v
  perf version 5.2.rc1.g80978fc864c5
  $

Requested-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p4yun2nxlo7eeeohyx5v4kw7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/PERF-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 3802cee5e188..59241ff342be 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -19,7 +19,7 @@ TAG=
 if test -d ../../.git -o -f ../../.git
 then
 	TAG=$(git describe --abbrev=0 --match "v[0-9].[0-9]*" 2>/dev/null )
-	CID=$(git log -1 --abbrev=4 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
+	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
 elif test -f ../../PERF-VERSION-FILE
 then
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
