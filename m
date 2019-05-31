Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882C630C85
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEaK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 06:26:58 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:55409 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbfEaK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:26:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4FC471F1D;
        Fri, 31 May 2019 10:26:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13311:13357:13439:13618:14181:14659:14721:21080:21611:21627:30054:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:42,LUA_SUMMARY:none
X-HE-Tag: shock41_3c61640e46f43
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 May 2019 10:26:54 +0000 (UTC)
Message-ID: <82dcf6a5726da3bfa39f756a46d2fcf248796150.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local
 variable
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 31 May 2019 03:26:53 -0700
In-Reply-To: <B6174D2A-C9E8-438D-A042-C39CAAA35728@redhat.com>
References: <20190531011227.21181-1-mcroce@redhat.com>
         <e41c7ff9ae38363fe8c32346fea0f7efe551d162.camel@perches.com>
         <B6174D2A-C9E8-438D-A042-C39CAAA35728@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-31 at 10:44 +0200, Matteo Croce wrote:
> On May 31, 2019 5:06:58 AM GMT+02:00, Joe Perches <joe@perches.com> wrote:
> > On Fri, 2019-05-31 at 03:12 +0200, Matteo Croce wrote:
> > > +
> > > +# check for sysctl duplicate constants
> > > +		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
> > 
> > why max_int, there isn't a single use of it in the kernel ?
> 
> Because you can never know how a local variabile will be called.
> I wanted to add intmax and maxint too, bit it seemed too much.

I think that checkpatch should not speculate about things like this.


