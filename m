Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF316806F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgBUOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 09:38:24 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:56521 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727096AbgBUOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:38:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 70FCC182CED2A;
        Fri, 21 Feb 2020 14:38:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3872:4321:4384:4605:4823:5007:10004:10400:10848:11026:11473:11658:11914:12296:12297:12555:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21611:21627:30009:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: shoes55_83332b2bd2b05
X-Filterd-Recvd-Size: 2507
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 14:38:21 +0000 (UTC)
Message-ID: <6e0f3988435bf55df19af2873314f283f25f72c6.camel@perches.com>
Subject: Re: [PATCH] mmc: core: Fix indentation
From:   Joe Perches <joe@perches.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 06:36:56 -0800
In-Reply-To: <20200221104341.583028-1-Jerome.Pouiller@silabs.com>
References: <20200221104341.583028-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-21 at 11:43 +0100, Jerome Pouiller wrote:
> sdio_single_irq_set() was indented with a mix of tabs and spaces.
[]
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
[]
> @@ -278,12 +278,12 @@ static void sdio_single_irq_set(struct mmc_card *card)
>  	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
>  	    card->host->sdio_irqs == 1)
>  		for (i = 0; i < card->sdio_funcs; i++) {
> -		       func = card->sdio_func[i];
> -		       if (func && func->irq_handler) {
> -			       card->sdio_single_irq = func;
> -			       break;
> -		       }
> -	       }
> +			func = card->sdio_func[i];
> +			if (func && func->irq_handler) {
> +				card->sdio_single_irq = func;
> +				break;
> +			}
> +		}
>  }

Perhaps it'd be better to add braces around the for loop too.
---
 drivers/mmc/core/sdio_irq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 7ca7b9..3086ed 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -260,14 +260,15 @@ static void sdio_single_irq_set(struct mmc_card *card)
 
 	card->sdio_single_irq = NULL;
 	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
-	    card->host->sdio_irqs == 1)
+	    card->host->sdio_irqs == 1) {
 		for (i = 0; i < card->sdio_funcs; i++) {
-		       func = card->sdio_func[i];
-		       if (func && func->irq_handler) {
-			       card->sdio_single_irq = func;
-			       break;
-		       }
-	       }
+			func = card->sdio_func[i];
+			if (func && func->irq_handler) {
+				card->sdio_single_irq = func;
+				break;
+			}
+		}
+	}
 }
 
 /**


