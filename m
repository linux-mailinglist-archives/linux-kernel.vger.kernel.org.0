Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9FA125B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 07:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLSGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 01:45:53 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:48936 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfLSGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:45:53 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 3CD452009B2; Thu, 19 Dec 2019 06:45:51 +0000 (UTC)
Date:   Thu, 19 Dec 2019 07:45:51 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: maps: pcmciamtd: fix possible
 sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
Message-ID: <20191219064551.stdx4aoyhwsbqbjj@isilmar-4.linta.de>
References: <20191219032023.7177-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219032023.7177-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:20:23AM +0800, Jia-Ju Bai wrote:
> The driver may sleep while holding a spinlock.
> The function call path (from bottom to top) in Linux 4.19 is:
> 
> drivers/pcmcia/pcmcia_resource.c, 312:
> 	mutex_lock in pcmcia_fixup_vpp
> drivers/mtd/maps/pcmciamtd.c, 309:
> 	pcmcia_fixup_vpp in pcmciamtd_set_vpp
> drivers/mtd/maps/pcmciamtd.c, 306:
> 	_raw_spin_lock_irqsave in pcmciamtd_set_vpp
> 
> drivers/pcmcia/pcmcia_resource.c, 312:
> 	mutex_lock in pcmcia_fixup_vpp
> drivers/mtd/maps/pcmciamtd.c, 312:
> 	pcmcia_fixup_vpp in pcmciamtd_set_vpp
> drivers/mtd/maps/pcmciamtd.c, 306:
> 	_raw_spin_lock_irqsave in pcmciamtd_set_vp
> 
> mutex_lock() may sleep at runtime.
> 
> To fix these bugs, the spinlock is replaced with a mutex.
> 
> These bugs are found by a static analysis tool STCheck written by
> myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

I presume this will go upstream (with CC to stable -- likely applies to all
longterm kernels still maintained) via MTD? Or should I route it via pcmcia?

Thanks,
	Dominik
