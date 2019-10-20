Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B9DE021
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfJTTC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 15:02:56 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:53540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbfJTTC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:02:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id ABBD6100E7B42;
        Sun, 20 Oct 2019 19:02:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:560:960:973:988:989:1260:1277:1311:1313:1314:1345:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2553:2559:2562:2693:2828:2902:3138:3139:3140:3141:3142:3352:3865:3867:3868:3870:3872:4250:4321:5007:7901:7903:9121:10004:10400:10848:11026:11233:11658:11914:12043:12262:12297:12438:12555:12679:12740:12760:12895:12986:13069:13101:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:14819:21080:21365:21433:21451:21627:21939:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: level02_194bc56e7ad54
X-Filterd-Recvd-Size: 2682
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 19:02:53 +0000 (UTC)
Message-ID: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
Subject: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 20 Oct 2019 12:02:52 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an argument inconsistency between these 4 functions
in include/linux/byteorder/generic.h

It'd be more a consistent API with one form and not two.

   static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
   {
   	while (words--) {
   		__le32_to_cpus(buf);
   		buf++;
   	}
   }

   static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
   {
   	while (words--) {
   		__cpu_to_le32s(buf);
   		buf++;
   	}
   }

vs

   static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
   {
   	int i;

   	for (i = 0; i < len; i++)
   		dst[i] = cpu_to_be32(src[i]);
   }

   static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
   {
   	int i;

   	for (i = 0; i < len; i++)
   		dst[i] = be32_to_cpu(src[i]);
   }

Added via 2 different commits:

commit f2f2efb807d339513199b1bb771806c90cce83ae
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Mon Oct 2 13:38:28 2017 +0300

    byteorder: Move {cpu_to_be32, be32_to_cpu}_array() from Thunderbolt to core
    
    We will be using these when communicating XDomain discovery protocol
    over Thunderbolt link but they might be useful for other drivers as
    well.
    
    Make them available through byteorder/generic.h.
    
    Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

and

commit 9def051018c08e65c532822749e857eb4b2e12e7
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed Mar 21 19:01:40 2018 +0200

    crypto: Deduplicate le32_to_cpu_array() and cpu_to_le32_array()
    
    Deduplicate le32_to_cpu_array() and cpu_to_le32_array() by moving them
    to the generic header.
    
    No functional change implied.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

