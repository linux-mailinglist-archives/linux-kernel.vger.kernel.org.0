Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35177D37D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 05:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJKDXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 23:23:51 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:60053 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbfJKDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:23:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6C2C6181D33FC;
        Fri, 11 Oct 2019 03:23:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:10004:10400:10450:10455:10848:11026:11232:11473:11658:11914:12296:12297:12663:12740:12760:12895:13069:13071:13095:13160:13181:13229:13311:13357:13439:14096:14097:14180:14659:14721:19904:19999:21060:21067:21080:21433:21451:21627:30012:30029:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:65,LUA_SUMMARY:none
X-HE-Tag: fire16_2146810e4a71c
X-Filterd-Recvd-Size: 1756
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 03:23:48 +0000 (UTC)
Message-ID: <8720b5d432ca5ba5e128c241efee22674e012af8.camel@perches.com>
Subject: Re: checkpatch: comparisons with a constant on the left
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 20:23:47 -0700
In-Reply-To: <20191011015225.GA27495@jagdpanzerIV>
References: <20191011015225.GA27495@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 10:52 +0900, Sergey Senozhatsky wrote:
> Hi Joe,

Hi Sergey.

> I noticed that this code
> 
> 	#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 18, 0)
> 
> triggers checkpatch's warning:
> 
> 	"WARNING: Comparisons should place the constant on
> 		  the right side of the test"
> 
> Both LINUX_VERSION_CODE and KERNEL_VERSION are constants, so
> I'm wondering if it's worth it to improve that check a tiny
> bit.

Probably not.

My preference is for people to ignore checkpatch
message bleats when they don't make overall sense.

checkpatch thinks anything that uses a form like
"name(<args...>)" is a function.

> I'm sure you'll have a better idea.

I suggest reversing the test if it really bothers you.

# if KERNEL_VERSION(4.18.0) < LINUX_VERSION_CODE

but then again just using LINUX_VERSION_CODE emits a
warning message, so it's better to remove whatever is
in the block anyway... <smile>

cheers, Joe

