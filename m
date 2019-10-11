Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB06D44B1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJKPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:46:45 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:45469 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726692AbfJKPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:46:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 77B18182CF669;
        Fri, 11 Oct 2019 15:46:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:69:355:379:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:4385:4605:5007:7903:8603:9389:9592:10004:10400:11026:11473:11658:11914:12043:12296:12297:12438:12555:12760:13439:13972:14181:14394:14659:14721:21080:21212:21627:21795:30051:30054:30083,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: ants79_74cb061a9a557
X-Filterd-Recvd-Size: 3855
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 15:46:42 +0000 (UTC)
Message-ID: <7831759661d9f3d47bd304b2e98e65e5d6c5d167.camel@perches.com>
Subject: [PATCH] ipmi: Convert ipmi_debug_msg to pr_debug and use %*ph
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 08:46:41 -0700
In-Reply-To: <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
         <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
         <20191011151220.GB32742@smile.fi.intel.com>
         <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using %*ph format to print small buffers as hex string reduces
overall object size and allows the removal of the two variants
of ipmi_debug_msg.

This also removes unnecessary duplicate colons from output when
enabled by #DEBUG or newly possible CONFIG_DYNAMIC_DEBUG.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2aab80e19ae0..1b1f6a7dc17d 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -44,25 +44,6 @@ static void need_waiter(struct ipmi_smi *intf);
 static int handle_one_recv_msg(struct ipmi_smi *intf,
 			       struct ipmi_smi_msg *msg);
 
-#ifdef DEBUG
-static void ipmi_debug_msg(const char *title, unsigned char *data,
-			   unsigned int len)
-{
-	int i, pos;
-	char buf[100];
-
-	pos = snprintf(buf, sizeof(buf), "%s: ", title);
-	for (i = 0; i < len; i++)
-		pos += snprintf(buf + pos, sizeof(buf) - pos,
-				" %2.2x", data[i]);
-	pr_debug("%s\n", buf);
-}
-#else
-static void ipmi_debug_msg(const char *title, unsigned char *data,
-			   unsigned int len)
-{ }
-#endif
-
 static bool initialized;
 static bool drvregistered;
 
@@ -2267,7 +2248,8 @@ static int i_ipmi_request(struct ipmi_user     *user,
 		ipmi_free_smi_msg(smi_msg);
 		ipmi_free_recv_msg(recv_msg);
 	} else {
-		ipmi_debug_msg("Send", smi_msg->data, smi_msg->data_size);
+		pr_debug("%s: %*ph\n",
+			 "Send", smi_msg->data, smi_msg->data_size);
 
 		smi_send(intf, intf->handlers, smi_msg, priority);
 	}
@@ -3730,7 +3712,8 @@ static int handle_ipmb_get_msg_cmd(struct ipmi_smi *intf,
 		msg->data[10] = ipmb_checksum(&msg->data[6], 4);
 		msg->data_size = 11;
 
-		ipmi_debug_msg("Invalid command:", msg->data, msg->data_size);
+		pr_debug("%s: %*ph\n",
+			 "Invalid command", msg->data, msg->data_size);
 
 		rcu_read_lock();
 		if (!intf->in_shutdown) {
@@ -4217,7 +4200,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 	int requeue;
 	int chan;
 
-	ipmi_debug_msg("Recv:", msg->rsp, msg->rsp_size);
+	pr_debug("%s: %*ph\n", "Recv", msg->rsp, msg->rsp_size);
 
 	if ((msg->data_size >= 2)
 	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
@@ -4576,7 +4559,7 @@ smi_from_recv_msg(struct ipmi_smi *intf, struct ipmi_recv_msg *recv_msg,
 	smi_msg->data_size = recv_msg->msg.data_len;
 	smi_msg->msgid = STORE_SEQ_IN_MSGID(seq, seqid);
 
-	ipmi_debug_msg("Resend: ", smi_msg->data, smi_msg->data_size);
+	pr_debug("%s: %*ph\n", "Resend", smi_msg->data, smi_msg->data_size);
 
 	return smi_msg;
 }


