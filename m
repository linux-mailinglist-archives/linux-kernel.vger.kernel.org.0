Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED718DC2F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 00:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCTXrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 19:47:42 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:38320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbgCTXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:47:42 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 680DC1828B307;
        Fri, 20 Mar 2020 23:47:41 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 948CC18224D60;
        Fri, 20 Mar 2020 23:47:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3874:4321:5007:7903:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: party49_8ab4ee1cae54
X-Filterd-Recvd-Size: 1785
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 23:47:39 +0000 (UTC)
Message-ID: <eb9037a20c81b189468eee3e4849f2707b49278e.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Mar 2020 16:45:51 -0700
In-Reply-To: <20200320173119.2707c083@lwn.net>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
         <20200320173119.2707c083@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-20 at 17:31 -0600, Jonathan Corbet wrote:
> On Sat, 14 Mar 2020 14:13:59 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > fallthrough was added as a pseudo-keyword by commit 294f69e662d1
> > ("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")
> > 
> > Add fallthrough as a keyword to the example .emacs content
> > so emacs can colorize or highlight the uses.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > I've no idea how to remove the infinite monkeys jibe from the chinese translation
> 
> Removing the "jibe" is a second change for this patch, and one which is
> not reflected in the changelog.  If we want to sanitize the docs that's
> something we can talk about, but I don't want to sneak such changes in.

And I don't want to bother with the naysayers.


