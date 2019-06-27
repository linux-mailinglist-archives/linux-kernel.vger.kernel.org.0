Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098658630
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 17:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF0Pnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 11:43:47 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:54977 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfF0Pnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:43:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4EEEB182CF670;
        Thu, 27 Jun 2019 15:43:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:968:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3698:3865:3866:3867:3868:3871:3872:4250:4321:4605:5007:9010:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:14777:21080:21433:21627:21819:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: whip50_2088efb52ed39
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Jun 2019 15:43:43 +0000 (UTC)
Message-ID: <d28bb3dce55ade3024109d8e808b58cdd4441181.camel@perches.com>
Subject: Re: [PATCH] scripts: helper for mailing patches from git to the
 maintainers
From:   Joe Perches <joe@perches.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 08:43:42 -0700
In-Reply-To: <1561647544-12685-1-git-send-email-info@metux.net>
References: <1561647544-12685-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 16:59 +0200, Enrico Weigelt, metux IT consult
wrote:
> This is a little helper script for mailing patches out of a git
> branch to the corresponding maintainers.
> 
> Essentially, it scans the touched files, asks get_maintainer.pl
> for their maintainers and calls git-send-email for mailing out
> the patches.
[]
> +get_maintainers() {
> +    $KERNELSRC/scripts/get_maintainer.pl --m --l --remove-duplicates `get_files` |

--noroles --norolestats

It's also useful to separate the --to and --cc lines
where the --to goes only to direct maintainers and
--cc goes to others.

> +        grep -v "$LKML" | \
> +        grep -E "(maintainer|reviewer|open list)" | \
> +        grep -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*'


