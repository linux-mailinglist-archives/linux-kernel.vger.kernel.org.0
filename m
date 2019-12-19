Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52213126863
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSRsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 12:48:10 -0500
Received: from mout02.posteo.de ([185.67.36.142]:46773 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:48:10 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id DFECF240101
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 18:40:47 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 47dzgL4SfTz9rxM;
        Thu, 19 Dec 2019 18:40:46 +0100 (CET)
Date:   Thu, 19 Dec 2019 18:40:45 +0100 (CET)
From:   Marc Dietrich <marvin24@gmx.de>
X-X-Sender: lucile@macbook-pro.fritz.box
To:     Xidong Wang <wangxidong_97@163.com>
cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: nvec: check return value
In-Reply-To: <1576648598-12257-1-git-send-email-wangxidong_97@163.com>
Message-ID: <alpine.OSX.2.21.1912191837580.5811@macbook-pro.fritz.box>
References: <1576648598-12257-1-git-send-email-wangxidong_97@163.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xidong,

On Wed, 18 Dec 2019, Xidong Wang wrote:

> In nvec_kbd_probe(), the return value of devm_input_allocate_device()
> should be checked before it is used.
>
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>

looks good to me. Thanks!

Acked-by: Marc Dietrich <marvin24@gmx.de>

> ---
> drivers/staging/nvec/nvec_kbd.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/nvec/nvec_kbd.c b/drivers/staging/nvec/nvec_kbd.c
> index 01dbb66..386d619 100644
> --- a/drivers/staging/nvec/nvec_kbd.c
> +++ b/drivers/staging/nvec/nvec_kbd.c
> @@ -123,6 +123,8 @@ static int nvec_kbd_probe(struct platform_device *pdev)
> 		keycodes[j++] = extcode_tab_us102[i];
>
> 	idev = devm_input_allocate_device(&pdev->dev);
> +	if (!idev)
> +		return -ENOMEM;
> 	idev->name = "nvec keyboard";
> 	idev->phys = "nvec";
> 	idev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) | BIT_MASK(EV_LED);
> -- 
> 2.7.4
>
>
