Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8FA12CB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 23:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfL2Wwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 17:52:46 -0500
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:51805 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbfL2Wwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 17:52:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BE386348D;
        Sun, 29 Dec 2019 22:52:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2199:2328:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:4321:5007:10004:10400:11026:11232:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21740:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: play68_8c3e37cc6c84a
X-Filterd-Recvd-Size: 1615
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Dec 2019 22:52:43 +0000 (UTC)
Message-ID: <1ec873d6df7de91c972fa356eb33d65437a3e67b.camel@perches.com>
Subject: Re: [PATCH v3] Staging: wfx: Fix style issues with hif_rx.c
From:   Joe Perches <joe@perches.com>
To:     Matthew Hanzelik <mrhanzelik@gmail.com>,
        jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Dec 2019 14:51:58 -0800
In-Reply-To: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
References: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-12-29 at 17:31 -0500, Matthew Hanzelik wrote:
> Fix the 80 line limit warning on line 79 of hif_rx.c.
> 
> Also fixes the missing blank line warning on line 305 of hif_rx.c after
> the declaration of size_t len.
[]
> diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
[]
> @@ -76,7 +76,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
>  				void *buf)
>  {
>  	struct hif_cnf_multi_transmit *body = buf;
> -	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *) &body->tx_conf_payload;
> +	struct hif_cnf_tx *buf_loc =
> +		(struct hif_cnf_tx *) &body->tx_conf_payload;

Just get rid of the cast instead

	struct hif_cnf_tx *buf_loc = body->tx_conf_payload;

should work fine.


