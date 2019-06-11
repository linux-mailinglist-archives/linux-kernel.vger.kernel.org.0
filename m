Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843F43D022
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391650AbfFKPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:02:23 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.109]:16946 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389125AbfFKPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:02:22 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id BD261323A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:02:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aiI1hrXx7dnCeaiI1hTwcg; Tue, 11 Jun 2019 10:02:21 -0500
X-Authority-Reason: nr=8
Received: from [189.250.75.107] (port=32898 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1haiI0-004HDS-1e; Tue, 11 Jun 2019 10:02:20 -0500
Date:   Tue, 11 Jun 2019 10:02:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: mpt3sas: Mark expected switch fall-through
Message-ID: <20190611150219.GA19152@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.75.107
X-Source-L: No
X-Exim-ID: 1haiI0-004HDS-1e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.75.107]:32898
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warning:

drivers/scsi/mpt3sas/mpt3sas_base.c: In function ‘_base_update_ioc_page1_inlinewith_perf_mode’:
drivers/scsi/mpt3sas/mpt3sas_base.c:4510:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (ioc->high_iops_queues) {
      ^
drivers/scsi/mpt3sas/mpt3sas_base.c:4530:2: note: here
  case MPT_PERF_MODE_LATENCY:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e6377ec07f6c..9fefcd1e9c97 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4527,6 +4527,7 @@ _base_update_ioc_page1_inlinewith_perf_mode(struct MPT3SAS_ADAPTER *ioc)
 			ioc_info(ioc, "performance mode: balanced\n");
 			return;
 		}
+		/* Fall through */
 	case MPT_PERF_MODE_LATENCY:
 		/*
 		 * Enable interrupt coalescing on all reply queues
-- 
2.21.0

