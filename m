Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086E7D00AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 20:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJHSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 14:25:18 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:35115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfJHSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:25:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 617FB180366F8;
        Tue,  8 Oct 2019 18:25:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2197:2198:2199:2200:2393:2553:2559:2562:2692:2693:2828:2895:2911:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:4470:4605:5007:7522:7903:7904:9545:10004:11026:11232:11658:11914:12297:12740:12760:12895:13019:13149:13230:13439:14180:14181:14659:14721:21060:21063:21080:21221:21611:21627:21740:30045:30054:30060:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:744,LUA_SUMMARY:none
X-HE-Tag: bone25_10a92d541f841
X-Filterd-Recvd-Size: 5507
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 18:25:14 +0000 (UTC)
Message-ID: <18e4ecf36ada8a9a90cfb1e96bdb04bdbca4a537.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 11:25:12 -0700
In-Reply-To: <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 20:10 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Oct 8, 2019 at 7:02 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-10-08 at 17:28 +0200, Geert Uytterhoeven wrote:
> > > On Tue, Oct 8, 2019 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > > > On Tue, 2019-10-08 at 11:40 +0200, Geert Uytterhoeven wrote:
> > > > > When reading a patch file from standard input, checkpatch calls it "Your
> > > > > patch", and reports its state as:
> > > > > 
> > > > >     Your patch has style problems, please review.
> > > > > 
> > > > > or:
> > > > > 
> > > > >     Your patch has no obvious style problems and is ready for submission.
> > > > > 
> > > > > Hence when checking multiple patches by piping them to checkpatch, e.g.
> > > > > when checking patchwork bundles using:
> > > > > 
> > > > >     formail -s scripts/checkpatch.pl < bundle-foo.mbox
> > > > > 
> > > > > it is difficult to identify which patches need to be reviewed and
> > > > > improved.
> > > > > 
> > > > > Fix this by replacing "Your patch" by the patch subject, if present.
> > > > []
> > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > []
> > > > > @@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
> > > > >       }
> > > > >       while (<$FILE>) {
> > > > >               chomp;
> > > > > +             if ($vname eq 'Your patch') {
> > > > > +                     my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > > > +                     $vname = '"' . $subject . '"' if $subject;
> > > > 
> > > > Hi again Geert.
> > > > 
> > > > Just some stylistic nits:
> > > > 
> > > > $filename is not quoted so I think adding quotes
> > > > before and after $subject may not be useful.
> > > 
> > > Filename is indeed not quoted, but $git_commits{$filename} is.
> > 
> > If I understand your use case, this will only show the last
> > patch $subject of a bundle?
> 
> False.

Not really false, it's true.  Your use case just
doesn't submit bundled patches as a single input
to checkpatch.

> "formail -s scripts/checkpatch.pl < bundle-foo.mbox" splits
> "bundle-foo.mbox" in separate patches, and invokes
> "scripts/checkpatch.pl" for each of them.

Never used formail, it seems it was last updated in 2001.

> > Also, it'll show things like "duplicate signature" when multiple
> > patches are tested in a single bundle.
> 
> False, due to the splitting by formail.

Again, not false, just not your use.

> > For instance, if I have a git format-patch series in an output
> > directory and do
> > 
> > $ cat <output_dir>/*.patch | ./scripts/checkpatch.pl
> > 
> > Bad output happen.
> 
> Yeah, because you're concatenating all patches.
> Currently it works for single patches only.
> 
> > Maybe this might be better:
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2444,6 +2444,15 @@ sub process {
> > 
> >                 my $rawline = $rawlines[$linenr - 1];
> > 
> > +# if input from stdin, report the subject lines if they exist
> > +               if ($filename eq '-' && !$quiet &&
> > +                   $rawline =~ /^Subject:\s*(.*)/) {
> > +                       report("stdin", "STDIN", '-' x length($1));
> > +                       report("stdin", "STDIN", $1);
> > +                       report("stdin", "STDIN", '-' x length($1));
> > +                       %signatures = ();       # avoid duplicate signatures
> > +               }
> > +
> >  # check if it's a mode change, rename or start of a patch
> >                 if (!$in_commit_log &&
> >                     ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
> 
> Perhaps.  Just passing the patchwork bundle to checkpatch, and fixing
> checkpatch to handle multiple patches in a single file was my first idea.
> But it looked fragile, with too much state that needs to be reset.
> I.e. the state is not limited to %signatures.  You also have to reset
> $author inside process(), and probably a dozen other variables.
> And make sure that future changes don't forget resetting all newly
> introduced variables.
> 
> Hence I settled for the solution using formail.

I still think the patch I suggested is better as it
functions for other use cases too.



