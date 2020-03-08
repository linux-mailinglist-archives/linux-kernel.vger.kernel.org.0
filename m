Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6417D69E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 23:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCHWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 18:06:42 -0400
Received: from smtprelay0154.hostedemail.com ([216.40.44.154]:35758 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgCHWGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:06:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 855015DE6;
        Sun,  8 Mar 2020 22:06:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2693:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:10004:10128:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13163:13229:13255:13311:13357:13439:14659:21080:21627:21939:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wash33_1d0ce4d7d731c
X-Filterd-Recvd-Size: 2123
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 22:06:39 +0000 (UTC)
Message-ID: <c1994e1c86a97619f233ccd93d7714acda9b8cd3.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Date:   Sun, 08 Mar 2020 15:05:00 -0700
In-Reply-To: <6a48e37a-a377-c9c8-3de8-c183b27cec46@embeddedor.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
         <4304de54a44b7c8c22d8c2d9249d716664cf5ce8.camel@perches.com>
         <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
         <259f405155a948f90229d3fc8cad928d434b46f9.camel@perches.com>
         <1f71509d-6c58-412d-a817-45b1cc78c06e@embeddedor.com>
         <18d7df753cb90d6c6f5a6b5e2a12b4c102ac8749.camel@perches.com>
         <7a0a3e7b-9c76-22f8-8dbf-acd9960d7950@embeddedor.com>
         <b934b12940ab50218be3b7c5d1b98f5d4f24a1fd.camel@perches.com>
         <6a48e37a-a377-c9c8-3de8-c183b27cec46@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 17:04 -0500, Gustavo A. R. Silva wrote:
> 
> The point is: will you update your patch so it doesn't remove
> existing blank lines from the code?

No.

In the first place, I believe what I did is
the preferred style

You need to look at the code and see what you
think needs to be done and then do it instead
of merely sending a fairly pointless nak when
in fact you can't really nak it.  You could
reasonably object to it, but you aren't really
a listed maintainer of any subsystem and you
don't have an upstream tree that is being pulled
by anyone.

I believe it would not trivial to implement
your desire.  You are welcome to try.


