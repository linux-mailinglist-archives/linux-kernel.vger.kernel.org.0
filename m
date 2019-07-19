Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9C6EC86
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfGSWbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 18:31:39 -0400
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:36907 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfGSWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:31:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9D923182CED5B;
        Fri, 19 Jul 2019 22:31:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1263:1345:1359:1431:1437:1534:1542:1711:1730:1747:1777:1792:2197:2199:2393:2525:2559:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:6117:6261:7550:7901:7903:9025:10004:10848:11026:11232:11257:11473:11658:11914:12043:12297:12438:12555:12663:12679:12783:12895:12986:13846:14181:14394:14721:14849:21080:21221:21451:21627:30054:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: elbow13_483fe0387df10
X-Filterd-Recvd-Size: 2981
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 22:31:36 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] checkpatch: Improve SPDX license checking
Date:   Fri, 19 Jul 2019 15:31:33 -0700
Message-Id: <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use perl's m@<match>@ match and not /<match>/ comparisons to avoid
an error using c90's // comment style.

Miscellanea:

o Use normal tab indentation and alignment

Link: http://lkml.kernel.org/r/5e4a8fa7901148fbcd77ab391e6dd0e6bf95777f.camel@perches.com

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

This replaces the unsigned patch with an incomplete commit description
in -next.

scripts/checkpatch.pl | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3c0ee0dde850..6cb99ec62000 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3071,21 +3071,21 @@ sub process {
 # check SPDX comment style for .[chsS] files
 				if ($realfile =~ /\.[chsS]$/ &&
 				    $rawline =~ /SPDX-License-Identifier:/ &&
-				    $rawline !~ /^\+\s*\Q$comment\E\s*/) {
+				    $rawline !~ m@^\+\s*\Q$comment\E\s*@) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Improper SPDX comment style for '$realfile', please use '$comment' instead\n" . $herecurr);
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
-					 WARN("SPDX_LICENSE_TAG",
-					      "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
+				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+					WARN("SPDX_LICENSE_TAG",
+					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
-					 my $spdx_license = $1;
-					 if (!is_SPDX_License_valid($spdx_license)) {
-						  WARN("SPDX_LICENSE_TAG",
-						       "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
-					 }
+					my $spdx_license = $1;
+					if (!is_SPDX_License_valid($spdx_license)) {
+						WARN("SPDX_LICENSE_TAG",
+						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+					}
 				}
 			}
 		}
-- 
2.15.0

