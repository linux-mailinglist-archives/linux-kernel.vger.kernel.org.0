Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBBBE180698
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCJSdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:33:54 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52835 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgCJSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:33:53 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2DDEC20004;
        Tue, 10 Mar 2020 18:33:51 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: denali: deassert write protect pin
Date:   Tue, 10 Mar 2020 19:33:51 +0100
Message-Id: <20200310183351.20087-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200127123934.11847-1-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9afbe7c0140f663586edb6e823b616bd7076c00a
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 12:39:34 UTC, Masahiro Yamada wrote:
> If the write protect signal from this IP is connected to the NAND
> device, this IP can handle the WP# pin via the WRITE_PROTECT
> register.
> 
> The Denali NAND Flash Memory Controller User's Guide describes
> this register like follows:
> 
>   When the controller is in reset, the WP# pin is always asserted
>   to the device. Once the reset is removed, the WP# is de-asserted.
>   The software will then have to come and program this bit to
>   assert/de-assert the same.
> 
>     1 - Write protect de-assert
>     0 - Write protect assert
> 
> The default value is 1, so the write protect is de-asserted after
> the reset is removed. The driver can write to the device unless
> someone has explicitly cleared register before booting the kernel.
> 
> The boot ROM of some UniPhier SoCs (LD4, Pro4, sLD8, Pro5) is the
> case; the boot ROM clears the WRITE_PROTECT register when the system
> is booting from the NAND device, so the NAND device becomes read-only.
> 
> Set it to 1 in the driver in order to allow the write access to the
> device.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
