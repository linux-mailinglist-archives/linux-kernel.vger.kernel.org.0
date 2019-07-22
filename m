Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1690370BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbfGVVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:50:14 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:54912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbfGVVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:50:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C6E5F181D3377;
        Mon, 22 Jul 2019 21:50:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2507:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3872:3873:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: net82_1eb9f15d55954
X-Filterd-Recvd-Size: 1676
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 21:50:11 +0000 (UTC)
Message-ID: <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 14:50:09 -0700
In-Reply-To: <20190722230102.442137dc@heffalump.sk2.org>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 23:01 +0200, Stephen Kitt wrote:
> How about you submit your current patch set, and I follow up with the above
> adapted to stracpy?

OK, I will shortly after I figure out how to add kernel-doc
for stracpy/stracpy_pad to lib/string.c.

It doesn't seem appropriate to add the kernel-doc to string.h
as it would be separated from the others in string.c

Anyone got a clue here?  Jonathan?



