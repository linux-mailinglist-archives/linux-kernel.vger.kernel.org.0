Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFDF6D40A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbfGRShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 14:37:19 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:40318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbfGRShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:37:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E6E7A100E86C1;
        Thu, 18 Jul 2019 18:37:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2914:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:3871:3874:4321:4605:5007:6119:7903:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13439:14181:14659:14721:14819:21080:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: story87_557edf194a62
X-Filterd-Recvd-Size: 3234
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jul 2019 18:37:16 +0000 (UTC)
Message-ID: <649403d7dbf2e4e21a96bd9a20b7cb659b97fe38.camel@perches.com>
Subject: Re: [PATCH] scsi: pmcraid: Use dma_pool_zalloc rather than
 dma_pool_alloc
From:   Joe Perches <joe@perches.com>
To:     Vasyl Gomonovych <gomonovych@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Jul 2019 11:37:14 -0700
In-Reply-To: <20190718181051.22882-1-gomonovych@gmail.com>
References: <20190718181051.22882-1-gomonovych@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 20:10 +0200, Vasyl Gomonovych wrote:
> Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0
> The semantic patch that makes this change is available
> in scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci.
[]
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
[]
> @@ -4653,9 +4653,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
> -		pinstance->cmd_list[i]->ioa_cb =
> -			dma_pool_alloc(
> -				pinstance->control_pool,
> +		pinstance->cmd_list[i]->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
>  				GFP_KERNEL,
>  				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
>  
> @@ -4663,8 +4661,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>  			pmcraid_release_control_blocks(pinstance, i);
>  			return -ENOMEM;
>  		}
> -		memset(pinstance->cmd_list[i]->ioa_cb, 0,
> -			sizeof(struct pmcraid_control_block));
>  	}
>  	return 0;
>  }

While this change is somewhat overdone as only
dma_pool_alloc could be changed to dma_pool_zalloc
on the same line without rewrapping other arguments,
I'd generally write this with a temporary like:
---
 drivers/scsi/pmcraid.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 71ff3936da4f..88e7b18ad44d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4653,19 +4653,17 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 		return -ENOMEM;
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
-		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
-				pinstance->control_pool,
-				GFP_KERNEL,
-				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
+		struct pmcraid_cmd *cmd = pinstance->cmd_list[i];
 
-		if (!pinstance->cmd_list[i]->ioa_cb) {
+		cmd->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
+					      GFP_KERNEL,
+					      &cmd->ioa_cb_bus_addr);
+		if (!cmd->ioa_cb) {
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
+
 	return 0;
 }
 

