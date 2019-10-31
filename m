Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7DEAE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJaK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:59:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfJaK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:59:00 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7949028FB50;
        Thu, 31 Oct 2019 10:58:58 +0000 (GMT)
Date:   Thu, 31 Oct 2019 11:58:56 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/32] mtd: spi-nor: Pointer parameter for CR in
 spi_nor_read_cr()
Message-ID: <20191031115856.4dacc552@collabora.com>
In-Reply-To: <20191029111615.3706-11-tudor.ambarus@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
        <20191029111615.3706-11-tudor.ambarus@microchip.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 11:17:04 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let the callers pass the pointer to the DMA-able buffer where
> the value of the Configuration Register will be written. This way we
> avoid the casts between int and u8, which can be confusing.
> 
> Callers stop compare the return value of spi_nor_read_cr() with negative,
> spi_nor_read_cr() returns 0 on success and -errno otherwise.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

There's just this &nor->bouncebuf[0] that I'd prefer to be turned into
nor->bouncebuf if you're okay.
