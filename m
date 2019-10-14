Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF0D6AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfJNUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 16:55:47 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:58924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731694AbfJNUzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:55:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 28298182CED2A;
        Mon, 14 Oct 2019 20:55:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 80,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:966:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3871:3874:4184:4250:4321:4385:5007:6117:6119:7550:7901:7903:8531:10004:10400:11026:11232:11658:11914:12043:12048:12297:12663:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21324:21451:21627:30054:30091,0,RBL:23.242.95.240:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: pen10_4f27ab242ff2d
X-Filterd-Recvd-Size: 1763
Received: from XPS-9350 (cpe-23-242-95-240.socal.res.rr.com [23.242.95.240])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 14 Oct 2019 20:55:43 +0000 (UTC)
Message-ID: <f7ebadf988edddd423187c3a09fcc35bf69b25f6.camel@perches.com>
Subject: Re: Documentation/, SPDX tags, and checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Oct 2019 13:55:41 -0700
In-Reply-To: <124ecffe-25a0-ace6-f106-d9d173c17035@nvidia.com>
References: <124ecffe-25a0-ace6-f106-d9d173c17035@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 13:47 -0700, John Hubbard wrote:
> Hi,
> 
> When adding a new Documentation/ file, checkpatch.pl is warning me
> that the SPDX tag is missing. Should checkpatch.pl skip those kinds
> of warnings, seeing as how we probably don't intend on putting the
> SPDX tags at the top of the Documentation/*.rst files?
> 
> Or are we, after all? I'm just looking to get to a warnings-free situation 
> here, one way or the other. :)
> 
> The exact warning I'm seeing is:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #25: FILE: Documentation/vm/get_user_pages.rst:1:
> +.. _get_user_pages:
> 

Looks like ~18% of the .rst files already have SPDX markers

$ git ls-files -- '*.rst' | wc -l
2125

$ git grep -n "SPDX-License-Identifier:" -- '*.rst'| grep ':1:' | wc -l
378

Likely all .rst files will have these markers eventually.

