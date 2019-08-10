Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3388852
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 07:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfHJFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 01:08:50 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:59365 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725497AbfHJFIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:08:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5DCC5181D3368;
        Sat, 10 Aug 2019 05:08:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:4321:4419:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12297:12533:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: books31_69d3a2fe60e2f
X-Filterd-Recvd-Size: 1999
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 05:08:47 +0000 (UTC)
Message-ID: <996bc110024500842a627ea75cb43b7cd00ef36c.camel@perches.com>
Subject: Re: [PATCH] sh: kernel: disassemble: Mark expected switch
 fall-throughs
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 09 Aug 2019 22:08:45 -0700
In-Reply-To: <20190810050153.GA13927@embeddedor>
References: <20190810050153.GA13927@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 00:01 -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warnings (Building: defconfig sh):
[]
> diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
[]
> @@ -477,6 +477,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  			case FD_REG_N:
>  				if (0)
>  					goto d_reg_n;

Might as well remove this if (0) goto,
remove the added comment

> +				/* else, fall through */
>  			case F_REG_N:
>  				printk("fr%d", rn);
>  				break;
> @@ -488,6 +489,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rn & ~1);
>  					break;
>  				}
> +				/* else, fall through */
>  			d_reg_n:

and remove this only use of d_reg_n

>  			case D_REG_N:
>  				printk("dr%d", rn);
> @@ -497,6 +499,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>  					printk("xd%d", rm & ~1);
>  					break;
>  				}
> +				/* else, fall through */
>  			case D_REG_M:
>  				printk("dr%d", rm);
>  				break;

