Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988D912FE6D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgACVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 16:46:59 -0500
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:38454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728549AbgACVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 16:46:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id C64CE249C;
        Fri,  3 Jan 2020 21:46:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:3872:4250:4321:5007:7514:8603:10004:10400:10848:11026:11232:11658:11914:12048:12297:12555:12740:12760:12895:13069:13146:13230:13311:13357:13439:14096:14097:14181:14659:14721:21063:21080:21324:21433:21611:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bulb70_249ac3912826
X-Filterd-Recvd-Size: 2061
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jan 2020 21:46:55 +0000 (UTC)
Message-ID: <e76bdf736141d5a390e57f2bc8f6f6f9fbe574c1.camel@perches.com>
Subject: Re: [PATCH 3/3] lib/find_bit.c: uninline helper _find_next_bit()
From:   Joe Perches <joe@perches.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Jan 2020 13:46:07 -0800
In-Reply-To: <20200103202846.21616-3-yury.norov@gmail.com>
References: <20200103202846.21616-1-yury.norov@gmail.com>
         <20200103202846.21616-3-yury.norov@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-03 at 12:28 -0800, Yury Norov wrote:
> It saves 25% of .text for arm64, and more for BE architectures.

This seems a rather misleading code size reduction description.

Please detail the specific code sizes using "size lib/find_bit.o"
before and after this change.

Also, _find_next_bit is used 3 times, perhaps any code size
increase is appropriate given likely reduced run time.

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  lib/find_bit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index c03cbecb2b1f6..0e4b2b90c9c02 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -27,7 +27,7 @@
>   *    searching it for one bits.
>   *  - The optional "addr2", which is anded with "addr1" if present.
>   */
> -static inline unsigned long _find_next_bit(const unsigned long *addr1,
> +static unsigned long _find_next_bit(const unsigned long *addr1,
>  		const unsigned long *addr2, unsigned long nbits,
>  		unsigned long start, unsigned long invert, unsigned long le)
>  {

