Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEEA6D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfICQFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 12:05:53 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:55778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729709AbfICQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:05:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 650DD8368EE9;
        Tue,  3 Sep 2019 16:05:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2689:2693:2731:2915:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3871:3872:3874:4321:5007:7514:7875:9010:9012:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12895:13255:13894:14181:14659:14721:21080:21221:21324:21451:21627:30054:30069:30070:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: twist07_6d34be5b1f50c
X-Filterd-Recvd-Size: 3460
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Sep 2019 16:05:50 +0000 (UTC)
Message-ID: <0435c104093ca60cee5f0489e54af54b693fed10.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - don't check for const structs
 if list is empty
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Pablo Pellecchia <pablo9891@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 09:05:48 -0700
In-Reply-To: <542749.1567507103@turing-police>
References: <542749.1567507103@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 06:38 -0400, Valdis Klētnieks wrote:
> If the list of structures we expect to be const is empty (due to file permissions,
> or the file being empty, etc), we get odd complaints about structures:
> 
> [/usr/src/linux-next] scripts/checkpatch.pl -f drivers/staging/netlogic/platform_net.h
> No structs that should be const will be found - file '/usr/src/linux-next/scripts/const_structs.checkpatch': Permission denied
> WARNING: struct  should normally be const
> #9: FILE: drivers/staging/netlogic/platform_net.h:9:
> +struct xlr_net_data {
> 
> WARNING: struct  should normally be const
> #20: FILE: drivers/staging/netlogic/platform_net.h:20:
> +	struct xlr_fmn_info *gmac_fmn_info;
> 
> total: 0 errors, 2 warnings, 0 checks, 21 lines checked
> 
> Fix it so that it actually *obeys* what it said about not finding structures.
> 
> Reported-by: Pablo Pellecchia <pablo9891@gmail.com>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f4b6127ff469..103c67665f61 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6497,7 +6497,7 @@ sub process {
>  
>  # check for various structs that are normally const (ops, kgdb, device_tree)
>  # and avoid what seem like struct definitions 'struct foo {'
> -		if ($line !~ /\bconst\b/ &&
> +		if ($line !~ /\bconst\b/ && $const_structs ne "" &&

Seems sensible, thanks.

I think this would read better with this test order reversed.

Maybe this should verify that const does not exist before the
specific struct found: (and is not also a forward declaration)
---
 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f4b6127ff469..77d585950ab0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6496,11 +6496,12 @@ sub process {
 		}
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
-# and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
-		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
+# avoid struct definitions 'struct foo {' and forward declarations 'struct foo;'
+		if ($const_structs ne "" &&
+		    $line =~ /((\bstruct\s+($const_structs))\b(?!\s*[\{;]))/ &&
+		    $line !~ /\bconst\s+\Q$1\E/) {
 			WARN("CONST_STRUCT",
-			     "struct $1 should normally be const\n" . $herecurr);
+			     "struct $2 should normally be const\n" . $herecurr);
 		}
 
 # use of NR_CPUS is usually wrong


