Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B25348A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfFDN3J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jun 2019 09:29:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47344 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfFDN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:29:09 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hY9Uu-0001KU-Qt; Tue, 04 Jun 2019 15:29:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sandy Huang <hjc@rock-chips.com>, Eric Anholt <eric@anholt.net>
Subject: Re: [RFC PATCH 20/57] platform: Add a helper to find device by driver
Date:   Tue, 04 Jun 2019 15:29:04 +0200
Message-ID: <2117016.xXqOXZeE10@phil>
In-Reply-To: <1559577023-558-21-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com> <1559577023-558-21-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 3. Juni 2019, 17:49:46 CEST schrieb Suzuki K Poulose:
> There are a couple of places where we reuse platform specific
> match to find a device. Instead of spilling the global varilable
> everywhere, let us provide a helper to do the same.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St�bner" <heiko@sntech.de>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index cc46485..a82b3ec 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -52,6 +52,9 @@ extern struct device platform_bus;
>  extern void arch_setup_pdev_archdata(struct platform_device *);
>  extern struct resource *platform_get_resource(struct platform_device *,
>  					      unsigned int, unsigned int);
> +extern struct device *
> +platform_find_device_by_driver(struct device dev*,
> +			       const struct device_driver *drv);

the "dev*" causes compilation errors and also doesn't match the
function definition. With "dev*" -> "*start" it compiles again and
my rockchip drm driver still manages to find its components, so
after the above issue is fixed:

Tested-by: Heiko Stuebner <heiko@sntech.de>


