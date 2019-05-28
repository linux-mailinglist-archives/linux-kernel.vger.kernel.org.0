Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB052D1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 00:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfE1WyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 18:54:14 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:44770 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726706AbfE1WyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:54:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DAD23100E86C1;
        Tue, 28 May 2019 22:54:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3872:4321:4605:5007:6119:8603:10004:10400:10848:11026:11658:11914:12043:12048:12296:12555:12740:12760:12895:12986:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: tooth68_77d281f3dc0c
X-Filterd-Recvd-Size: 2281
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 22:54:11 +0000 (UTC)
Message-ID: <3598cd48fe0c7c8c7155baf56f965c53a88eb067.camel@perches.com>
Subject: Re: [tip:irq/core] genirq/irqdomain: Remove WARN_ON() on
 out-of-memory condition
From:   Joe Perches <joe@perches.com>
To:     mingo@kernel.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        geert+renesas@glider.be, linux-tip-commits@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 28 May 2019 15:54:09 -0700
In-Reply-To: <tip-43b98d876f89dce732f50b71607b6d2bbb8d8e6a@git.kernel.org>
References: <20190527115742.2693-1-geert+renesas@glider.be>
         <tip-43b98d876f89dce732f50b71607b6d2bbb8d8e6a@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 13:23 -0700, tip-bot for Geert Uytterhoeven wrote:
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
[]
> @@ -139,7 +139,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
>  
>  	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>  			      GFP_KERNEL, of_node_to_nid(of_node));
> -	if (WARN_ON(!domain))
> +	if (!domain)
>  		return NULL;
>  
>  	if (fwnode && is_fwnode_irqchip(fwnode)) {

This could also use the struct_size macro if desired.

Oddly, this seems to reduce object size (gcc 8.3.0)
but it's probably unrelated.

---
 kernel/irq/irqdomain.c | 2 +-.
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e7d17cc3a3d7..93a984a82154 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -137,7 +137,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	static atomic_t unknown_domains;
 
-	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
+	domain = kzalloc_node(struct_size(domain, linear_revmap, size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
 	if (!domain)
 		return NULL;


