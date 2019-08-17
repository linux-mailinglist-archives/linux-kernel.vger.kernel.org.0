Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE590DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQHWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 03:22:55 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:45243 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfHQHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:22:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BF910181D33FC;
        Sat, 17 Aug 2019 07:22:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:4321:5007:7903:10004:10400:10848:11232:11658:11914:12049:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21060:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: fish56_5354f57556556
X-Filterd-Recvd-Size: 1469
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Aug 2019 07:22:52 +0000 (UTC)
Message-ID: <74b4a00b524cf8dd11631692dee65ccbba34b8cb.camel@perches.com>
Subject: Re: [PATCH] clk: Remove extraneous 'for' word in comments
From:   Joe Perches <joe@perches.com>
To:     Rishi Gupta <gupt21@gmail.com>, sboyd@kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 17 Aug 2019 00:22:51 -0700
In-Reply-To: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
References: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-17 at 12:05 +0530, Rishi Gupta wrote:
> An extra 'for' word is grammatically incorrect in the comment
> 'verifying ops for multi-parent clks'. This commit removes
> this extra for word.

A few other repeated word typos in comments are 
common in the kernel and most could be changed.

$ git grep -P '^\s*/?\*.*\bthe the\b' | wc -l
285
$ git grep -P '^\s*/?\*.*\bto to\b' | wc -l
62
$ git grep -P '^\s*/?\*.*\bfor for\b' | wc -l
31
$ git grep -P
'^\s*/?\*.*\bfrom from\b' | wc -l
22
$ git grep -P '^\s*/?\*.*\bare are\b'
| wc -l
16


