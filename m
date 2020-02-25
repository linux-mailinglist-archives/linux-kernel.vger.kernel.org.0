Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C3316EFED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 21:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgBYUQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 15:16:16 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:33420 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730794AbgBYUQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:16:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D9A14182CED2A;
        Tue, 25 Feb 2020 20:16:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:7522:7875:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12740:12760:12895:13095:13255:13439:14181:14659:14721:21080:21433:21451:21611:21627:21740:21741:30034:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: lake01_706d7905ad62e
X-Filterd-Recvd-Size: 3389
Received: from XPS-9350 (unknown [172.58.92.58])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 20:16:12 +0000 (UTC)
Message-ID: <8b25478b524f5d9de8e080edf84b2daf1313cb00.camel@perches.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
From:   Joe Perches <joe@perches.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 25 Feb 2020 12:14:39 -0800
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

On Tue, 2020-02-25 at 09:45 -0800, John Stultz wrote:
> On Mon, Feb 24, 2020 at 10:50 PM Joe Perches <joe@perches.com> wrote:
> > > Since I have a few kernel repos that I use for both upstream work and
> > > work targeting AOSP trees, I usually have the gerrit commit hook
> > > enabled in my tree (its easier to strip with sed then it is to re-add
> > > after submitting to gerrit), and at least the commit-msg hook I have
> > > will usually append a Change-Id: line at the end of the commit
> > > message, usually after the signed-off-by line.

I think this better still:

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


