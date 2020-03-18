Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866C218A392
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 21:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCRUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 16:14:19 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:41578 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgCRUOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:14:19 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 09F541800D655
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 20:14:18 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2E1CD182CED28;
        Wed, 18 Mar 2020 20:14:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3872:4321:5007:6120:6742:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rock72_41de1d86e501b
X-Filterd-Recvd-Size: 1894
Received: from XPS-9350 (unknown [172.58.30.155])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Mar 2020 20:14:12 +0000 (UTC)
Message-ID: <44514354dd77cc512c3c048deff3de313ed3ff50.camel@perches.com>
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of
 DYNAMIC_DEBUG_CORE
From:   Joe Perches <joe@perches.com>
To:     Orson Zhai <orsonzhai@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Orson Zhai <orson.unisoc@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>, David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Date:   Wed, 18 Mar 2020 13:12:21 -0700
In-Reply-To: <CA+H2tpFj1_3wf9w8uHimi_=vrGXi_u21dU1m3+OKA0ZHmO=WRQ@mail.gmail.com>
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
         <CAHp75VezrovVaHOdKoxXvvHr0v7uRT8tJoHLh9BoJYedj=hjHQ@mail.gmail.com>
         <CA+H2tpFj1_3wf9w8uHimi_=vrGXi_u21dU1m3+OKA0ZHmO=WRQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 04:11 +0800, Orson Zhai wrote:
> On Thu, Mar 19, 2020 at 3:23 AM Andy Shevchenko
[]
> > Highly recommend to ask somebody to do proof read.
> Sorry again.

It's an RFC, no real need to be sorry, many eyeballs etc...


