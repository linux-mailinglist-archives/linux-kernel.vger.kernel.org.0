Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FF18AA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCSCGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 22:06:38 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:34626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgCSCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:06:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D02E2182CED28;
        Thu, 19 Mar 2020 02:06:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:3873:4321:4605:5007:7576:7875:9149:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12555:12740:12760:12895:12986:13069:13161:13229:13255:13311:13357:13439:14181:14659:14721:21080:21451:21627:21660:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: month39_56a2ada6b4e5c
X-Filterd-Recvd-Size: 2114
Received: from XPS-9350 (unknown [172.58.27.183])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 02:06:35 +0000 (UTC)
Message-ID: <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
Subject: Re: [PATCH -next] mm/hugetlb.c: fix printk format warning for
 32-bit phys_addr_t
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Mar 2020 19:04:43 -0700
In-Reply-To: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
References: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 14:33 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warnings when phys_addr_t is 32 bits, i.e.,
> CONFIG_PHYS_ADDR_T_64BIT is not set/enabled.
[]
> ../mm/hugetlb.c:5472:73: note: format string is defined here
>     pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>                                                                       ~~~^
[]
> --- linux-next-20200318.orig/mm/hugetlb.c
> +++ linux-next-20200318/mm/hugetlb.c
> @@ -5469,8 +5469,10 @@ void __init hugetlb_cma_reserve(int orde
>  					     0, false,
>  					     "hugetlb", &hugetlb_cma[nid]);
>  		if (res) {
> -			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
> -				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
> +			phys_addr_t begpa = PFN_PHYS(min_pfn);
> +			phys_addr_t endpa = PFN_PHYS(max_pfn);
> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%pap, %pap)",
> +				res, nid, &begpa, &endpa);

You might correct the odd use of an open bracket
then close parenthesis and add a new line too

Perhaps:
			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap]\n",
				__func__, res, nid, &begpa, &endpa);


