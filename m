Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE4D6590
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfJNOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 10:48:46 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:43734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731121AbfJNOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:48:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C6EDA1802B9DB;
        Mon, 14 Oct 2019 14:48:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:2:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:1801:2197:2198:2199:2200:2393:2553:2559:2562:2692:2693:2828:2911:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4117:4321:4425:4470:4605:5007:6119:7522:7903:7904:9545:10004:11026:11232:11658:11914:12297:12663:12740:12760:12895:13019:13149:13230:13439:14096:14097:14659:21060:21063:21080:21221:21433:21611:21627:21740:30045:30054:30060:30070:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: net68_4c34cc100e232
X-Filterd-Recvd-Size: 6406
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 14 Oct 2019 14:48:43 +0000 (UTC)
Message-ID: <fa4ce46605a81d660be73361a4fdd30240a6348e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Oct 2019 07:48:42 -0700
In-Reply-To: <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
         <CAMuHMdWZYOsJv1uQkOFRK2tZO+E8sSHEneUM-p+q5FyAmYZ9Fw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 11:20 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Oct 8, 2019 at 8:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Oct 8, 2019 at 7:02 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2019-10-08 at 17:28 +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > > > > > When reading a patch file from standard input, checkpatch calls it "Your
> > > > > > patch", and reports its state as:
> > > > > > 
> > > > > >     Your patch has style problems, please review.
> > > > > > 
> > > > > > or:
> > > > > > 
> > > > > >     Your patch has no obvious style problems and is ready for submission.
> > > > > > 
> > > > > > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > > > > > when checking patchwork bundles using:
> > > > > > 
> > > > > >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> > > > > > 
> > > > > > it is difficult to identify which patches need to be reviewed and
> > > > > > improved.
> > > > > > 
> > > > > > Fix this by replacing "Your patch" by the patch subject, if present.
> > > > > []
> > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > []
> > > > > > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> > > > > >       }
> > > > > >       while (<$FILE>) {
> > > > > >               chomp;
> > > > > > +             if ($vname eq 'Your patch') {
> > > > > > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > > > > +                     $vname = '"' . $subject . '"' if $subject;
> > > > > 
> > > > > Hi again Geert.
> > > > > 
> > > > > Just some stylistic nits:
> > > > > 
> > > > > $filename is not quoted so I think adding quotes
> > > > > before and after $subject may not be useful.
> > > > 
> > > > Filename is indeed not quoted, but $git_commits{$filename} is.
> > > 
> > > If I understand your use case, this will only show the last
> > > patch $subject of a bundle?
> > 
> > False.
> > "formail -s scripts/checkpatch.pl < bundle-foo.mbox" splits
> > "bundle-foo.mbox" in separate patches, and invokes
> > "scripts/checkpatch.pl" for each of them.
> > 
> > > Also, it'll show things like "duplicate signature" when multiple
> > > patches are tested in a single bundle.
> > 
> > False, due to the splitting by formail.
> > 
> > > For instance, if I have a git format-patch series in an output
> > > directory and do
> > > 
> > > $ cat <output_dir>/*.patch | ./scripts/checkpatch.pl
> > > 
> > > Bad output happen.
> > 
> > Yeah, because you're concatenating all patches.
> > Currently it works for single patches only.
> > 
> > > Maybe this might be better:
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -2444,6 +2444,15 @@ sub process {
> > > 
> > >                 my $rawline = $rawlines[$linenr - 1];
> > > 
> > > +# if input from stdin, report the subject lines if they exist
> > > +               if ($filename eq '-' && !$quiet &&
> > > +                   $rawline =~ /^Subject:\s*(.*)/) {
> > > +                       report("stdin", "STDIN", '-' x length($1));
> > > +                       report("stdin", "STDIN", $1);
> > > +                       report("stdin", "STDIN", '-' x length($1));
> > > +                       %signatures = ();       # avoid duplicate signatures
> > > +               }
> > > +
> > >  # check if it's a mode change, rename or start of a patch
> > >                 if (!$in_commit_log &&
> > >                     ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
> > 
> > Perhaps.  Just passing the patchwork bundle to checkpatch, and fixing
> > checkpatch to handle multiple patches in a single file was my first idea.
> > But it looked fragile, with too much state that needs to be reset.
> > I.e. the state is not limited to %signatures.  You also have to reset
> > $author inside process(), and probably a dozen other variables.
> > And make sure that future changes don't forget resetting all newly
> > introduced variables.
> > 
> > Hence I settled for the solution using formail.
> 
> I gave your solution a try.
> It only enables the reset-on-next-patch feature when using stdin.
> Thanks to the printed subject, it's now obvious to which patch a
> message applies to.
> However, the output is significantly different than when passing
> a split patch series.  Can this be improved upon?
> 
> Note that the only reason I'm using stdin is that I use formail to split
> a bundle in individual patches.  Once checkpatch supports bundles (or
> mboxes) containing multiple patches, there's no longer a need for
> using formail, and the reset-on-next-patch feature should be
> enabled unconditionally.

Using your collection of little tools idea,
why not write a trivial script like:

	grep "^Subject:" $1
	checkpatch.pl $1

and use that as the command line for formail
instead of adding unnecessary complexity to
checkpatch?



