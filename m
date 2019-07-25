Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF774FED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbfGYNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 09:45:01 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:36040 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728710AbfGYNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:45:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3C0F7180AA0D2;
        Thu, 25 Jul 2019 13:44:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3868:3870:4321:5007:6119:7875:7901:7903:10004:10400:10848:11232:11657:11658:11914:12043:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30054:30055:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: scene00_2b47279991662
X-Filterd-Recvd-Size: 1719
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 13:44:57 +0000 (UTC)
Message-ID: <8179fff75f82ac49aaa0c5feb17b53be55f9f2c5.camel@perches.com>
Subject: Re: Applied "ASoC: Intel: Fix some acpi vs apci typo in somme
 comments" to the asoc tree
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.com, yang.jie@linux.intel.com
Date:   Thu, 25 Jul 2019 06:44:55 -0700
In-Reply-To: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
References: <20190725131925.D36082742B5F@ypsilon.sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 14:19 +0100, Mark Brown wrote:
> The patch
> 
>    ASoC: Intel: Fix some acpi vs apci typo in somme comments
[]
> diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
[]
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * soc-apci-intel-bxt-match.c - tables and support for BXT ACPI enumeration.
> + * soc-acpi-intel-bxt-match.c - tables and support for BXT ACPI enumeration.

Generally, using the current filename in a comment has little value.

This might as well be

 * tables and support for BXT ACPI enumeration

etc...


