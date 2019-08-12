Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406768A88E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHLUpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 16:45:43 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:38409 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfHLUpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:45:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B11C1182CF665;
        Mon, 12 Aug 2019 20:45:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2332:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3871:3874:3876:5007:8603:9389:10004:10400:10848:11232:11658:11914:12043:12297:12555:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21451:21627:30054:30070,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: pets42_6bd28da236248
X-Filterd-Recvd-Size: 2160
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Aug 2019 20:45:40 +0000 (UTC)
Message-ID: <2f374c3c27054b7f978115270d587c624d9962fc.camel@perches.com>
Subject: [PATCH V2] checkpatch: Prefer __section over
 __attribute__((section(...)))
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Aug 2019 13:45:39 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another test for __attribute__((section("foo"))) uses
that should be __section(foo)

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---

V2: Remove (however dull) humor
    Fix fix missing ) removal

 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1cdacb4fd207..d4153b81b1eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,18 @@ sub process {
 			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
 		}
 
+# Check for __attribute__ section, prefer __section
+		if ($realfile !~ m@\binclude/uapi/@ &&
+		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
+			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+			my $new = substr($old, 1, -1);
+			if (WARN("PREFER_SECTION",
+				 "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)\s*\)/__section($new)/;
+			}
+		}
+
 # Check for __attribute__ format(printf, prefer __printf
 		if ($realfile !~ m@\binclude/uapi/@ &&
 		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {


