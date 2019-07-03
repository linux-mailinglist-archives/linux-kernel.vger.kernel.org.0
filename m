Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4D5E011
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGCIm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:42:59 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:35944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726400AbfGCIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:42:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 204E2283D;
        Wed,  3 Jul 2019 08:42:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:4321:4605:5007:7904:10004:10226:10400:10848:11232:11658:11914:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: wing47_36df97e909a43
X-Filterd-Recvd-Size: 1658
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Jul 2019 08:42:56 +0000 (UTC)
Message-ID: <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Joe Perches <joe@perches.com>
To:     Miles Chen <miles.chen@mediatek.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Date:   Wed, 03 Jul 2019 01:42:55 -0700
In-Reply-To: <20190703083031.2950-1-miles.chen@mediatek.com>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> This change reports a warning when "default n" is used.
> 
> I have seen several "remove default n" patches, so I think
> it might be helpful to add this test in checkpatch.
> 
> tested:
> WARNING: 'default n' is the default value, no need to write it explicitly.
> +       default n

I don't think this is reasonable as there are
several uses like:

		default y
		default n if <foo>

For instance:

arch/alpha/Kconfig-config ALPHA_WTINT
arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
arch/alpha/Kconfig-     default y if ALPHA_QEMU
arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC


