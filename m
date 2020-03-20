Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70E18C484
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCTBI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 21:08:27 -0400
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:60378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbgCTBI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:08:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1747118224D66;
        Fri, 20 Mar 2020 01:08:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6691:10004:10400:10848:11232:11658:11914:12048:12297:12663:12740:12760:12895:13019:13069:13255:13311:13357:13439:14659:21080:21627:21660:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:18,LUA_SUMMARY:none
X-HE-Tag: gun68_4983d98e6fa20
X-Filterd-Recvd-Size: 1765
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 01:08:25 +0000 (UTC)
Message-ID: <933c893a29b6c5aa85758ca6a7e2d2c99170bc11.camel@perches.com>
Subject: Re: [PATCH -next] mm/hugetlb.c: fix printk format warning for
 32-bit phys_addr_t
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Mar 2020 18:06:38 -0700
In-Reply-To: <58454a65-5022-7517-df65-7bf504cd1432@infradead.org>
References: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
         <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
         <ff8cc527-e02e-4f4b-56cd-a94ac5e527a3@infradead.org>
         <be55765b11f925f15f338152399923e169a20f53.camel@perches.com>
         <58454a65-5022-7517-df65-7bf504cd1432@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 18:03 -0700, Randy Dunlap wrote:
> On 3/18/20 7:37 PM, Joe Perches wrote:
> > On Wed, 2020-03-18 at 19:11 -0700, Randy Dunlap wrote:

> > > I'm fairly sure that the [begin, end) notation is done on purpose, meaning
> > > 
> > > <begin> is included in the range and <end> is not included in the range.
> > 
> > OK, that seems a pretty obscure and not obvious use of
> > interval notation, at least to me. (18 uses treewide ?)
> > 
> > Maybe it could be documented somewhere?
> 
> I thought about where to put that and came up empty.

No worries then, it's likely not _too_ obscure
to anyone that's sent a log for analysis.



