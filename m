Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABB18427E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 09:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCMIXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 04:23:42 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:36336 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgCMIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:23:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 878B3100E7B43;
        Fri, 13 Mar 2020 08:23:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2332:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3865:3866:3867:3870:3871:3872:4321:5007:7901:7903:10004:10400:10848:11026:11473:11658:11914:12043:12048:12297:12438:12555:12760:13019:13069:13311:13357:13439:14181:14394:14659:14721:21080:21627:30054:30064:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: spade84_7766863b53717
X-Filterd-Recvd-Size: 2027
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Mar 2020 08:23:40 +0000 (UTC)
Message-ID: <093972fc6ff494cf0ac554f05127654df75e6669.camel@perches.com>
Subject: [PATCH] checkpatch: No additional checking of SPDX License
 Identifier necessary
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date:   Fri, 13 Mar 2020 01:21:56 -0700
In-Reply-To: <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
References: <20200311191128.7896-1-scott.branden@broadcom.com>
         <2c4b42d1fb0bdb6604a72b2a10d49f9eae4b0ff4.camel@perches.com>
         <7056bd62-4251-f9bb-2b97-15f93a1e7142@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If checkpatch is run with --ignore=C99_COMMENT_TOLERANCE it
will warn on almost every .c file because linux kernel style
requires use of a C99 comment // SPDX-License-Identifier:

checkpatch does not need to do any additional per-line checking
after checking the SPDX-License-Identifier line.

This allows the C99 comment style for SPDK-License-Identifier
even if C99_COMMENT_TOLERANCE is specified by an --ignore option.

Original-patch-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 529c892..3f2ae7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3171,6 +3171,7 @@ sub process {
 						WARN("SPDX_LICENSE_TAG",
 						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
 					}
+					next;
 				}
 			}
 		}



