Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE541413A0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 22:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgAQVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 16:47:53 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34135 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:47:53 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 73B1FE0002;
        Fri, 17 Jan 2020 21:47:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Fix selection of 4-byte addressing opcodes on Spansion
Date:   Fri, 17 Jan 2020 22:47:49 +0100
Message-Id: <20200117214749.21672-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108051343.1939-1-vigneshr@ti.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 440b6d50254bdbd84c2a665c7f53ec69dd741a4f
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-01-08 at 05:13:43 UTC, Vignesh Raghavendra wrote:
> mtd->size is still unassigned when running spansion_post_sfdp_fixups()
> hook, therefore use nor->params.size to determine the size of flash device.
> 
> This makes sure that 4-byte addressing opcodes are used on Spansion
> flashes that are larger than 16MiB and don't have SFDP 4BAIT table
> populated.
> 
> Fixes: 92094ebc385e ("mtd: spi-nor: Add spansion_post_sfdp_fixups()")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
