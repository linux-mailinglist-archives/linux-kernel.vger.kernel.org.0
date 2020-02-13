Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C411215C69C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgBMQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 11:02:12 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:38045 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgBMPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 64D68180AAD53;
        Thu, 13 Feb 2020 15:24:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3653:3865:3866:3867:3872:4321:4605:5007:6119:7903:10004:10400:11026:11658:11914:12043:12048:12291:12297:12555:12683:12760:13439:14110:14181:14394:14659:14721:14877:21080:21627:21990:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fact83_447fe222a2361
X-Filterd-Recvd-Size: 3345
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 15:24:30 +0000 (UTC)
Message-ID: <8b6c1b9031ab9f3cdebada06b8d46467f1492d68.camel@perches.com>
Subject: [PATCH] checkpatch: Prefer fallthrough; over fallthrough comments
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 07:23:13 -0800
In-Reply-To: <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
         <20200213125659.GB3325929@kroah.com>
         <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 294f69e662d1 ("compiler_attributes.h: Add 'fallthrough'
pseudo keyword for switch/case use") added the pseudo keyword
so add a test for it to checkpatch.

Warn on a patch or use --strict for files.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f3b8434..5579d7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2286,6 +2286,19 @@ sub pos_last_openparen {
 	return length(expand_tabs(substr($line, 0, $last_openparen))) + 1;
 }
 
+sub get_raw_comment {
+	my ($line, $rawline) = @_;
+	my $comment = '';
+
+	for my $i (0 .. (length($line) - 1)) {
+		if (substr($line, $i, 1) eq "$;") {
+			$comment .= substr($rawline, $i, 1);
+		}
+	}
+
+	return $comment;
+}
+
 sub process {
 	my $filename = shift;
 
@@ -2447,6 +2460,7 @@ sub process {
 		$sline =~ s/$;/ /g;	#with comments as spaces
 
 		my $rawline = $rawlines[$linenr - 1];
+		my $raw_comment = get_raw_comment($line, $rawline);
 
 # check if it's a mode change, rename or start of a patch
 		if (!$in_commit_log &&
@@ -6403,6 +6417,28 @@ sub process {
 			}
 		}
 
+# check for /* fallthrough */ like comment, prefer fallthrough;
+		my @fallthroughs = (
+			'fallthrough',
+			'@fallthrough@',
+			'lint -fallthrough[ \t]*',
+			'intentional(?:ly)?[ \t]*fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)',
+			'(?:else,?\s*)?FALL(?:S | |-)?THR(?:OUGH|U|EW)[ \t.!]*(?:-[^\n\r]*)?',
+			'Fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+			'fall(?:s | |-)?thr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+		    );
+		if ($raw_comment ne '') {
+			foreach my $ft (@fallthroughs) {
+				if ($raw_comment =~ /$ft/) {
+					my $msg_level = \&WARN;
+					$msg_level = \&CHK if ($file);
+					&{$msg_level}("PREFER_FALLTHROUGH",
+						      "Prefer 'fallthrough;' over fallthrough comment\n" . $herecurr);
+					last;
+				}
+			}
+		}
+
 # check for switch/default statements without a break;
 		if ($perl_version_ok &&
 		    defined $stat &&


