Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574A1C0791
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 16:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfI0O3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 10:29:34 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:32830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbfI0O3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:29:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6482B182CF668;
        Fri, 27 Sep 2019 14:29:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2196:2199:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4385:4605:5007:6119:7901:7903:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12050:12297:12438:12740:12760:12895:13141:13230:13439:14181:14659:14721:21080:21433:21451:21611:21627:21740:21741:21819:30022:30054:30070:30090:30091,0,RBL:113.161.34.234:@perches.com:.lbl8.mailshell.net-62.14.241.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: lunch41_5320358922011
X-Filterd-Recvd-Size: 3127
Received: from XPS-9350 (unknown [113.161.34.234])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Sep 2019 14:29:30 +0000 (UTC)
Message-ID: <7672dd2f651bfdcdb1615ab739e36a381b2535b1.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 27 Sep 2019 07:29:28 -0700
In-Reply-To: <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
References: <20190913211349.28245-1-robh@kernel.org>
         <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
         <CAL_JsqLtEM9+LK=3YDLnoZbC1v09R9-qfFNEH-gTWj94FAjnyg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-27 at 09:02 -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 4:48 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> > > DT bindings are moving to using a json-schema based schema format
> > > instead of freeform text. Add a checkpatch.pl check to encourage using
> > > the schema for new bindings. It's not yet a requirement, but is
> > > progressively being required by some maintainers.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -2822,6 +2822,14 @@ sub process {
> > >                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
> > >               }
> > > 
> > > +# Check for adding new DT bindings not in schema format
> > > +             if (!$in_commit_log &&
> > > +                 ($line =~ /^new file mode\s*\d+\s*$/) &&
> > > +                 ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> > > +                     WARN("DT_SCHEMA_BINDING_PATCH",
> > > +                          "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> > > +             }
> > > +
> > 
> > As this already seems to be git dependent, perhaps
> 
> It's quite rare to see a non git generated diff these days.
> 
> > it's easier to read with a single line test like:
> > 
> >                 if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
> >                         etc...
> >                 }
> 
> I frequently do 'git show $commit | scripts/checkpatch.pl' and this
> doesn't work with that. I really should have a '--pretty=email' in
> there, but I just ignore the commit msg warnings. In any case, that
> still doesn't help because there's no diffstat. There's probably some
> way to turn that on or just use git-format-patch, but really we want
> this to work with any git diff.

I don't understand your argument against what I proposed at all.

and btw:

$ git format-patch -1 --stdout <commit> | ./scripts/checkpatch.pl


