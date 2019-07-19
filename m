Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742A46EC85
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfGSWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 18:31:37 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:39670 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfGSWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:31:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CD874181D12E4;
        Fri, 19 Jul 2019 22:31:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:967:973:982:988:989:1260:1263:1345:1431:1437:1534:1541:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3865:3866:3867:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6261:8531:9025:10004:10848:11026:11232:11257:11658:11914:12043:12297:12438:12555:12679:12783:12895:12986:13069:13311:13357:13846:14181:14384:14394:14721:14849:21063:21080:21451:21627:30003:30054,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:23,LUA_SUMMARY:none
X-HE-Tag: balls64_4803536cd1a0e
X-Filterd-Recvd-Size: 1905
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 22:31:34 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: Don't interpret stack dumps as commit IDs
Date:   Fri, 19 Jul 2019 15:31:32 -0700
Message-Id: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more types of lines that appear to be stack dumps that also include
hex lines that might otherwise be interpreted as commit IDs.

Link: http://lkml.kernel.org/r/ff00208289224f0ca4eaf4ff7c9c6e087dad0a63.camel@perches.com

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

This replaces the unsigned patch with an incomplete commit description
in -next.

 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..3c0ee0dde850 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2725,8 +2725,10 @@ sub process {
 		    ($line =~ /^\s*(?:WARNING:|BUG:)/ ||
 		     $line =~ /^\s*\[\s*\d+\.\d{6,6}\s*\]/ ||
 					# timestamp
-		     $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/)) {
-					# stack dump address
+		     $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/) ||
+		     $line =~ /^(?:\s+\w+:\s+[0-9a-fA-F]+){3,3}/ ||
+		     $line =~ /^\s*\#\d+\s*\[[0-9a-fA-F]+\]\s*\w+ at [0-9a-fA-F]+/) {
+					# stack dump address styles
 			$commit_log_possible_stack_dump = 1;
 		}
 
-- 
2.15.0

