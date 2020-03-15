Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1362F185A10
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 05:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCOE2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 00:28:01 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:40474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgCOE2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:28:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 21D5F182CED28;
        Sun, 15 Mar 2020 04:28:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4250:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21433:21611:21627:21939:30034:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: queen11_45b03e9819604
X-Filterd-Recvd-Size: 1633
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Mar 2020 04:27:58 +0000 (UTC)
Message-ID: <e8c0df0e7adb53c2e16f5a4f85de9f5a0f627b4f.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Mar 2020 21:26:13 -0700
In-Reply-To: <20200315021222.GU22433@bombadil.infradead.org>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
         <20200315021222.GU22433@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-14 at 19:12 -0700, Matthew Wilcox wrote:
> On Sat, Mar 14, 2020 at 02:13:59PM -0700, Joe Perches wrote:
> > I've no idea how to remove the infinite monkeys jibe from the chinese translation
> 
> I don't think you should.  That's part of Linus' original text, and I
> don't think it deters contributors.
> 
> > -uses are less than desirable (in fact, they are worse than random
> > -typing - an infinite number of monkeys typing into GNU emacs would never
> > -make a good program).
> > +uses are less than desirable.

It's silly, and moderately offensive,
unrepresentative of the softer, modern Linus.


