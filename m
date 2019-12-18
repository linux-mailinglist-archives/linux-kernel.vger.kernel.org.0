Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54341124F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLRR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 12:28:23 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:36504 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:28:23 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B81CF200713;
        Wed, 18 Dec 2019 17:28:21 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id BC1DE20BAB; Wed, 18 Dec 2019 18:28:13 +0100 (CET)
Date:   Wed, 18 Dec 2019 18:28:13 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: pcmciamtd: fix possible
 sleep-in-atomic-context bugs in pcmciamtd_set_vpp()
Message-ID: <20191218172813.GA338501@light.dominikbrodowski.net>
References: <20191218140552.12249-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218140552.12249-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:05:52PM +0800, Jia-Ju Bai wrote:
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

Thanks for noticing this issue.

> To fix these bugs, pcmcia_fixup_vpp() is called without holding the
> spinlock.

I don't think that this is the right approach here -- we lose the protection
against races in calls to pcmcia_fixup_vpp(). Instead, we should change the
spinlock to a mutex, which seems to be sufficient here. Could you prepare
such a patch, please?

Thanks,
	Dominik
