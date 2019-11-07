Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1238F3525
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfKGQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 11:55:23 -0500
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:59225 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfKGQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:55:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1733C18022F3A;
        Thu,  7 Nov 2019 16:55:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:4321:5007:6119:7808:10004:10400:11026:11658:11914:12043:12114:12296:12297:12438:12555:12679:12681:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21627:21795:30046:30051:30054,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: wool61_68cbd436e7d14
X-Filterd-Recvd-Size: 2188
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Nov 2019 16:55:20 +0000 (UTC)
Message-ID: <b982566a2b9b4825badce36fdfc3032bd0005151.camel@perches.com>
Subject: [PATCH] checkpatch: Reduce is_maintained_obsolete lookup runtime
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Nov 2019 08:55:07 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_maintained_obsolete function can be called twice
using the same filename.  This function spawns a process
using get_maintainer.pl.  Store the status of each filename
when spawned and use the stored result to eliminate the
spawning of unnecessary duplicate child processes.

Example:

old:

$ time ./scripts/checkpatch.pl hp100-Move-to-staging.patch > /dev/null

real	0m1.767s
user	0m1.634s
sys	0m0.141s

new:

$ time ./scripts/checkpatch.pl hp100-Move-to-staging.patch > /dev/null

real	0m1.184s
user	0m1.085s
sys	0m0.103s

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a85d719..8756c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -888,14 +888,18 @@ sub seed_camelcase_file {
 	}
 }
 
+our %maintained_status = ();
+
 sub is_maintained_obsolete {
 	my ($filename) = @_;
 
 	return 0 if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
 
-	my $status = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
+	if (!exists($maintained_status{$filename})) {
+		$maintained_status{$filename} = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
+	}
 
-	return $status =~ /obsolete/i;
+	return $maintained_status{$filename} =~ /obsolete/i;
 }
 
 sub is_SPDX_License_valid {


