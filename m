Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5920B2F819
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfE3Hwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:52:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41229 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3Hwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:52:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U7qYML2899416
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 00:52:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U7qYML2899416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559202755;
        bh=/94ehPIIaA2Wp0aooIJ4ht9rf2rBM1gUaGoGZc32fR0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EEGJbqlsx6zPTlLT8fz1QaEbl0JJFRf2x8xvKeJCgthPol32GXhFQ/ly3rgk1hGVO
         33fxhcD2IaVTHPZr+MILO+06mVWmRdRQKpdr2n0gigxqMy1S6JL8SVMvHVKuAdAp6H
         QheVOtlM6yAwPo3QsZUgXKRRxX2W3rdxUFsoJZOazRXWFNATMXfiZm/SW5V+h4LQ4M
         tz9L1pRDeLEmX0vOTvbHwzLr2HsrMx/UsQE7vdFNZl5xn6i4n7XUXgr2JEVgf/aRNW
         hN9qnNnObehnG70b67paTIOnXoHAYKY125eM18cqE1ROH44VdqDHeRYYthxOrbZ5b0
         pZ5Shp2LxDHOQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U7qYBd2899413;
        Thu, 30 May 2019 00:52:34 -0700
Date:   Thu, 30 May 2019 00:52:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a685c7a4a25c80f1f022b55830f2d894ee8847eb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, adrian.hunter@intel.com, jolsa@redhat.com,
        acme@redhat.com
Reply-To: acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org
In-Reply-To: <20190412113830.4126-7-adrian.hunter@intel.com>
References: <20190412113830.4126-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf-with-kcore.sh: Always allow
 fix_buildid_cache_permissions
Git-Commit-ID: a685c7a4a25c80f1f022b55830f2d894ee8847eb
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

Commit-ID:  a685c7a4a25c80f1f022b55830f2d894ee8847eb
Gitweb:     https://git.kernel.org/tip/a685c7a4a25c80f1f022b55830f2d894ee8847eb
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:28 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf-with-kcore.sh: Always allow fix_buildid_cache_permissions

The user's buildid cache may contain entries added by root even if root
has its own home directory (e.g. by using perfconfig to specify the same
buildid dir), so remove that validation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-with-kcore.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/perf-with-kcore.sh b/tools/perf/perf-with-kcore.sh
index 7e47a7cbc195..2ad2fffdb209 100644
--- a/tools/perf/perf-with-kcore.sh
+++ b/tools/perf/perf-with-kcore.sh
@@ -111,11 +111,6 @@ fix_buildid_cache_permissions()
 
 	USER_HOME=$(bash <<< "echo ~$SUDO_USER")
 
-	if [ "$HOME" != "$USER_HOME" ] ; then
-		echo "Fix unnecessary because root has a home: $HOME" >&2
-		exit 1
-	fi
-
 	echo "Fixing buildid cache permissions"
 
 	find "$USER_HOME/.debug" -xdev -type d          ! -user "$SUDO_USER" -ls -exec chown    "$SUDO_USER" \{\} \;
