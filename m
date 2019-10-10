Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65E6D2C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJJOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 10:34:05 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:46466 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726076AbfJJOeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:34:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F416E182CF668;
        Thu, 10 Oct 2019 14:34:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1535:1543:1593:1594:1711:1730:1747:1777:1792:2194:2197:2198:2199:2200:2201:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3355:3622:3653:3834:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:7875:7903:7974:8957:9108:10004:10400:10848:11026:11232:11658:11914:12043:12291:12297:12438:12555:12740:12760:12895:12986:13439:14181:14659:14721:21080:21221:21325:21451:21627:21740:21972:30025:30029:30054:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: paste18_623714dd4446
X-Filterd-Recvd-Size: 5143
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 14:34:02 +0000 (UTC)
Message-ID: <9b331c1184aca8a32b9132d29957cd5e8bef1c1d.camel@perches.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
From:   Joe Perches <joe@perches.com>
To:     dsterba@suse.cz, Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Oct 2019 07:34:01 -0700
In-Reply-To: <20191010142733.GT2751@twin.jikos.cz>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
         <20191009110943.7ff3a08a@gandalf.local.home>
         <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
         <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
         <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
         <20191010142733.GT2751@twin.jikos.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 16:27 +0200, David Sterba wrote:
> On Wed, Oct 09, 2019 at 10:33:45AM -0700, Nick Desaulniers wrote:
> > On Wed, Oct 9, 2019 at 9:38 AM Joe Perches <joe@perches.com> wrote:
> > > I believe __must_check is best placed before the return type as
> > > that makes grep for function return type easier to parse.
> > > 
> > > i.e. prefer
> > >         [static inline] __must_check <type> <function>(<args...>);
> > > over
> > >         [static inline] <type> __must_check <function>(<args...>);
> > > 
> > 
> > + Miguel
> > So I just checked `__cold`, and `__cold` is all over the board in
> > style.  I see it:
> > 1. before anything fs/btrfs/super.c#L101
> > 2. after static before return type (what you recommend) fs/btrfs/super.c#L2318
> > 3. after return type fs/btrfs/inode.c#L9426
> 
> As you can see in the git history, case 1 is from 2015 and the newer
> changes put the attribute between type and name - that's my "current"
> but hopefully final preference.
> 
> > Can we pick a style and enforce it via checkpatch? (It's probably not
> > fun to check for each function attribute in
> > include/linux/compiler_attributes.h).
> 
> Anything that has the return type, attributes and function name on one
> line works for me, but I know that there are other style preferences
> that put function name as the first word on a separate line.  My reasons
> are for better search results, ie.
> 
>   extent_map.c:void __cold extent_map_exit(void)
>   extent_map.h:void __cold extent_map_exit(void);
>   file.c:void __cold btrfs_auto_defrag_exit(void)
>   inode.c:void __cold btrfs_destroy_cachep(void)
>   ordered-data.c:void __cold ordered_data_exit(void)
>   ordered-data.h:void __cold ordered_data_exit(void);
> 
> is better than
> 
>   send.c:__cold
>   super.c:__cold
>   super.c:__cold
>   super.c:__cold
> 
> which I might get to fix eventually.

When your examples have no function arguments, line
length isn't much of an issue. But most functions
take arguments and line length might matter there.

Here's a possible checkpatch test for location of
various __<attributes> that are not particularly
standardized.

---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..ed7e6319e061 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -390,6 +390,19 @@ our $Attribute	= qr{
 			____cacheline_internodealigned_in_smp|
 			__weak
 		  }x;
+
+our $PositionalAttribute	= qr{
+			__must_check|
+			__printf|
+			__scanf|
+			__pure|
+			__cold|
+			__hot|
+			__visible|
+			__weak|
+			noinline
+		}x;
+
 our $Modifier;
 our $Inline	= qr{inline|__always_inline|noinline|__inline|__inline__};
 our $Member	= qr{->$Ident|\.$Ident|\[[^]]*\]};
@@ -3773,6 +3786,17 @@ sub process {
 			     "Avoid multiple line dereference - prefer '$ref'\n" . $hereprev);
 		}
 
+# check for declarations like __must_check ($PositionalAttribute) after the type
+		if ($line =~ /\b($Declare)\s+($PositionalAttribute)\b/) {
+			if (WARN("ATTRIBUTE_POSITION",
+				 "Prefer position of attribute '$2' before '$1'\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s@\b($Declare)(\s+)($PositionalAttribute)\b@$3$2$1@;
+				# 'static void noinline' becomes 'noinline static void', so fix noinline position if necessary
+				$fixed[$fixlinenr] =~ s@\bnoinline(\s+)static\b@static${1}noinline@;
+			}
+		}
+
 # check for declarations of signed or unsigned without int
 		while ($line =~ m{\b($Declare)\s*(?!char\b|short\b|int\b|long\b)\s*($Ident)?\s*[=,;\[\)\(]}g) {
 			my $type = $1;


