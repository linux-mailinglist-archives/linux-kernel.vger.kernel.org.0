Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 281FF16ED6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgBYSDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 13:03:55 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:43896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726953AbgBYSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:03:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DD60E182CF66B;
        Tue, 25 Feb 2020 18:03:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13095:13161:13229:13255:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:21740:30012:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: oven98_793e7f329cb3d
X-Filterd-Recvd-Size: 2865
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 18:03:53 +0000 (UTC)
Message-ID: <95aa867717aad711f66614d0daeab238c61a97da.camel@perches.com>
Subject: Re: [RFC][PATCH] checkpatch: Properly warn if Change-Id comes after
 first Signed-off-by line
From:   Joe Perches <joe@perches.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 25 Feb 2020 10:02:23 -0800
In-Reply-To: <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
References: <20200224235824.126361-1-john.stultz@linaro.org>
         <a8af6c423501d5d49f1d81997b3a2295c0df7b9e.camel@perches.com>
         <CALAqxLW7xjPh8SZtZ+ES9fghdMDQZfG_ToSrX+u7DMAOixyQ1Q@mail.gmail.com>
         <187fa03a3690806748ca7cfd2b61728c0d33dcf0.camel@perches.com>
         <CALAqxLW1K00cWkYjQCNjUdZQZsCnbi22LnAMnT56J8tYeRmoMQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 09:45 -0800, John Stultz wrote:
> On Mon, Feb 24, 2020 at 10:50 PM Joe Perches <joe@perches.com> wrote:
> > > Since I have a few kernel repos that I use for both upstream work and
> > > work targeting AOSP trees, I usually have the gerrit commit hook
> > > enabled in my tree (its easier to strip with sed then it is to re-add
> > > after submitting to gerrit), and at least the commit-msg hook I have
> > > will usually append a Change-Id: line at the end of the commit
> > > message, usually after the signed-off-by line.
> > 
> > Perhaps this is better:
> > ---
> >  scripts/checkpatch.pl | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -2721,9 +2721,9 @@ sub process {
> >                 }
> > 
> >  # Check for unwanted Gerrit info
> > -               if ($in_commit_log && $line =~ /^\s*change-id:/i) {
> > +               if ($realfile eq '' && $line =~ /^\s*change-id:/i) {
> >                         ERROR("GERRIT_CHANGE_ID",
> > -                             "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
> > +                             "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
> >                 }
> > 
> >  # Check if the commit log is in a possible stack dump
> > 
> 
> Yep. This works well for me, catching Change-Id lines that are missed
> by the current code.
> 
> Tested-by: John Stultz <john.stultz@linaro.org>

A negative approach to this is if the change-id is after
the "---" separator line but before any file diff, then the
"Remove Gerrit Change-Id" message will still be emitted.

Dunno if that's an issue.


