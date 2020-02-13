Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A870715B6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 02:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgBMBdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 20:33:21 -0500
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:42230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729285AbgBMBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:33:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 124AA1801A89A;
        Thu, 13 Feb 2020 01:33:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2895:2902:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:8957:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14093:14097:14181:14659:14721:21080:21451:21611:21627:21740:21939:30054:30070:30080:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bike27_572f8f1d99a5a
X-Filterd-Recvd-Size: 2605
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 13 Feb 2020 01:33:19 +0000 (UTC)
Message-ID: <2dab786b686735ec0c4ee614c64448d78c67a51d.camel@perches.com>
Subject: Re: [PATCH 1/1] checkpatch: support "base-commit:" format
From:   Joe Perches <joe@perches.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Feb 2020 17:32:01 -0800
In-Reply-To: <a22937adb1bb364e4f5b8f30ee928a2df5cc226c.camel@perches.com>
References: <20200212233221.47662-1-jhubbard@nvidia.com>
         <20200212233221.47662-2-jhubbard@nvidia.com>
         <a22937adb1bb364e4f5b8f30ee928a2df5cc226c.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 17:06 -0800, Joe Perches wrote:
> On Wed, 2020-02-12 at 15:32 -0800, John Hubbard wrote:
> > In order to support the get-lore-mbox.py tool described in [1], I ran:
> > 
> >     git format-patch --base=<commit> --cover-letter <revrange>
> > 
> > ...which generated a "base-commit: <commit-hash>" tag at the end of the
> > cover letter. However, checkpatch.pl generated an error upon encounting
> > "base-commit:" in the cover letter:
> > 
> >     "ERROR: Please use git commit description style..."
> > 
> > ...because it found the "commit" keyword, and failed to recognize that
> > it was part of the "base-commit" phrase, and as such, should not be
> > subjected to the same commit description style rules.
> > 
> > Update checkpatch.pl to include a special case for "base-commit:", so
> > that that tag no longer generates a checkpatch error.
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -2761,6 +2761,7 @@ sub process {
> >  
> >  # Check for git id commit length and improperly formed commit descriptions
> >  		if ($in_commit_log && !$commit_log_possible_stack_dump &&
> > +		    $line !~ /base-commit:/ &&
> 
> If this base-commit: entry is only at the start of line,
> I presume this should actually be
> 
> 		    $line !~ /^base-commit:/ &&
> or maybe
> 		    $line !~ /^\s*base-commit:/ &&
> 
> >  		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&

and probably better to just add it to this line instead like

 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&


