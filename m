Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4C1934E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgCZAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 20:10:40 -0400
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:39390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727525AbgCZAKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:10:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2F914100E8420;
        Thu, 26 Mar 2020 00:10:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:4321:5007:7903:8957:10004:10400:10848:11026:11232:11657:11658:11914:12043:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hose84_3fbcf8ba85931
X-Filterd-Recvd-Size: 1625
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:10:37 +0000 (UTC)
Message-ID: <9b369028adca4105c376094db569637cf8bb1fa2.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: cleanup long line in odm.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Mar 2020 17:08:46 -0700
In-Reply-To: <20200325215940.9225-1-straube.linux@gmail.com>
References: <20200325215940.9225-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 22:59 +0100, Michael Straube wrote:
> Cleanup line over 80 characters by removing unnecessary parentheses.
[]
> diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
[]
> @@ -590,7 +590,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
>  	if (pDM_Odm->bLinked) {
>  		if (pDM_Odm->RSSI_Min > 25) {
>  			CurCCK_CCAThres = 0xcd;
> -		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
> +		} else if (pDM_Odm->RSSI_Min <= 25 && pDM_Odm->RSSI_Min > 10) {

The test above this already guarantees pDM_Odm->RSSI_Min <= 25
so the block could be written just

		} else if (pDM->RSSI_Min > 10) {

>  			CurCCK_CCAThres = 0x83;
>  		} else {
>  			if (FalseAlmCnt->Cnt_Cck_fail > 1000)

