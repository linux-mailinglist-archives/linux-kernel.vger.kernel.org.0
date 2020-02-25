Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25AA16F281
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 23:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgBYWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 17:17:42 -0500
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:46733 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgBYWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:17:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 12BDD837F27E;
        Tue, 25 Feb 2020 22:17:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3868:3870:3871:3872:3874:4605:5007:7522:7875:10004:10400:10848:11026:11473:11658:11914:12043:12294:12297:12438:12555:12760:13095:13161:13229:13439:14181:14394:14659:14721:21080:21324:21433:21451:21627:30029:30034:30054:30070:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bomb77_872dd2445508
X-Filterd-Recvd-Size: 3211
Received: from XPS-9350 (unknown [172.58.27.58])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 22:17:37 +0000 (UTC)
Message-ID: <2f6d5f8766fe7439a116c77ea8cc721a3f2d77a2.camel@perches.com>
Subject: [PATCH] checkpatch: Improve Gerrit Change-Id: test
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 14:16:04 -0800
In-Reply-To: <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
References: <20200224235824.126361-1-john.stultz@linaro.org>
         <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
         <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
         <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
         <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gerrit Change-Id: entry is sometimes placed after a Signed-off-by:
line.  When this occurs, the Gerrit warning is not currently emitted
as the first Signed-off-by: signature sets a flag to stop looking.

Change the test to add a test for the --- patch separator and emit the
warning before any before the --- and also before any diff file name.

Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: John Stultz <john.stultz@linaro.org>
---
 scripts/checkpatch.pl | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d55d8a2a..d0f850e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2343,6 +2343,7 @@ sub process {
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
+	my $has_patch_separator = 0;	#Found a --- line
 	my $has_commit_log = 0;		#Encountered lines before patch
 	my $commit_log_lines = 0;	#Number of commit log lines
 	my $commit_log_possible_stack_dump = 0;
@@ -2668,6 +2669,12 @@ sub process {
 			}
 		}
 
+# Check for patch separator
+		if ($line =~ /^---$/) {
+			$has_patch_separator = 1;
+			$in_commit_log = 0;
+		}
+
 # Check if MAINTAINERS is being updated.  If so, there's probably no need to
 # emit the "does MAINTAINERS need updating?" message on file add/move/delete
 		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
@@ -2767,10 +2774,10 @@ sub process {
 			     "A patch subject line should describe the change not the tool that found it\n" . $herecurr);
 		}
 
-# Check for unwanted Gerrit info
-		if ($in_commit_log && $line =~ /^\s*change-id:/i) {
+# Check for Gerrit Change-Ids not in any patch context
+		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
 			ERROR("GERRIT_CHANGE_ID",
-			      "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
+			      "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
 		}
 
 # Check if the commit log is in a possible stack dump


