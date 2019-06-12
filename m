Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4564242CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfFLQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 12:56:45 -0400
Received: from smtprelay0196.hostedemail.com ([216.40.44.196]:34948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726529AbfFLQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:56:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 186D02C33;
        Wed, 12 Jun 2019 16:56:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2904:2914:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:4605:5007:6119:7576:7875:8603:9592:10004:10848:11026:11232:11473:11658:11914:12043:12048:12296:12438:12555:12683:12740:12760:12895:12986:13439:13972:14181:14659:14721:21080:21433:21451:21627:30045:30054:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: elbow51_57385ec3ca363
X-Filterd-Recvd-Size: 5165
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Jun 2019 16:56:39 +0000 (UTC)
Message-ID: <183d192c4f3d0a8032bda73953ac8d1719590570.camel@perches.com>
Subject: Re: [PATCH v2 3/6] serial: uartps: Fix multiple line dereference
From:   Joe Perches <joe@perches.com>
To:     Michal Simek <michal.simek@xilinx.com>, johan@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        monstr@monstr.eu
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 12 Jun 2019 09:56:32 -0700
In-Reply-To: <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
         <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
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
> Trivial patch which fixes this checkpatch warning:
> WARNING: Avoid multiple line dereference - prefer 'port->state->xmit.tail'
> +				port->state->xmit.buf[port->state->xmit.
> +				tail], port->membase + CDNS_UART_FIFO);
> 
> Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Split patch from v1
> - Add Fixes tag
> 
>  drivers/tty/serial/xilinx_uartps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index c84db82bdaab..4cd20c036750 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -319,8 +319,8 @@ static void cdns_uart_handle_tx(void *dev_id)
>  			 * register.
>  			 */
>  			writel(
> -				port->state->xmit.buf[port->state->xmit.
> -				tail], port->membase + CDNS_UART_FIFO);
> +				port->state->xmit.buf[port->state->xmit.tail],
> +					port->membase + CDNS_UART_FIFO);
>  
>  			port->icount.tx++;

Another way to rewrite this is to use a temporary for
port->state->xmit and also return early on empty to
avoid unnecessary indentation.

Using a temporary can also reduce object size a bit by
removing unnecessary dereferences: (defconfig x86-64)

$ size drivers/tty/serial/xilinx_uartps.o*
   text	   data	    bss	    dec	    hex	filename
  26578	   4632	    320	  31530	   7b2a	drivers/tty/serial/xilinx_uartps.o.new
  26642	   4632	    320	  31594	   7b6a	drivers/tty/serial/xilinx_uartps.o.old

i.e.:

---
 drivers/tty/serial/xilinx_uartps.c | 54 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..09b586aeeca3 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -305,40 +305,36 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 static void cdns_uart_handle_tx(void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int numbytes;
 
-	if (uart_circ_empty(&port->state->xmit)) {
+	if (uart_circ_empty(xmit)) {
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
-	} else {
-		numbytes = port->fifosize;
-		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
-			/*
-			 * Get the data from the UART circular buffer
-			 * and write it to the cdns_uart's TX_FIFO
-			 * register.
-			 */
-			writel(
-				port->state->xmit.buf[port->state->xmit.
-				tail], port->membase + CDNS_UART_FIFO);
-
-			port->icount.tx++;
-
-			/*
-			 * Adjust the tail of the UART buffer and wrap
-			 * the buffer if it reaches limit.
-			 */
-			port->state->xmit.tail =
-				(port->state->xmit.tail + 1) &
-					(UART_XMIT_SIZE - 1);
-
-			numbytes--;
-		}
+		return;
+	}
+
+	numbytes = port->fifosize;
+	while (numbytes && !uart_circ_empty(xmit) &&
+	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		/*
+		 * Get the data from the UART circular buffer and write it
+		 * to the cdns_uart's TX_FIFO register.
+		 */
+		writel(xmit->buf[xmit->tail], port->membase + CDNS_UART_FIFO);
+
+		port->icount.tx++;
+
+		/*
+		 * Adjust the tail of the UART buffer and wrap the buffer
+		 * if it reaches limit.
+		 */
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 
-		if (uart_circ_chars_pending(
-				&port->state->xmit) < WAKEUP_CHARS)
-			uart_write_wakeup(port);
+		numbytes--;
 	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
 }
 
 /**
 

