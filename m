Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748B0330AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 15:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfFCNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 09:10:01 -0400
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:46617 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbfFCNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:10:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0B43F18029129;
        Mon,  3 Jun 2019 13:10:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2911:2915:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:4425:5007:8957:10004:10400:10848:11232:11473:11657:11658:11914:12043:12296:12438:12555:12740:12895:13069:13161:13229:13311:13357:13439:13894:14659:21080:21451:21627:30012:30054:30069:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: step10_3a06bdb8b0e14
X-Filterd-Recvd-Size: 2536
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Jun 2019 13:09:58 +0000 (UTC)
Message-ID: <8285c867674b7fffd7286b9608fbb08affbb8d7f.camel@perches.com>
Subject: Re: [PATCH 3/3] drivers/staging/rtl8192u: Fix of checkpatch-errors
From:   Joe Perches <joe@perches.com>
To:     Christian =?ISO-8859-1?Q?M=FCller?= <muellerch-privat@web.de>,
        gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de
Date:   Mon, 03 Jun 2019 06:09:57 -0700
In-Reply-To: <20190603122104.2564-4-muellerch-privat@web.de>
References: <20190603122104.2564-1-muellerch-privat@web.de>
         <20190603122104.2564-4-muellerch-privat@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 14:21 +0200, Christian M�ller wrote:
> Fix issues that lead to multiple checkpatch warnings and errors, most of
> them regarding formatting of code and comments.
> Comments that contain only commented out code are removed as well.

Generally, the quantity of changes in this patch makes it
impossible to review and apply.

It's better to do single issue fixes in separate patches.

All single line whitespace only changes can generally be done
in one patch as long as you verify that the object files have
pre and post the patch have not changed.

And the first block of this patch doesn't look like it could
ever compile properly.

> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
[]
> @@ -446,26 +446,26 @@ typedef enum _InitialGainOpType {
[]
>  #else
> -#define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
> -#define IEEE80211_DEBUG_DATA (level, data, datalen) do {} while(0)
> +#define IEEE80211_DEBUG ((level, fmt, args...) do {} while (0))
> +#define IEEE80211_DEBUG_DATA ((level, data, datalen) do {} while (0))

These need to have the space removed after the
macro identifier before the open parentheses and
another level of parentheses removed instead.

#define IEEE80211_DEBUG(level, fmt, args...) do {} while (0)
#define IEEE80211_DEBUG_DATA(level, data, datalen) do {} while (0)

Given that it's never been compiled, it might as well be removed
in another patch.

I didn't look at the rest.

