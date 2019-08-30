Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126E7A3DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 20:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfH3S35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 14:29:57 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:60228 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbfH3S35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:29:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 74ACC1804CB44;
        Fri, 30 Aug 2019 18:29:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1543:1593:1594:1605:1711:1730:1747:1777:1792:1963:2197:2198:2199:2200:2393:2553:2559:2562:2828:2899:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7875:7903:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12043:12050:12297:12438:12555:12740:12760:12895:12986:13095:13439:14181:14659:14721:14802:19904:19999:21080:21221:21324:21433:21451:21505:21618:21740:21810:30012:30054:30064:30070:30080:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: egg88_739ff7db6f829
X-Filterd-Recvd-Size: 5067
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 18:29:54 +0000 (UTC)
Message-ID: <2c0595c97811044a45e3d482e752d5877a14c06d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Remove obsolete period from "ambiguous
 SHA1" query
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:29:53 -0700
In-Reply-To: <a8afdbf13db47e7650473c7f71384f177f3dff59.camel@perches.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
         <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
         <20190830171731.GB15405@linux.intel.com>
         <a8afdbf13db47e7650473c7f71384f177f3dff59.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 11:01 -0700, Joe Perches wrote:
> On Fri, 2019-08-30 at 10:17 -0700, Sean Christopherson wrote:
> > On Fri, Aug 30, 2019 at 09:37:51AM -0700, Joe Perches wrote:
> > > On Fri, 2019-08-30 at 09:31 -0700, Sean Christopherson wrote:
> > > > Git dropped the period from its "ambiguous SHA1" error message in commit
> > > > 0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
> > > > circa 2016.  Drop the period from checkpatch's associated query so as to
> > > > match both the old and new error messages.
> > > > 
> > > > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > > > ---
> > > >  scripts/checkpatch.pl | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 93a7edfe0f05..ef3642c53100 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -962,7 +962,7 @@ sub git_commit_info {
> > > >  
> > > >  	return ($id, $desc) if ($#lines < 0);
> > > >  
> > > > -	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
> > > > +	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
> > > >  # Maybe one day convert this block of bash into something that returns
> > > >  # all matching commit ids, but it's very slow...
> > > >  #
> > > 
> > > Thanks.
> > > 
> > > Did git ever change to actually support human readable
> > > messages in multiple languages?
> > 
> > Yep, e.g.:
> > 
> >   error: Kurzer SHA-1 745f ist mehrdeutig.
> > 
> > > If so, this won't work for non-english output.
> > 
> > Yep again.  The next check for 'fatal: ambiguous argument' obviously fails
> > as well and checkpatch ends up using git's error message as the id and
> > description.
> > 
> >   ERROR: Please use git ... - ie: 'commit error: Kurze ("")'
> 
> Does git exit with unique failure codes?
> If so, maybe the waitid/siginfo_t error could be used instead.
> 

Maybe something like this works?
---
 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f4b6127ff469..dc001b7899ed 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,6 +62,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
+my $git_command ='export LANG=en_US.utf-8; git';
 
 sub help {
 	my ($exitcode) = @_;
@@ -918,7 +919,7 @@ sub seed_camelcase_includes {
 	$camelcase_seeded = 1;
 
 	if (-e ".git") {
-		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
+		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -946,7 +947,7 @@ sub seed_camelcase_includes {
 	}
 
 	if (-e ".git") {
-		$files = `git ls-files "include/*.h"`;
+		$files = `${git_command} ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
 	}
 
@@ -970,7 +971,7 @@ sub git_commit_info {
 
 	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
 
-	my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
+	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
 	my @lines = split("\n", $output);
 
@@ -1020,7 +1021,7 @@ if ($git) {
 		} else {
 			$git_range = "-1 $commit_expr";
 		}
-		my $lines = `git log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
+		my $lines = `${git_command} log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
 		foreach my $line (split(/\n/, $lines)) {
 			$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
 			next if (!defined($1) || !defined($2));


