Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974F52F869
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfE3IRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:17:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:17:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8Hdiu2905251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:17:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8Hdiu2905251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204259;
        bh=D5O7Tj1ZXryZWm+Uax95RpAl9rvoKuOhBxw4xwdpOyY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GC9KdN6kdcABtFVvnXyjNlSoODVYbCoKsgYpeuNwvRB5vQteJWypQB4d4t740F19b
         WbR5tvSeR2lcb7FyhYzYfZQZ8oegqjxGeV+G5sB2fJn+hLXfq+Xk/7PFOKnwFrFyrL
         GBE24JiGTiKEoKBZhfhyxW285U6VpXIB6ctSlDmMaaCkML4tFcXmuoLyX26mzLHLq5
         3Gkc6g1feuwwPZdq+s/RalJKI5mQSK4+tGEsLklcyAi3YDyWQYuWzoa20yaG5tSM68
         Q8gXOXVZjaqgYtM3KCXfQ0vgEmJ4e0q3GgmTlUCXEnL9SLnVfHobqxyTEEJl5G9OfI
         KkuuJQ+SlFl/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8HcoT2905244;
        Thu, 30 May 2019 01:17:38 -0700
Date:   Thu, 30 May 2019 01:17:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c6aba1bf258ff1ce201f112dafe1bdde601573dd@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@redhat.com, adrian.hunter@intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
          hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190412113830.4126-2-adrian.hunter@intel.com>
References: <20190412113830.4126-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Change
 python2 to python
Git-Commit-ID: c6aba1bf258ff1ce201f112dafe1bdde601573dd
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

Commit-ID:  c6aba1bf258ff1ce201f112dafe1bdde601573dd
Gitweb:     https://git.kernel.org/tip/c6aba1bf258ff1ce201f112dafe1bdde601573dd
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:23 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf scripts python: exported-sql-viewer.py: Change python2 to python

Now that there is also support for python3, there is no need to specify
python2 explicitly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index affed7d149be..9ff92a130655 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python2
+#!/usr/bin/env python
 # SPDX-License-Identifier: GPL-2.0
 # exported-sql-viewer.py: view data from sql database
 # Copyright (c) 2014-2018, Intel Corporation.
