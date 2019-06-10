Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04B3B407
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 13:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbfFJLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 07:31:14 -0400
Received: from mx.socionext.com ([202.248.49.38]:48102 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfFJLbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:31:14 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Jun 2019 20:31:12 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 9D788180039;
        Mon, 10 Jun 2019 20:31:12 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 10 Jun 2019 20:31:12 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 05F791A04FC;
        Mon, 10 Jun 2019 20:31:12 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id E62AB120138;
        Mon, 10 Jun 2019 20:31:11 +0900 (JST)
Subject: Re: [PATCH] serial: Fix an invalid comparing statement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <3757b7f8-32a2-4d79-ef03-09b3e7420c54@socionext.com>
Date:   Mon, 10 Jun 2019 20:31:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558933288-30023-1-git-send-email-sugaya.taichi@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Does anyone have comments?

On 2019/05/27 14:01, Sugaya Taichi wrote:
> Drop the if-statement which refers to 8th bit field of u8 variable.
> The bit field is no longer used.
> 
> Fixes: ba44dc043004 ("serial: Add Milbeaut serial control")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>   drivers/tty/serial/milbeaut_usio.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
> index 949ab7e..d7207ab 100644
> --- a/drivers/tty/serial/milbeaut_usio.c
> +++ b/drivers/tty/serial/milbeaut_usio.c
> @@ -56,7 +56,6 @@
>   #define MLB_USIO_SSR_FRE		BIT(4)
>   #define MLB_USIO_SSR_PE			BIT(5)
>   #define MLB_USIO_SSR_REC		BIT(7)
> -#define MLB_USIO_SSR_BRK		BIT(8)
>   #define MLB_USIO_FCR_FE1		BIT(0)
>   #define MLB_USIO_FCR_FE2		BIT(1)
>   #define MLB_USIO_FCR_FCL1		BIT(2)
> @@ -180,18 +179,14 @@ static void mlb_usio_rx_chars(struct uart_port *port)
>   		if (status & MLB_USIO_SSR_ORE)
>   			port->icount.overrun++;
>   		status &= port->read_status_mask;
> -		if (status & MLB_USIO_SSR_BRK) {
> -			flag = TTY_BREAK;
> +		if (status & MLB_USIO_SSR_PE) {
> +			flag = TTY_PARITY;
>   			ch = 0;
>   		} else
> -			if (status & MLB_USIO_SSR_PE) {
> -				flag = TTY_PARITY;
> +			if (status & MLB_USIO_SSR_FRE) {
> +				flag = TTY_FRAME;
>   				ch = 0;
> -			} else
> -				if (status & MLB_USIO_SSR_FRE) {
> -					flag = TTY_FRAME;
> -					ch = 0;
> -				}
> +			}
>   		if (flag)
>   			uart_insert_char(port, status, MLB_USIO_SSR_ORE,
>   					 ch, flag);
> 

