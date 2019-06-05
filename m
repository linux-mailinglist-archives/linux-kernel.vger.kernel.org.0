Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8C83592C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFEJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 05:01:11 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:47647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbfFEJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:01:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A54AA7584;
        Wed,  5 Jun 2019 09:01:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3872:4321:4605:5007:7514:7875:8660:10004:10400:10848:11232:11658:11914:12296:12438:12740:12760:12895:13069:13141:13148:13230:13311:13357:13439:14181:14659:14721:21080:21627:30054:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: noise93_270f2bb399346
X-Filterd-Recvd-Size: 1649
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Jun 2019 09:01:08 +0000 (UTC)
Message-ID: <fee93f8714deec96657e5b6df2a987960de4473f.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: ibmphp: Fix 'line over 80 characters'
 Warning
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        benniciemanuel78@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 05 Jun 2019 02:01:07 -0700
In-Reply-To: <CAHp75VfEREXJTr_QpADTsqBr10t16SaJqeM+tbxp6QZgc8Gfjg@mail.gmail.com>
References: <20190602162546.3470-1-benniciemanuel78@gmail.com>
         <CAHp75VfEREXJTr_QpADTsqBr10t16SaJqeM+tbxp6QZgc8Gfjg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 11:41 +0300, Andy Shevchenko wrote:
> On Sun, Jun 2, 2019 at 7:25 PM Emanuel Bennici
> <benniciemanuel78@gmail.com> wrote:
[]
> > +                               debug("%s - call process_changeinstatus for"
> > +                                     "slot[%d]\n", __func__, i);
> 
> Do not split string literals like this.

Especially because it's common to miss the
space required between words when the
compiler coalesces the string fragments.

Like here.

