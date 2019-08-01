Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5687D58C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfHAGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:36:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34050 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAGg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:36:57 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C699C28A446;
        Thu,  1 Aug 2019 07:36:55 +0100 (BST)
Date:   Thu, 1 Aug 2019 08:36:52 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <vigneshr@ti.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mtd: spi_nor: Add nor->setup() method
Message-ID: <20190801083652.52bffef5@collabora.com>
In-Reply-To: <20190731091145.27374-5-tudor.ambarus@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
        <20190731091145.27374-5-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 09:12:14 +0000
<Tudor.Ambarus@microchip.com> wrote:


>  static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
>  {
>  	return !!(proto & SNOR_PROTO_IS_DTR);
> @@ -384,6 +522,7 @@ struct flash_info;
>   *                      useful when pagesize is not a power-of-2
>   * @disable_write_protection: [FLASH-SPECIFIC] disable write protection during
>   *                            power-up
> + * @setup:		[FLASH-SPECIFIC] configure the spi-nor memory

Might be worth giving a example of the type of configuration that can
be done here.

The patch looks good otherwise.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

>   *			completely locked

Looks like this 'completely locked' is a leftover from a previous move
(lock functions were move to a separate _ops struct IIRC). Can you fix
that?

>   * @priv:		the private data
>   */
> @@ -427,6 +566,9 @@ struct spi_nor {
>  	int (*set_4byte)(struct spi_nor *nor, bool enable);
>  	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
>  	int (*disable_write_protection)(struct spi_nor *nor);
> +	int (*setup)(struct spi_nor *nor,
> +		     const struct spi_nor_flash_parameter *params,
> +		     const struct spi_nor_hwcaps *hwcaps);
>  
>  	const struct spi_nor_locking_ops *locking_ops;
>  
> @@ -486,81 +628,6 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
>  }
>  
