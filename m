Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB94FF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFXCmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:42:40 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:39704 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfFXCmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:42:40 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 5857818019A00;
        Sun, 23 Jun 2019 21:57:06 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A69A18029123;
        Sun, 23 Jun 2019 21:57:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3866:3868:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30045:30054:30091,0,RBL:172.58.30.132:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: bean01_37b054319919
X-Filterd-Recvd-Size: 1554
Received: from XPS-9350 (unknown [172.58.30.132])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Jun 2019 21:57:03 +0000 (UTC)
Message-ID: <c88cfce8a80eb69c932fd249f2ef0224e60b127a.camel@perches.com>
Subject: Re: [PATCH] bluetooth: Cleanup formatting and coding style
From:   Joe Perches <joe@perches.com>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas =?ISO-8859-1?Q?R=F6thenbacher?= 
        <thomas.roethenbacher@fau.de>, linux-kernel@i4.cs.fau.de
Date:   Sun, 23 Jun 2019 14:56:33 -0700
In-Reply-To: <20190623211548.1966-1-fabian.schindlatz@fau.de>
References: <20190623211548.1966-1-fabian.schindlatz@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-23 at 23:15 +0200, Fabian Schindlatz wrote:
> Fix some warnings and one error reported by checkpatch.pl:
[]
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
[]
> @@ -351,7 +356,8 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>  		skb_queue_tail(&ll->tx_wait_q, skb);
>  		break;
>  	default:
> -		BT_ERR("illegal hcill state: %ld (losing packet)", ll->hcill_state);
> +		BT_ERR("illegal hcill state: %ld (losing packet)",

trivia:

Might use invalid instead of illegal as no crime was committed.


