Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA95103D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfKTOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:43:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53349 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfKTOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:43:50 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iXRCu-0003N6-8g; Wed, 20 Nov 2019 15:43:48 +0100
Message-ID: <32ae1093cfee84676e99336a2e5842758a756bb1.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] reset: Fix {of,devm}_reset_control_array_get
 kerneldoc return types
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Nov 2019 15:43:48 +0100
In-Reply-To: <20191120142614.29180-3-geert+renesas@glider.be>
References: <20191120142614.29180-1-geert+renesas@glider.be>
         <20191120142614.29180-3-geert+renesas@glider.be>
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

On Wed, 2019-11-20 at 15:26 +0100, Geert Uytterhoeven wrote:
> of_reset_control_array_get() and devm_reset_control_array_get() return
> struct reset_control pointers, not internal struct reset_control_array
> pointers, just like all other reset control API calls.
> 
> Correct the kerneldoc to match the code.
> 
> Fixes: 17c82e206d2a3cd8 ("reset: Add APIs to manage array of resets")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/reset/core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 55245f485b3819da..4ea62aa00260f82c 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -861,8 +861,7 @@ static int of_reset_control_get_count(struct device_node *node)
>   * @acquired: only one reset control may be acquired for a given controller
>   *            and ID
>   *
> - * Returns pointer to allocated reset_control_array on success or
> - * error on failure
> + * Returns pointer to allocated reset_control on success or error on failure
>   */
>  struct reset_control *
>  of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
> @@ -915,8 +914,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
>   * that just have to be asserted or deasserted, without any
>   * requirements on the order.
>   *
> - * Returns pointer to allocated reset_control_array on success or
> - * error on failure
> + * Returns pointer to allocated reset_control on success or error on failure
>   */
>  struct reset_control *
>  devm_reset_control_array_get(struct device *dev, bool shared, bool optional)

Thank you, applied to reset/fixes.

regards
Philipp

