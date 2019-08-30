Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B61A3C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3QbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:31:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:63554 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbfH3QbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:31:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 09:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="193381696"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2019 09:31:04 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: Remove obsolete period from "ambiguous SHA1" query
Date:   Fri, 30 Aug 2019 09:31:03 -0700
Message-Id: <20190830163103.15914-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Git dropped the period from its "ambiguous SHA1" error message in commit
0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
circa 2016.  Drop the period from checkpatch's associated query so as to
match both the old and new error messages.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..ef3642c53100 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -962,7 +962,7 @@ sub git_commit_info {
 
 	return ($id, $desc) if ($#lines < 0);
 
-	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
+	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
 # Maybe one day convert this block of bash into something that returns
 # all matching commit ids, but it's very slow...
 #
-- 
2.22.0

