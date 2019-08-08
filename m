Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4F85A0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfHHFuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 01:50:51 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:44146 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730884AbfHHFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:50:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7C45F1802ED78;
        Thu,  8 Aug 2019 05:50:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3351:3622:3653:3865:3867:3870:3871:4321:5007:7875:7903:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12740:12895:13019:13069:13095:13311:13357:13894:14181:14659:14721:21080:21220:21365:21433:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: space68_414ad160ef10c
X-Filterd-Recvd-Size: 1711
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 05:50:48 +0000 (UTC)
Message-ID: <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 07 Aug 2019 22:50:47 -0700
In-Reply-To: <33485.1565228181@turing-police>
References: <33485.1565228181@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 21:36 -0400, Valdis Klētnieks wrote:
> commit 81398d99e9de80d9dbe65dfe7aadec9497f88242
> Author: Gilad Ben-Yossef <gilad@benyossef.com>
> Date:   Wed Jul 31 14:44:23 2019 +1000
> 
>     checkpatch: add *_NOTIFIER_HEAD as var definition
> 
> has a typo, resulting in a truly amazing error message:

Ouch, thanks.

> Unescaped left brace in regex is passed through in regex; marked by <-- HERE in m/(?:
[]
> Fix the typo.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3891,7 +3891,7 @@ sub process {
>  				^.DEFINE_$Ident\(\Q$name\E\)|
>  				^.DECLARE_$Ident\(\Q$name\E\)|
>  				^.LIST_HEAD\(\Q$name\E\)|
> -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|

Perhaps also better to convert all the '\Q$name\E' to '\s*\Q$name\E\s*'



