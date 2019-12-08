Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3411642C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfLHXk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 18:40:29 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:47135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbfLHXk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:40:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 3733B837F24A;
        Sun,  8 Dec 2019 23:40:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:152:355:379:582:599:988:989:1152:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3351:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:6261:6691:7775:7903:8660:10004:10400:10848:11232:11596:11658:11914:12050:12297:12740:12760:12895:13069:13148:13161:13229:13230:13311:13357:14659:14685:14721:21080:21451:21627:21972:30054:30060,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: shelf57_3e1971b1a1607
X-Filterd-Recvd-Size: 1623
Received: from perches-mx.perches.com (imap-ext [216.40.42.5])
        (Authenticated sender: webmail@joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Dec 2019 23:40:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 08 Dec 2019 17:40:26 -0600
From:   joe@perches.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] treewide conversion to sizeof_member() for v5.5-rc1
In-Reply-To: <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
References: <201912071144.768E249A4F@keescook>
 <CAHk-=wgnaWN1V2G1zyk8zqTVQBdHBBHcdkB-rek5z2VeRq4nmA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <8ad884f80c538efabc5c2442517c75c9@perches.com>
X-Sender: joe@perches.com
X-Originating-IP: [172.58.107.218]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-08 17:19, Linus Torvalds wrote:
> maybe it's
> the 13-year old in me, but "sizeof_member()" just makes me go "that's
> puerile.

The 13 year old in you could grow up one day.  Most 13 year olds don't 
even know that word btw.

> I _can_ see why we'd want to standardize on one of the tree versions
> we have, but I can't really see the problem with the existing #define
> that we have, and that is used (admittedly not all that much):
> sizeof_field()

Call it what the standard calls it.
