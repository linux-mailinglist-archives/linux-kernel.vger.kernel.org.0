Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE6194CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 00:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgCZX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 19:28:04 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:41350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgCZX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:27:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 95D65180A7355;
        Thu, 26 Mar 2020 23:27:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:560:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1431:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2559:2562:2693:2731:2828:2895:2902:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4384:4605:5007:6119:6755:7264:7774:7903:8957:9010:9012:9405:10004:10848:11026:11232:11658:11914:12043:12219:12295:12297:12555:12683:12760:13161:13215:13229:13439:14096:14097:14181:14394:14659:14721:21080:21433:21451:21611:21627:21740:21820:21881:21939:30003:30012:30025:30026:30046:30054:30055:30060:30070:30074:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: food14_286f5c524e222
X-Filterd-Recvd-Size: 5098
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 23:27:57 +0000 (UTC)
Message-ID: <5aa5aad6fb1678230c260337dc066cd449a2bf32.camel@perches.com>
Subject: [PATCH] MAINTAINERS: List the section entries in the preferred order
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Mar 2020 16:26:06 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS file header has never shown a preferred order for the
section entries but scripts/parse-maintainers.pl added a preferred
order with commit 61f741645a35 ("parse-maintainers: Add section pattern
sorting")

Commit 5cdbec108fd2 ("parse-maintainers: Do not sort section content by
default") changed the preferred order to be a bit more sensible.

Update the MAINTAINERS section description block to use this preferred
section entry ordering.

Add a slightly better description for the N: entry too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5060aa..ae4db4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -77,21 +77,13 @@ Tips for patch submitters
 
 8.	Happy hacking.
 
-Descriptions of section entries
--------------------------------
+Descriptions of section entries and preferred order
+---------------------------------------------------
 
 	M: *Mail* patches to: FullName <address@domain>
 	R: Designated *Reviewer*: FullName <address@domain>
 	   These reviewers should be CCed on patches.
 	L: *Mailing list* that is relevant to this area
-	W: *Web-page* with status/info
-	B: URI for where to file *bugs*. A web-page with detailed bug
-	   filing info, a direct bug tracker link, or a mailto: URI.
-	C: URI for *chat* protocol, server and channel where developers
-	   usually hang out, for example irc://server/channel.
-	Q: *Patchwork* web based patch tracking system site
-	T: *SCM* tree type and location.
-	   Type is one of: git, hg, quilt, stgit, topgit
 	S: *Status*, one of the following:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
@@ -102,30 +94,39 @@ Descriptions of section entries
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+	W: *Web-page* with status/info
+	Q: *Patchwork* web based patch tracking system site
+	B: URI for where to file *bugs*. A web-page with detailed bug
+	   filing info, a direct bug tracker link, or a mailto: URI.
+	C: URI for *chat* protocol, server and channel where developers
+	   usually hang out, for example irc://server/channel.
 	P: Subsystem Profile document for more details submitting
 	   patches to the given subsystem. This is either an in-tree file,
 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
 	   for details.
+	T: *SCM* tree type and location.
+	   Type is one of: git, hg, quilt, stgit, topgit
 	F: *Files* and directories wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net
 	   F:	drivers/net/*	all files in drivers/net, but not below
 	   F:	*/net/*		all files in "any top level directory"/net
 	   One pattern per line.  Multiple F: lines acceptable.
+	X: *Excluded* files and directories that are NOT maintained, same
+	   rules as F:. Files exclusions are tested before file matches.
+	   Can be useful for excluding a specific subdirectory, for instance:
+	   F:	net/
+	   X:	net/ipv6/
+	   matches all files in and below net excluding net/ipv6/
 	N: Files and directories *Regex* patterns.
-	   N:	[^a-z]tegra	all files whose path contains the word tegra
+	   N:	[^a-z]tegra	all files whose path contains tegra
+	                        (not including files like integrator)
 	   One pattern per line.  Multiple N: lines acceptable.
 	   scripts/get_maintainer.pl has different behavior for files that
 	   match F: pattern and matches of N: patterns.  By default,
 	   get_maintainer will not look at git log history when an F: pattern
 	   match occurs.  When an N: match occurs, git log history is used
 	   to also notify the people that have git commit signatures.
-	X: *Excluded* files and directories that are NOT maintained, same
-	   rules as F:. Files exclusions are tested before file matches.
-	   Can be useful for excluding a specific subdirectory, for instance:
-	   F:	net/
-	   X:	net/ipv6/
-	   matches all files in and below net excluding net/ipv6/
 	K: *Content regex* (perl extended) pattern match in a patch or file.
 	   For instance:
 	   K: of_get_profile


