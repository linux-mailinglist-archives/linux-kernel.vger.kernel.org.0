Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8658C11C12D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 01:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLLANd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 19:13:33 -0500
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:34102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbfLLANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:13:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B768C2839;
        Thu, 12 Dec 2019 00:13:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4470:4560:4605:5007:6119:7903:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13439:14096:14097:14180:14181:14659:14721:21060:21080:21433:21611:21627:21788:21819:21939:30030:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: map45_5862a42f9f662
X-Filterd-Recvd-Size: 4204
Received: from XPS-9350 (unknown [66.178.38.77])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Dec 2019 00:13:26 +0000 (UTC)
Message-ID: <6202bccc888809dcb76ea6ba8c0a87d138ce1bbd.camel@perches.com>
Subject: Re: get_maintainer.pl produces non-deterministic results
From:   Joe Perches <joe@perches.com>
To:     Vegard Nossum <vegard.nossum@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 11 Dec 2019 16:12:44 -0800
In-Reply-To: <CAOMGZ=FhJjQcv-49gQyAYkXW1LhtYcgis8rKASMo_dDKQ+dMkw@mail.gmail.com>
References: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
         <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
         <CAOMGZ=FhJjQcv-49gQyAYkXW1LhtYcgis8rKASMo_dDKQ+dMkw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 07:41 +0100, Vegard Nossum wrote:
> On Wed, 11 Dec 2019 at 01:02, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-12-10 at 14:47 +0100, Dmitry Vyukov wrote:
> > > Hi Joe,
> > > 
> > > scripts/get_maintainer.pl fs/proc/task_mmu.c
> > > non-deterministically gives me from 13 to 16 results, different number
> > > every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
> > > this with v5.28.2.
> > > Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
> > > non-determinism. But I guess it's not the right solution, there should
> > > be some logical problem.
> > > My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.
> > > 
> > > Thanks
> > 
> > https://lkml.org/lkml/2017/7/13/789
> 
> Right, so you can make it reproducible if you add a tie-break to the sorting:
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2c..109d9fb134dad 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -2179,7 +2179,7 @@ sub vcs_assign {
>      $hash{$_}++ for @lines;
> 
>      # sort -rn
> -    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
> +    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
>         my $sign_offs = $hash{$line};
>         my $percent = $sign_offs * 100 / $divisor;
> 
> This would actually favour names that start with early letters (A, B,
> ...) over late letters (..., Y, Z), which might also be a bad thing. I
> think to fix that you could include everybody who has the same number
> of signoffs at the cutoff:
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 34085d146fa2c..80d3ed2ee6d70 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -2179,7 +2179,8 @@ sub vcs_assign {
>      $hash{$_}++ for @lines;
> 
>      # sort -rn
> -    foreach my $line (sort {$hash{$b} <=> $hash{$a}} keys %hash) {
> +    my $prev_sign_offs = -1;
> +    foreach my $line (sort {$hash{$b} <=> $hash{$a} || $a cmp $b} keys %hash) {
>         my $sign_offs = $hash{$line};
>         my $percent = $sign_offs * 100 / $divisor;
> 
> @@ -2187,7 +2188,7 @@ sub vcs_assign {
>         next if (ignore_email_address($line));
>         $count++;
>         last if ($sign_offs < $email_git_min_signatures ||
> -                $count > $email_git_max_maintainers ||
> +                ($prev_sign_offs != $sign_offs && $count >
> $email_git_max_maintainers) ||
>                  $percent < $email_git_min_percent);
>         push_email_address($line, '');
>         if ($output_rolestats) {
> @@ -2196,6 +2197,8 @@ sub vcs_assign {
>         } else {
>             add_role($line, $role);
>         }
> +
> +       $prev_sign_offs = $sign_offs;
>      }
>  }
> 
> These patches are probably horribly whitespace damaged, hopefully you
> get the gist of it though...

I get the gist, but I think it's also not particularly important
to be repeatable.  I think it's more important to get more pattern
coverage of the MAINTAINERS file as that is more important than
any use of git history.


