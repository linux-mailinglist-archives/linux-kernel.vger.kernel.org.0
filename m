Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5CEE4AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 17:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfKDQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 11:30:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43191 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfKDQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:30:45 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iRfFc-0005AX-Co; Mon, 04 Nov 2019 17:30:44 +0100
Message-ID: <3a970f3f3518485f58e86f2523e5085f47ec4b15.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Free struct reset_control_array in
 reset_control_array_put()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org
Cc:     tomi.valkeinen@ti.com, colin.king@canonical.com, treding@nvidia.com
Date:   Mon, 04 Nov 2019 17:30:44 +0100
In-Reply-To: <9c8c5c337a9351a561a4bf18f2faa1e9a01b50e6.1572884515.git.jsarha@ti.com>
References: <9c8c5c337a9351a561a4bf18f2faa1e9a01b50e6.1572884515.git.jsarha@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyri,

On Mon, 2019-11-04 at 18:24 +0200, Jyri Sarha wrote:
> Fix memory leak in devm_reset_control_array_get(). Free also the
> struct reset_control_array pointer in reset_control_array_put() not
> only the reset-controls stored in it.
> 
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/reset/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 213ff40dda11..85d9676ee969 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -748,6 +748,8 @@ static void reset_control_array_put(struct reset_control_array *resets)
>  	for (i = 0; i < resets->num_rstcs; i++)
>  		__reset_control_put_internal(resets->rstc[i]);
>  	mutex_unlock(&reset_list_mutex);
> +
> +	kfree(resets);
>  }
>  
>  /**

Thank you, this just got fixed in 532f9cd6ee99 ("reset: Fix memory leak
in reset_control_array_put()").

regards
Philipp

