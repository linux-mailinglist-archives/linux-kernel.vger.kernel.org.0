Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C27DE03E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 21:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfJTTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 15:40:34 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:55989 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfJTTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:40:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 427531803521A;
        Sun, 20 Oct 2019 19:40:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:560:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3867:3868:3870:3871:3872:3874:4184:4250:4321:5007:6119:7901:7903:10004:10400:11026:11232:11658:11914:12043:12048:12297:12740:12760:12895:13069:13071:13101:13311:13357:13439:14180:14659:21060:21080:21433:21611:21627:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: match22_3ec1646977b17
X-Filterd-Recvd-Size: 2851
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 19:40:31 +0000 (UTC)
Message-ID: <0f7518736a2508371fecf91db6e28d50494360b3.camel@perches.com>
Subject: Re: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
From:   Joe Perches <joe@perches.com>
To:     Anatol Belski <weltling@outlook.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 20 Oct 2019 12:40:30 -0700
In-Reply-To: <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
         <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-20 at 19:28 +0000, Anatol Belski wrote:
> Hi,

Hello.

> On Sun, 2019-10-20 at 12:02 -0700, Joe Perches wrote:
> > There's an argument inconsistency between these 4 functions
> > in include/linux/byteorder/generic.h
> > 
> > It'd be more a consistent API with one form and not two.
> > 
> >    static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
> >    {
> >    	while (words--) {
> >    		__le32_to_cpus(buf);
> >    		buf++;
> >    	}
> >    }
> > 
> >    static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
> >    {
> >    	while (words--) {
> >    		__cpu_to_le32s(buf);
> >    		buf++;
> >    	}
> >    }
> > 
> > vs
> > 
> >    static inline void cpu_to_be32_array(__be32 *dst, const u32 *src,
> > size_t len)
> >    {
> >    	int i;
> > 
> >    	for (i = 0; i < len; i++)
> >    		dst[i] = cpu_to_be32(src[i]);
> >    }
> > 
> >    static inline void be32_to_cpu_array(u32 *dst, const __be32 *src,
> > size_t len)
> >    {
> >    	int i;
> > 
> >    	for (i = 0; i < len; i++)
> >    		dst[i] = be32_to_cpu(src[i]);
> >    }
> > 
> > 
> 
> size_t is the right choice for this, as it'll generate more correct
> binary depending on 32/64 bit. I've sent a patch in
> 'include/linux/byteorder/generic.h: fix signed/unsigned warnings'
> before, but only touched the place where i've seen warnings. My very
> bet is, that changing between size_t/unsigned, while it would be
> consistent, wouldn't change the functionality. It'd probably make sense
> to extend the aforementioned patch to move unsigned -> size_t.

True, but my point was the le versions have 2 arguments and
convert the buf input, and the be versions have 3 arguments
and convert src to dst.

cheers, Joe

