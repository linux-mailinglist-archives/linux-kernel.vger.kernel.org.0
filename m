Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB315FEDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfGDX6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 19:58:05 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:32820 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727748AbfGDX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:58:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4F990182CED2A;
        Thu,  4 Jul 2019 23:58:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1539:1568:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3865:3866:4321:5007:6261:7974:10004:10848:11026:11658:11914:12043:12296:12297:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21627:30054:30079,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: join74_63508f115542a
X-Filterd-Recvd-Size: 1508
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 23:58:02 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] tty: hvcs: Fix odd use of strlcpy
Date:   Thu,  4 Jul 2019 16:57:47 -0700
Message-Id: <1be432798311378947ec4e6051cad1235b6eccbb.1562283944.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562283944.git.joe@perches.com>
References: <cover.1562283944.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical style of array, not the equivalent &array[0].

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/tty/hvc/hvcs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b3ca3c..b6c1c1be06f9 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -871,8 +871,8 @@ static void hvcs_set_pi(struct hvcs_partner_info *pi, struct hvcs_struct *hvcsd)
 	hvcsd->p_partition_ID  = pi->partition_ID;
 
 	/* copy the null-term char too */
-	strlcpy(&hvcsd->p_location_code[0],
-			&pi->location_code[0], sizeof(hvcsd->p_location_code));
+	strlcpy(hvcsd->p_location_code, pi->location_code,
+		sizeof(hvcsd->p_location_code));
 }
 
 /*
-- 
2.15.0

