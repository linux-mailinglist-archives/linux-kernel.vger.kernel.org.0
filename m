Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3F19A368
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 04:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgDACCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 22:02:50 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:56514 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731523AbgDACCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:02:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A66B180295A7;
        Wed,  1 Apr 2020 02:02:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:4605:5007:6119:10004:10400:10848:10967:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: swim09_52a8a4aeb7003
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2020 02:02:47 +0000 (UTC)
Message-ID: <b630a85e4f75e179cfa4a3cef4a4bc9fcca8109a.camel@perches.com>
Subject: Re: [PATCH 0/2] Documentation: Convert sysfs-pci to ReST
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 31 Mar 2020 19:00:53 -0700
In-Reply-To: <20200331164956.0e10b87e@lwn.net>
References: <cover.1585693146.git.vitor@massaru.org>
         <20200331164956.0e10b87e@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 16:49 -0600, Jonathan Corbet wrote:
> On Tue, 31 Mar 2020 19:28:55 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > Vitor Massaru Iha (2):
> >   Documentation: filesystems: Convert sysfs-pci to ReST
> >   Documentation: filesystems: remove whitespaces
> > 
> >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 44 ++++++++++---------
> >  1 file changed, 24 insertions(+), 20 deletions(-)
> >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (81%)
[]
> When you convert a file to RST, you need to add it to the index.rst file
> as well so that it can be a part of the documentation build.

And if it's in the MAINTAINERS file, update the file type too.


