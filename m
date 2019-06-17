Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD45488B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfFQQRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 12:17:45 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:44470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbfFQQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:17:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F0530182251A2;
        Mon, 17 Jun 2019 16:17:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12043:12296:12663:12679:12740:12760:12895:13069:13071:13161:13229:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21627:21740:30029:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: dock02_2616e45532807
X-Filterd-Recvd-Size: 2206
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Jun 2019 16:17:41 +0000 (UTC)
Message-ID: <9f241554ff74531d3a61e6bd1c1043831e870819.camel@perches.com>
Subject: Re: [PATCH] [RFC] get_maintainer: Really limit regex patterns to
 words
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 09:17:39 -0700
In-Reply-To: <20190617142320.2830-1-geert+renesas@glider.be>
References: <20190617142320.2830-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 16:23 +0200, Geert Uytterhoeven wrote:
> Limit file and directory regex matching to paths that contain the
> pattern as a word, i.e. that contain word boundaries before and after
> the pattern.  This helps avoiding false positives.
> 
> Without this, e.g. "scripts/get_maintainer.pl -f
> tools/perf/pmu-events/arch/x86/westmereex" lists the STM32 maintainers,
> due to the presence of "stm" in the middle of a word in the path name.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> What to do with drivers/pwm/pwm-stmpe.c, which is no longer caught?
> Add a new pattern to MAINTAINERS?

Hi Geert

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> @@ -884,7 +884,7 @@ sub get_maintainers {
>  				}
>  			    }
>  			} elsif ($type eq 'N') {
> -			    if ($file =~ m/$value/x) {
> +			    if ($file =~ m/\b$value\b/x) {

I'm not sure this is the right approach as it also
affects regexes like
"N:	rockchip" where there
are multiple current matches that wouldn't
work anymore.

It might be better to change the regexes in MAINTAINERS
where appropriate.

There is also a regex with a directory slash so it's
probably better to use m{<foo>}

MAINTAINERS:N:  /pmac

