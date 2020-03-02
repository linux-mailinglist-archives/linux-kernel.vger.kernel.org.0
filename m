Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21040176453
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 20:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCBTvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 14:51:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:58364 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBTvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:51:55 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7832E823;
        Mon,  2 Mar 2020 19:51:54 +0000 (UTC)
Date:   Mon, 2 Mar 2020 12:51:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: kernel-parameters: Document earlycon
 options for i.MX UARTs
Message-ID: <20200302125153.3912c42a@lwn.net>
In-Reply-To: <20200229132750.2783-1-j.neuschaefer@gmx.net>
References: <20200229132750.2783-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 14:27:48 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> drivers/tty/serial/imx.c implements these earlycon options.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 47cd55e339a5..d118ee5721b7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1095,6 +1095,12 @@
>  			A valid base address must be provided, and the serial
>  			port must already be setup and configured.
> 
> +		ec_imx21,<addr>
> +		ec_imx6q,<addr>
> +			Start an early, polled-mode, output-only console on the
> +			Freescale i.MX UART at the specified address. The UART
> +			must already be setup and configured.
> +
>  		ar3700_uart,<addr>
>  			Start an early, polled-mode console on the
>  			Armada 3700 serial port at the specified

Applied, thanks.

jon
