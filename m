Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95019BA42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgDBCW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 22:22:29 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:40652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732435AbgDBCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:22:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2CEDC100E7B40;
        Thu,  2 Apr 2020 02:22:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3871:4321:5007:6119:7903:10004:10400:10848:11026:11658:11914:12043:12295:12297:12438:12555:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21433:21627:21939:21990:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: eyes58_154b705020d2d
X-Filterd-Recvd-Size: 2647
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu,  2 Apr 2020 02:22:26 +0000 (UTC)
Message-ID: <65cb075435d2f385a53c77571b491b2b09faaf8e.camel@perches.com>
Subject: [PATCH] checkpatch: Look for c99 comments in ctx_locate_comment
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, Marco Elver <elver@google.com>,
        dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Will Deacon <will@kernel.org>
Date:   Wed, 01 Apr 2020 19:20:30 -0700
In-Reply-To: <20200401153824.GX19865@paulmck-ThinkPad-P72>
References: <20200401101714.44781-1-elver@google.com>
         <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
         <20200401153824.GX19865@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some checks look for comments around a specific function like
read_barrier_depends.

Extend the check to support both c89 and c90 comment styles.

	c89 /* comment */
or
	c99 // comment

For c99 comments, only look a 3 single lines, the line being scanned,
the line above and the line below the line being scanned rather than
the patch diff context.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67..0f4db4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1674,8 +1674,16 @@ sub ctx_statement_level {
 sub ctx_locate_comment {
 	my ($first_line, $end_line) = @_;
 
+	# If c99 comment on the current line, or the line before or after
+	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@^\+.*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+	($current_comment) = ($rawlines[$end_line - 2] =~ m@^[\+ ].*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+	($current_comment) = ($rawlines[$end_line] =~ m@^[\+ ].*(//.*$)@);
+	return $current_comment if (defined $current_comment);
+
 	# Catch a comment on the end of the line itself.
-	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
+	($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
 	return $current_comment if (defined $current_comment);
 
 	# Look through the context and try and figure out if there is a


