Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E46A1BFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEMX6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 19:58:12 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:42088 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbfEMX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:58:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A0001180A8877;
        Mon, 13 May 2019 23:58:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3870:3871:4321:4823:5007:7901:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14181:14659:21080:21627:30054:30060:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: truck57_817ac89ed1b4e
X-Filterd-Recvd-Size: 1598
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 23:58:09 +0000 (UTC)
Message-ID: <1b9e57cb7544f1edbef9a142663e8f71874b204d.camel@perches.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Mon, 13 May 2019 16:58:08 -0700
In-Reply-To: <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
         <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
         <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
         <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
         <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 08:46 +0900, Masahiro Yamada wrote:
> So, I think these two checks can be done for
> all file types.
[]
> checkpatch.pl misses to report most of them.
> (the majority of the warning source is *.json)

Perhaps the json files should be ignored as more than
half of the .json files in the tree are missing the
newline at EOF.

And at least some of those json files use spaces for
indentation and not tabs.

