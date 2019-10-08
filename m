Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4911ED00D8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfJHSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 14:50:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:38874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfJHSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:50:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C952318035432;
        Tue,  8 Oct 2019 18:50:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:10004:10400:11026:11232:11658:11914:12297:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:21740:21795:30045:30051:30054:30060:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: rail72_57b7586455f60
X-Filterd-Recvd-Size: 2295
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 18:50:02 +0000 (UTC)
Message-ID: <334aea9d82188d0cec300d7c02e59afff29b1d0a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: use patch subject when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 11:50:01 -0700
In-Reply-To: <CAMuHMdUpqimKRn_VO+K5TB7+jhvxay1p61kPqgyLVOLwAsfJFw@mail.gmail.com>
References: <20191008094006.8251-1-geert+renesas@glider.be>
         <19c54ca5b3750bebc057e20542ad6c0c2acef960.camel@perches.com>
         <CAMuHMdUYf=0RVeJhSqs9WUY4H+o9Jk8U+J6tUsnMjz7bgKpAxw@mail.gmail.com>
         <f59c1ef48b64bcf97047df5952f8994f75c0cecf.camel@perches.com>
         <CAMuHMdWvLbcGDG=VZDSAd=E-Bb_FEt9zvffpJu5nubMCKMZUZA@mail.gmail.com>
         <18e4ecf36ada8a9a90cfb1e96bdb04bdbca4a537.camel@perches.com>
         <CAMuHMdUpqimKRn_VO+K5TB7+jhvxay1p61kPqgyLVOLwAsfJFw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 20:39 +0200, Geert Uytterhoeven wrote:
[]
> > I still think the patch I suggested is better as it
> > functions for other use cases too.
> 
> I agree it would be better if checkpatch would handle the splitting in
> patches itself, as that would be easier for the user.
> 
> However:
>   1) That requires getting the state reset right,

Not really difficult and maybe not necessary.
The process subroutine contains very limited state.
The biggest issue is resetting the "$in_header_lines"
states and such when a new multi-patch bundle
start is detected.  I'm not sure it actually impacts
the checkpatch output much.  Maybe it'd not emit a
>75 character warning when scanning commit log messages.

>   2) Using formail is the classical old UNIX way (combine small tools
>      to get the job done ;-)

Which doesn't impact your use case as formail is
already running checkpatch multiple times.

cheers, Joe

