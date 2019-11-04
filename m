Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2AEE77A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfKDSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 13:39:17 -0500
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:57754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbfKDSjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:39:16 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id C9F46180192CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2019 18:39:15 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E7E40100E7B49;
        Mon,  4 Nov 2019 18:39:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3872:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12760:12895:13439:14096:14097:14659:14721:21080:21324:21451:21627:30003:30054:30070:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: lunch04_6db01704b3d3d
X-Filterd-Recvd-Size: 3161
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 18:39:13 +0000 (UTC)
Message-ID: <a391e4df7c080c6a4d7eac58708967d02f0449fa.camel@perches.com>
Subject: Re: [PATCH v3 3/5] bus: hisi_lpc: Clean some types
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, xuwei5@huawei.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org, olof@lixom.net,
        bhelgaas@google.com, arnd@arndb.de
Date:   Mon, 04 Nov 2019 10:39:03 -0800
In-Reply-To: <1572888139-47298-4-git-send-email-john.garry@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
         <1572888139-47298-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 01:22 +0800, John Garry wrote:
> Sparse complains of these:
> drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
> drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
> drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
> drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
> drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
> drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
> drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
> drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
> drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
> drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
> drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
> drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
> drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>
> 
> Clean them up.

OK, it might also be good to change the _in and _out functions
to use void * and not unsigned char * for buf

---
 drivers/bus/hisi_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 20c9571..ec2bfb 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -100,7 +100,7 @@ static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)
  */
 static int hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev,
 			      struct lpc_cycle_para *para, unsigned long addr,
-			      unsigned char *buf, unsigned long opcnt)
+			      void *buf, unsigned long opcnt)
 {
 	unsigned int cmd_word;
 	unsigned int waitcnt;
@@ -153,7 +153,7 @@ static int hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev,
  */
 static int hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev,
 			       struct lpc_cycle_para *para, unsigned long addr,
-			       const unsigned char *buf, unsigned long opcnt)
+			       const void *buf, unsigned long opcnt)
 {
 	unsigned int waitcnt;
 	unsigned long flags;


