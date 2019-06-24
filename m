Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5E51C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfFXUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 16:42:17 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:42241 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbfFXUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:42:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D213A18225E07;
        Mon, 24 Jun 2019 20:42:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3871:3872:3874:4321:5007:7903:8531:8957:9010:9040:10004:10400:10432:10433:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12681:12740:12760:12895:13138:13231:13439:14181:14659:14721:19903:19997:21080:21433:21451:21627:21740:21819:30003:30022:30029:30030:30046:30054:30062:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:34,LUA_SUMMARY:none
X-HE-Tag: patch08_8809e2ec12838
X-Filterd-Recvd-Size: 4125
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 20:42:14 +0000 (UTC)
Message-ID: <02324731bac2da6ef30b3812edaf213ecf626fe4.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add --cc option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 13:42:13 -0700
In-Reply-To: <20190624202512.GK3436@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190624202512.GK3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 22:25 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 07:27:47AM -0700, Joe Perches wrote:
> > On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> > > > The --cc adds a Cc: prefix infront of the email address so it can be
> > > > used by other Scripts directly instead of adding another wrapper for
> > > > this.
> > 
> > Not sure I like the "--cc" option naming.
> > Maybe "--prefix [string]" to be a bit more generic.
> > 
> > > Would it make sense to make '--cc' imply --no-roles --no-rolestats ?
> > 
> > Maybe.
> > 
> > It's also unlikely to be sensibly used with mailing
> > lists so maybe --nol too.
> 
> Is there also an option to exclude moderated lists?

Nope.  Not yet ;)

>  --no-s doesn't seem to do that.

I suppose a --nomoderated could work. (-m is already maintainers)

> I hate it when people cross-post to moderated lists, and
> this thing just made me do it :-(

Maybe:
---
 scripts/get_maintainer.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420..8c2fc22f3a11 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -27,6 +27,7 @@ my $email_usename = 1;
 my $email_maintainer = 1;
 my $email_reviewer = 1;
 my $email_list = 1;
+my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
 my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
@@ -248,6 +249,7 @@ if (!GetOptions(
 		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
+		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
@@ -1023,7 +1025,8 @@ MAINTAINER field selection options:
     --r => include reviewer(s) if any
     --n => include name 'Full Name <addr\@domain.tld>'
     --l => include list(s) if any
-    --s => include subscriber only list(s) if any
+    --moderated => include moderated lists(s) if any (default: true)
+    --s => include subscriber only list(s) if any (default: false)
     --remove-duplicates => minimize duplicate email names/addresses
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
@@ -1313,11 +1316,14 @@ sub add_categories {
 		} else {
 		    if ($email_list) {
 			if (!$hash_list_to{lc($list_address)}) {
-			    $hash_list_to{lc($list_address)} = 1;
 			    if ($list_additional =~ m/moderated/) {
-				push(@list_to, [$list_address,
-						"moderated list${list_role}"]);
+				if ($email_moderated_list) {
+				    $hash_list_to{lc($list_address)} = 1;
+				    push(@list_to, [$list_address,
+						    "moderated list${list_role}"]);
+				}
 			    } else {
+				$hash_list_to{lc($list_address)} = 1;
 				push(@list_to, [$list_address,
 						"open list${list_role}"]);
 			    }


