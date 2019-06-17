Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3A48DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfFQTMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:12:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfFQTMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:12:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJBq8H3558420
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:11:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJBq8H3558420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798713;
        bh=bD/GOVSceiYdifLBkYIk1nGvwlzvEf8fRUKjB9Uv6S8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UWWnlR7qbFfv12xfkWZPbL3NE2HER9K3kSds62mY8PSTqYqlyEqs283aA1AlmLJBi
         g01TcCL2knZhKXMHeXPCw3nqL9NryPfkH1De8CMt80cMzXHDBK4HHTY977M7imLuvl
         2XOJzcMKwEnOVfjp7Zis0bsljdY3w2s0bxnmSUv2gQL1JKc0zERfiGKDfcsEUoJliZ
         r84QAA8knwpf5/voCONSITO76UKiN5Ykc5HLLugsCylrMZ/C22yWq/QQL1sUed0u1G
         p4JIR9+8vSrFrMmVSK8p1rTGsBShYYo6Lizt+pVvQvMe+3w6w6DTNklHBFYOJnT0d3
         HE3aBsuCzpwCQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJBq0p3558417;
        Mon, 17 Jun 2019 12:11:52 -0700
Date:   Mon, 17 Jun 2019 12:11:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-80b3fb64a55a7e4ba1ef8f9a7e87fbe1a26dc709@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org,
          acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190520113728.14389-23-adrian.hunter@intel.com>
References: <20190520113728.14389-23-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf scripts python: exported-sql-viewer.py: Select
 find text when find bar is activated
Git-Commit-ID: 80b3fb64a55a7e4ba1ef8f9a7e87fbe1a26dc709
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

Commit-ID:  80b3fb64a55a7e4ba1ef8f9a7e87fbe1a26dc709
Gitweb:     https://git.kernel.org/tip/80b3fb64a55a7e4ba1ef8f9a7e87fbe1a26dc709
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 20 May 2019 14:37:28 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:58 -0300

perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated

The user probably wants to replace the find text, so select the find
text when the find bar is activated.

That is fairly standard behaviour for search text entry.

Entering text will replace the current text, but using edit keys
(arrows, home, end etc) cancels the selection and enables editing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-23-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 94489cf2ce0e..6e7934f2ac9a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -400,6 +400,7 @@ class FindBar():
 
 	def Activate(self):
 		self.bar.show()
+		self.textbox.lineEdit().selectAll()
 		self.textbox.setFocus()
 
 	def Deactivate(self):
