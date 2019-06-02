Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D46324BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFBUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 16:07:34 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:35810 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbfFBUHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 16:07:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3F17E688F;
        Sun,  2 Jun 2019 20:07:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3870:3871:3872:3873:4321:5007:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21063:21080:21451:21611:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: frog64_79a000550354
X-Filterd-Recvd-Size: 1430
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 20:07:32 +0000 (UTC)
Message-ID: <9ca0c459d047c72fc459313ad570ecc59cf5d300.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8188eu: remove redundant definition of
 ETH_ALEN
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Jun 2019 13:07:30 -0700
In-Reply-To: <20190602163528.28495-1-straube.linux@gmail.com>
References: <20190602163528.28495-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 18:35 +0200, Michael Straube wrote:
> ETH_ALEN is defined in linux/if_ether.h which is included by
> osdep_service.h, so remove the redundant definition from ieee80211.h.
[]
> diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
[]
> @@ -14,7 +14,6 @@
>  
>  #define MGMT_QUEUE_NUM 5
>  
> -#define ETH_ALEN	6
>  #define ETH_TYPE_LEN		2
>  #define PAYLOAD_TYPE_LEN	1

While you're at it:

neither ETH_TYPE_LEN nor PAYLOAD_TYPE_LEN appear to be used.


