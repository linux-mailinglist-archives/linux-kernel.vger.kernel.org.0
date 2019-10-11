Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD4D4722
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfJKSCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 14:02:41 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:35364 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728374AbfJKSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:02:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5A8FE100E86C4;
        Fri, 11 Oct 2019 18:02:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 40,2.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2196:2199:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:4605:5007:6119:7901:7903:10011:10400:11026:11232:11233:11473:11658:11914:12043:12050:12297:12438:12740:12760:12895:13095:13141:13230:13439:14096:14097:14181:14659:14721:21080:21433:21451:21611:21627:21740:21819:30022:30054:30070:30083:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:1:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: crack32_8b747c21a4229
X-Filterd-Recvd-Size: 4323
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 18:02:38 +0000 (UTC)
Message-ID: <a6933fa81cf1510528ed7a4cfa55f57900800fc6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 11 Oct 2019 11:02:37 -0700
In-Reply-To: <CAL_JsqJiV-L14tQte0tZXq+-TRTXGOFW62EsSobu3cFGA8rJDw@mail.gmail.com>
References: <20190913211349.28245-1-robh@kernel.org>
         <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
         <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
         <7672dd2f651bfdcdb1615ab739e36a381b2535b1.camel@perches.com>
         <CAL_JsqKAbP6KYjiJ6dLr=dpFG-j-e4rJPCKZ0+pZrDjsSPAUPQ@mail.gmail.com>
         <CAL_JsqJiV-L14tQte0tZXq+-TRTXGOFW62EsSobu3cFGA8rJDw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 12:56 -0500, Rob Herring wrote:
> On Fri, Sep 27, 2019 at 10:39 AM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Sep 27, 2019 at 9:29 AM Joe Perches <joe@perches.com> wrote:
> > > On Fri, 2019-09-27 at 09:02 -0500, Rob Herring wrote:
> > > > On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > > > > > DT bindings are moving to using a json-schema based schema format
> > > > > > instead of freeform text. Add a checkpatch.pl check to encourage using
> > > > > > the schema for new bindings. It's not yet a requirement, but is
> > > > > > progressively being required by some maintainers.
> > > > > []
> > > > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > > []
> > > > > > @@ -2822,6 +2822,14 @@ sub process {
> > > > > >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > > > > >               }
> > > > > > 
> > > > > > +# Check for adding new DT bindings not in schema format
> > > > > > +             if (!$in_commit_log &&
> > > > > > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > > > > > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > > > > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > > > > > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > > > > > +             }
> > > > > > +
> > > > > 
> > > > > As this already seems to be git dependent, perhaps
> > > > 
> > > > It's quite rare to see a non git generated diff these days.
> > > > 
> > > > > it's easier to read with a single line test like:
> > > > > 
> > > > >                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
> > > > >                         etc...
> > > > >                 }
> > > > 
> > > > I frequently do 'git show $commit | scripts/checkpatch.pl' and this
> > > > doesn't work with that. I really should have a '--pretty=email' in
> > > > there, but I just ignore the commit msg warnings. In any case, that
> > > > still doesn't help because there's no diffstat. There's probably some
> > > > way to turn that on or just use git-format-patch, but really we want
> > > > this to work with any git diff.
> > > 
> > > I don't understand your argument against what I proposed at all.
> > 
> > It is dependent on the commit message rather than the diff itself. I
> > want it to work with or without a diffstat.
> > 
> > > and btw:
> > > 
> > > $ git format-patch -1 --stdout <commit> | ./scripts/checkpatch.pl
> > 
> > Yes, I stated this was possible. My concern is there are lots of ways
> > to generate a diff in git. My way works for *all* of them. Yours
> > doesn't.
> 
> Joe, are you okay with this?

Sure, Andrew Morton does most of the checkpatch upstreaming, but
if you want to send your own pull request, I've no objection.

> Rob

