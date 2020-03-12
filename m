Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE631827EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 05:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgCLEoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 00:44:02 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:42318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727099AbgCLEoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:44:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5BAE41801E57D;
        Thu, 12 Mar 2020 04:44:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:4250:4321:5007:6117:6119:7901:7904:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12679:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21627:30054:30062:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: coil35_22f9bd1ddff3a
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 04:44:00 +0000 (UTC)
Message-ID: <4aadd119d4336de9eafcfbadb951630eb0cf2eb9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: always allow C99 SPDX License Identifer
 comments
From:   Joe Perches <joe@perches.com>
To:     Scott Branden <scott.branden@broadcom.com>,
        Andy Whitcroft <apw@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Date:   Wed, 11 Mar 2020 21:42:17 -0700
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

On Wed, 2020-03-11 at 19:48 -0700, Scott Branden wrote:
> Hi Joe,
> 
> On 2020-03-11 7:26 p.m., Joe Perches wrote:
> > On Wed, 2020-03-11 at 12:11 -0700, Scott Branden wrote:
> > > Always allow C99 comment styles if SPDK-License-Identifier is in comment
> > > even if C99_COMMENT_TOLERANCE is specified in the --ignore options.
> > Why is this useful?
> This is useful because if you run checkpatch with 
> --ignore=C99_COMMENT_TOLERANCE
> right now it will warn on almost every .c file in the linux kernel due 
> to the decision to
> use // SPDX-License-Identifier: at the start of every c file

Maybe this is better:

Just don't perform any other per-line checks on a valid or invalid
SPDX line.

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


