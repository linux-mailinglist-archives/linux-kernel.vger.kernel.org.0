Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71229181B43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 15:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgCKOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 10:32:33 -0400
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:52068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729473AbgCKOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:32:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id ED76818033F6E;
        Wed, 11 Mar 2020 14:32:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3871:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21324:21433:21627:21740:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mark59_160635481ae36
X-Filterd-Recvd-Size: 1361
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 14:32:31 +0000 (UTC)
Message-ID: <8689ac477bce81aec15a9b8d89192b91fb3d3adb.camel@perches.com>
Subject: Re: [PATCH -next 011/491] ARM/QUALCOMM SUPPORT: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 11 Mar 2020 07:30:48 -0700
In-Reply-To: <c9ae6eed-6320-56c2-6248-b9c52e7d34d0@free.fr>
References: <cover.1583896344.git.joe@perches.com>
         <2e6818291503f032e7662f1fa45fb64c7751a7ae.1583896348.git.joe@perches.com>
         <c9ae6eed-6320-56c2-6248-b9c52e7d34d0@free.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 09:46 +0100, Marc Gonzalez wrote:
> On 11/03/2020 05:51, Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> 
> What is the rationale for such a change?
> Portability to different tool-chains? Something else?

Converting /* fallthrough */ style comments to the pseudo-keyword fallthrough
allows clang 10 and higher to work at finding missing fallthroughs too.


