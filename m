Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBEDCAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436854AbfJRQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 12:22:05 -0400
Received: from [217.140.110.172] ([217.140.110.172]:45050 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfJRQWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:22:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB30CA2;
        Fri, 18 Oct 2019 09:21:37 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E10B3F718;
        Fri, 18 Oct 2019 09:21:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
To:     Lee Jones <lee.jones@linaro.org>, broonie@kernel.org,
        linus.walleij@linaro.org, daniel.thompson@linaro.org, arnd@arndb.de
Cc:     baohua@kernel.org, stephan@gerhold.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191018122647.3849-1-lee.jones@linaro.org>
 <20191018122647.3849-3-lee.jones@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b7c59d6e-2ad8-30a1-013a-53c116f7b6ba@arm.com>
Date:   Fri, 18 Oct 2019 17:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191018122647.3849-3-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 13:26, Lee Jones wrote:
> Until now, MFD has assumed all child devices passed to it (via
> mfd_cells) are to be registered.  It does not take into account
> requests from Device Tree and the like to disable child devices
> on a per-platform basis.
> 
> Well now it does.
> 
> Reported-by: Barry Song <Baohua.Song@csr.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/mfd/mfd-core.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index eafdadd58e8b..24c139633524 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -182,6 +182,11 @@ static int mfd_add_device(struct device *parent, int id,
>   	if (parent->of_node && cell->of_compatible) {
>   		for_each_child_of_node(parent->of_node, np) {
>   			if (of_device_is_compatible(np, cell->of_compatible)) {
> +				if (!of_device_is_available(np)) {
> +					/* Ignore disabled devices error free */
> +					ret = 0;
> +					goto fail_alias;
> +				}

Is it possible for a device to have multiple children of the same type? 
If so, it seems like this might not work as desired if, say, the first 
child was disabled but subsequent ones weren't.

It might make sense to use for_each_available_child_of_node() for the 
outer loop, then check afterwards if anything was found.

Robin.

>   				pdev->dev.of_node = np;
>   				pdev->dev.fwnode = &np->fwnode;
>   				break;
> 
