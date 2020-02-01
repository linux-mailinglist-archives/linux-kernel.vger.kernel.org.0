Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B332F14F7B3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBAL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Feb 2020 06:59:44 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:41332 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbgBAL7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 06:59:44 -0500
X-Greylist: delayed 1805 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Feb 2020 06:59:43 EST
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.11 beta 1) with ESMTPA;
        Sat, 1 Feb 2020 12:29:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 01 Feb 2020 12:29:15 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH v3] serial: uartps: Add TACTIVE bit in cdns_uart_tx_empty
 function
In-Reply-To: <1580468685-11373-1-git-send-email-shubhrajyoti.datta@xilinx.com>
References: <1580468685-11373-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Message-ID: <44b8cf91d3d2f20a81e0215b1b2fc7a8@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-31 12:04, Shubhrajyoti Datta wrote:
>  drivers/tty/serial/xilinx_uartps.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index ed2f325..ebd0a74 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -656,8 +655,9 @@ static unsigned int cdns_uart_tx_empty(struct
> uart_port *port)
>  {
>  	unsigned int status;
> 
> -	status = readl(port->membase + CDNS_UART_SR) &
> -				CDNS_UART_SR_TXEMPTY;
> +	status = ((readl(port->membase + CDNS_UART_SR) &
> +				(CDNS_UART_SR_TXEMPTY |
> +				CDNS_UART_SR_TACTIVE)) == CDNS_UART_SR_TXEMPTY);
>  	return status ? TIOCSER_TEMT : 0;
>  }

These lines look pretty incomprehensible.
How about rewriting it like this?

     status = readl(port->membase + CDNS_UART_SR) &
              (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
     return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;

Maarten

