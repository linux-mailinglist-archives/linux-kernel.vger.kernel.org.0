Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0415259765
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1JZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 05:25:09 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:41952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbfF1JZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:25:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CAF27182251A2;
        Fri, 28 Jun 2019 09:25:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3698:3865:3866:3867:3868:4321:5007:7903:8957:9010:9040:10004:10400:10432:10433:10848:11026:11658:11914:12043:12296:12297:12438:12555:12681:12760:13138:13161:13172:13229:13231:13439:14181:14394:14659:14721:19903:19997:21080:21433:21451:21627:21819:30022:30029:30030:30046:30054:30055:30062,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:40,LUA_SUMMARY:none
X-HE-Tag: smash77_83fc0cecf740c
X-Filterd-Recvd-Size: 3559
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Jun 2019 09:25:06 +0000 (UTC)
Message-ID: <6f23c2918ad9fc744269feb8f909bdfb105c5afc.camel@perches.com>
Subject: [PATCH] get_maintainer: Add ability to skip moderated mailing lists
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 02:25:05 -0700
In-Reply-To: <20190624202512.GK3436@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190624202512.GK3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a command line switch --no-moderated to skip L: mailing
lists marked with 'moderated'.

Some people prefer not emailing moderated mailing lists as
the moderation time can be indeterminate and some emails
can be intentionally dropped by a moderator.

This can cause fragmentation of email threads when some are
subscribed to a moderated list but others are not and emails
are dropped.

Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/get_maintainer.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420..8c2fc22f3a11 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -27,6 +27,7 @@ my $email_usename = 1;
 my $email_maintainer = 1;
 my $email_reviewer = 1;
 my $email_list = 1;
+my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
 my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
@@ -248,6 +249,7 @@ if (!GetOptions(
 		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
+		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
@@ -1023,7 +1025,8 @@ MAINTAINER field selection options:
     --r => include reviewer(s) if any
     --n => include name 'Full Name <addr\@domain.tld>'
     --l => include list(s) if any
-    --s => include subscriber only list(s) if any
+    --moderated => include moderated lists(s) if any (default: true)
+    --s => include subscriber only list(s) if any (default: false)
     --remove-duplicates => minimize duplicate email names/addresses
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
@@ -1313,11 +1316,14 @@ sub add_categories {
 		} else {
 		    if ($email_list) {
 			if (!$hash_list_to{lc($list_address)}) {
-			    $hash_list_to{lc($list_address)} = 1;
 			    if ($list_additional =~ m/moderated/) {
-				push(@list_to, [$list_address,
-						"moderated list${list_role}"]);
+				if ($email_moderated_list) {
+				    $hash_list_to{lc($list_address)} = 1;
+				    push(@list_to, [$list_address,
+						    "moderated list${list_role}"]);
+				}
 			    } else {
+				$hash_list_to{lc($list_address)} = 1;
 				push(@list_to, [$list_address,
 						"open list${list_role}"]);
 			    }


