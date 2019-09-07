Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7727BAC924
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395238AbfIGUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Sep 2019 16:04:38 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:48094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728494AbfIGUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:04:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 513CD180A68C3;
        Sat,  7 Sep 2019 20:04:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2328:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3870:3873:3874:4321:4823:5007:7522:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: stew81_626ed4401de14
X-Filterd-Recvd-Size: 1248
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat,  7 Sep 2019 20:04:36 +0000 (UTC)
Message-ID: <529940f5dd3ca0426f8e953d232a16b4eccfbfb7.camel@perches.com>
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
From:   Joe Perches <joe@perches.com>
To:     volery <sandro@volery.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Date:   Sat, 07 Sep 2019 13:04:35 -0700
In-Reply-To: <20190907090948.GA5824@volery>
References: <20190907090948.GA5824@volery>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-09-07 at 11:09 +0200, volery wrote:
> There were a lot of styling problems using space then tab or spaces
> instead of tabs in that file. Especially the entire function at line
> 2677.
> Also added a space before the : on line 2221.

You do not have an appropriate subject line.

This subject should probably be something like:

[PATCH] tty: tty_io: Use normal indentation

Please make changes only in drivers/staging until you are
really familiar with the linux kernel patch process.


