Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8980787
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfHCRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 13:52:09 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:42232 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbfHCRwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:52:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F006E837F24D;
        Sat,  3 Aug 2019 17:52:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:3872:4250:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:21740:30054:30080:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: snake40_699c1332f931f
X-Filterd-Recvd-Size: 2725
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Aug 2019 17:52:05 +0000 (UTC)
Message-ID: <774ade692f5e64ab1f4fc7b35b9eeae69e11cf71.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8192e: Make use kmemdup
From:   Joe Perches <joe@perches.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michiel Schuurmans <michielschuurmans@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 03 Aug 2019 10:52:04 -0700
In-Reply-To: <20190803174038.GA10454@hari-Inspiron-1545>
References: <20190803174038.GA10454@hari-Inspiron-1545>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-03 at 23:10 +0530, Hariprasad Kelam wrote:
> As kmemdup API does kmalloc + memcpy . We can make use of it instead of
> calling kmalloc and memcpy independetly.
[]
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
[]
> @@ -1382,10 +1382,8 @@ rtllib_association_req(struct rtllib_network *beacon,
>  	ieee->assocreq_ies = NULL;
>  	ies = &(hdr->info_element[0].id);
>  	ieee->assocreq_ies_len = (skb->data + skb->len) - ies;
> -	ieee->assocreq_ies = kmalloc(ieee->assocreq_ies_len, GFP_ATOMIC);
> -	if (ieee->assocreq_ies)
> -		memcpy(ieee->assocreq_ies, ies, ieee->assocreq_ies_len);
> -	else {
> +	ieee->assocreq_ies = kmemdup(ies, ieee->assocreq_ies_len, GFP_ATOMIC);
> +	if (!ieee->assocreq_ies) {
>  		netdev_info(ieee->dev,
>  			    "%s()Warning: can't alloc memory for assocreq_ies\n",
>  			    __func__);
> @@ -2259,12 +2257,10 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
>  			ieee->assocresp_ies = NULL;
>  			ies = &(assoc_resp->info_element[0].id);
>  			ieee->assocresp_ies_len = (skb->data + skb->len) - ies;
> -			ieee->assocresp_ies = kmalloc(ieee->assocresp_ies_len,
> +			ieee->assocresp_ies = kmemdup(ies,
> +						      ieee->assocresp_ies_len,
>  						      GFP_ATOMIC);
> -			if (ieee->assocresp_ies)
> -				memcpy(ieee->assocresp_ies, ies,
> -				       ieee->assocresp_ies_len);
> -			else {
> +			if (!ieee->assocresp_ies) {
>  				netdev_info(ieee->dev,
>  					    "%s()Warning: can't alloc memory for assocresp_ies\n",
>  					    __func__);

Could also remove the netdev_info() uses for allocation failures.
These are redundant as a dump_stack() is already done when OOM.


