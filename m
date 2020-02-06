Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93402153D93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgBFDXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 22:23:46 -0500
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:38011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbgBFDXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:23:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BA3171F06;
        Thu,  6 Feb 2020 03:23:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:69:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:4321:5007:7774:7903:10004:10400:10450:10455:10848:11026:11658:11914:12296:12297:12438:12555:12760:12986:13069:13311:13357:13439:14093:14097:14181:14394:14659:14721:19904:19999:21080:21221:21433:21451:21627:21819:30003:30029:30054:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: oven90_3db4475056c3b
X-Filterd-Recvd-Size: 2265
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Feb 2020 03:23:43 +0000 (UTC)
Message-ID: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
Subject: [PATCH] get_maintainer: Remove uses of P: for maintainer name
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Feb 2020 19:22:31 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
Maintainer Entry Profile") changed the use of the "P:" tag
from "Person" to "Profile (ie: special subsystem coding styles
and characteristics)"

Change how get_maintainer.pl parses the "P:" tag to match.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 34085d..a00156 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1341,35 +1341,11 @@ sub add_categories {
 		    }
 		}
 	    } elsif ($ptype eq "M") {
-		my ($name, $address) = parse_email($pvalue);
-		if ($name eq "") {
-		    if ($i > 0) {
-			my $tv = $typevalue[$i - 1];
-			if ($tv =~ m/^([A-Z]):\s*(.*)/) {
-			    if ($1 eq "P") {
-				$name = $2;
-				$pvalue = format_email($name, $address, $email_usename);
-			    }
-			}
-		    }
-		}
 		if ($email_maintainer) {
 		    my $role = get_maintainer_role($i);
 		    push_email_addresses($pvalue, $role);
 		}
 	    } elsif ($ptype eq "R") {
-		my ($name, $address) = parse_email($pvalue);
-		if ($name eq "") {
-		    if ($i > 0) {
-			my $tv = $typevalue[$i - 1];
-			if ($tv =~ m/^([A-Z]):\s*(.*)/) {
-			    if ($1 eq "P") {
-				$name = $2;
-				$pvalue = format_email($name, $address, $email_usename);
-			    }
-			}
-		    }
-		}
 		if ($email_reviewer) {
 		    my $subsystem = get_subsystem_name($i);
 		    push_email_addresses($pvalue, "reviewer:$subsystem");


