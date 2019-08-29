Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F5A1A30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfH2Mgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:36:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39619 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2Mgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:36:45 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost.localdomain (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6BA9C240002;
        Thu, 29 Aug 2019 12:36:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: hyperbus: fix dependency and build error
Date:   Thu, 29 Aug 2019 14:36:35 +0200
Message-Id: <20190829123635.27645-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <9b1b4ab1-681f-0ef9-7b5c-b6545f7464d2@infradead.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: dc9cfd2692225a2164f4f20b7deaf38ca8645de3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 23:03:13 UTC, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> lib/devres.c, which implements devm_ioremap_resource(), is only built
> when CONFIG_HAS_IOMEM is set/enabled, so MTD_HYPERBUS should depend
> on HAS_IOMEM.  Fixes a build error and a Kconfig warning (as seen on
> UML builds):
> 
> WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS
>   Depends on [n]: MTD [=m] && HAS_IOMEM [=n]
>   Selected by [m]:
>   - MTD_HYPERBUS [=m] && MTD [=m]
> 
> ERROR: "devm_ioremap_resource" [drivers/mtd/hyperbus/hyperbus-core.ko] undefined!
> 
> Fixes: dcc7d3446a0f ("mtd: Add support for HyperBus memory devices")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-mtd@lists.infradead.org
> Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
