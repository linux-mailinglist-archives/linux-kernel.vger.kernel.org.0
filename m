Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E719E082E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfJVQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:03:52 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:36971 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387746AbfJVQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:03:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 86C3481D6;
        Tue, 22 Oct 2019 16:03:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3871:3872:3874:4321:5007:9707:10004:10400:11232:11657:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: soda94_216e47221b22d
X-Filterd-Recvd-Size: 1297
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Oct 2019 16:03:49 +0000 (UTC)
Message-ID: <5db6c53e5c87ca2999c577333d9c6df678b36994.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add reset controller framework keywords
From:   Joe Perches <joe@perches.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Tue, 22 Oct 2019 09:03:48 -0700
In-Reply-To: <20191022123823.4854-1-p.zabel@pengutronix.de>
References: <20191022123823.4854-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-22 at 14:38 +0200, Philipp Zabel wrote:
> Add a regex that matches users of the reset controller API.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -13851,6 +13851,7 @@ F:	include/dt-bindings/reset/
>  F:	include/linux/reset.h
>  F:	include/linux/reset/
>  F:	include/linux/reset-controller.h
> +K:	\b(devm_|of_)?reset_control(ler_[a-z]+|_[a-z_]+)?\b

Please add ?: to each group so no capture is done.
It's a little faster.

K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b


