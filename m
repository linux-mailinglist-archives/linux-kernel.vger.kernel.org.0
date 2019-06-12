Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6788542CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438271AbfFLRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 13:07:29 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:36559 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbfFLRH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:07:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1C359C1DC85;
        Wed, 12 Jun 2019 17:07:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2729:2828:2896:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:4225:4321:5007:7576:7875:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12438:12555:12679:12740:12760:12895:13439:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: road25_23dc3a3c72a17
X-Filterd-Recvd-Size: 3267
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Jun 2019 17:07:26 +0000 (UTC)
Message-ID: <fc69912c14ead80f371e2136d43db4af1f4b72aa.camel@perches.com>
Subject: Re: [PATCH v2 5/6] serial: uartps: Do not add a trailing semicolon
 to macro
From:   Joe Perches <joe@perches.com>
To:     Michal Simek <michal.simek@xilinx.com>, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        monstr@monstr.eu
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 12 Jun 2019 10:07:25 -0700
In-Reply-To: <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
         <5d938d34c3c4710577df898dbf4b70c74d2e6730.1560338079.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 13:14 +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch fixes this checkpatch warning:
> WARNING: macros should not use a trailing semicolon
> +#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> +		clk_rate_change_nb);
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
[]
> @@ -199,7 +199,7 @@ struct cdns_platform_data {
>  	u32 quirks;
>  };
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
> -		clk_rate_change_nb);
> +		clk_rate_change_nb)
>  
>  /**
>   * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.

trivia:

Perhaps this is easier for humans to read with the macro
on two lines like:

#define to_cdns_uart(_nb) \
	container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or just ignore the 80 column limit

#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, clk_rate_change_nb)

or because the macro is only used in one place,
just get rid of it and use container_of directly.
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..ca5cec2b83ce 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -195,11 +195,10 @@ struct cdns_uart {
 	u32			quirks;
 	bool cts_override;
 };
+
 struct cdns_platform_data {
 	u32 quirks;
 };
-#define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
-		clk_rate_change_nb);
 
 /**
  * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
@@ -489,8 +488,9 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
 	int locked = 0;
 	struct clk_notifier_data *ndata = data;
 	unsigned long flags = 0;
-	struct cdns_uart *cdns_uart = to_cdns_uart(nb);
+	struct cdns_uart *cdns_uart;
 
+	cdns_uart = container_of(nb, struct cdns_uart, clk_rate_change_nb);
 	port = cdns_uart->port;
 	if (port->suspended)
 		return NOTIFY_OK;


