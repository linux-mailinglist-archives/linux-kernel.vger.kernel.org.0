Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8F16ED7A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbfGTDJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 23:09:23 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:52322 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729238AbfGTDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:09:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 44B2818225E03;
        Sat, 20 Jul 2019 03:09:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3867:3868:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6691:7901:9025:10004:10400:10848:10967:11232:11257:11658:11914:12043:12297:12438:12555:12663:12740:12760:12783:12895:13069:13311:13357:13439:13846:14096:14097:14180:14181:14659:14721:14849:21060:21080:21451:21627:30054:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: lamp01_1756563093547
X-Filterd-Recvd-Size: 1773
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 20 Jul 2019 03:09:20 +0000 (UTC)
Message-ID: <a91f850658e6d2ba206639e214ee47a0dcd90f38.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Improve SPDX license checking
From:   Joe Perches <joe@perches.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Jul 2019 20:09:19 -0700
In-Reply-To: <20190720122203.7baf841a@canb.auug.org.au>
References: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
         <f08eb62458407a145cfedf959d1091af151cd665.1563575364.git.joe@perches.com>
         <20190720122203.7baf841a@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-07-20 at 12:22 +1000, Stephen Rothwell wrote:
> Hi Joe,
> 
> On Fri, 19 Jul 2019 15:31:33 -0700 Joe Perches <joe@perches.com> wrote:
> > Use perl's m@<match>@ match and not /<match>/ comparisons to avoid
> > an error using c90's // comment style.
> > 
> > Miscellanea:
> > 
> > o Use normal tab indentation and alignment
> > 
> > Link: http://lkml.kernel.org/r/5e4a8fa7901148fbcd77ab391e6dd0e6bf95777f.camel@perches.com
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Again, don't include other's (non author's) SOB lines.

Nope.
You _already_ signed-off this patch.
I'm simply reproducing it.


