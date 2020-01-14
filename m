Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2398F13B0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANR3O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jan 2020 12:29:14 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:37061 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgANR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:29:14 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D0F5120000E;
        Tue, 14 Jan 2020 17:29:11 +0000 (UTC)
Date:   Tue, 14 Jan 2020 18:29:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: nand: brcmnand: Set appropriate DMA mask
Message-ID: <20200114182910.1d7d447f@xps13>
In-Reply-To: <20200114170710.1980-1-miquel.raynal@bootlin.com>
References: <20191218005635.31636-1-f.fainelli@gmail.com>
        <20200114170710.1980-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 14 Jan 2020
18:07:10 +0100:

> On Wed, 2019-12-18 at 00:56:35 UTC, Florian Fainelli wrote:
> > NAND controllers >= 7.0 with FLASH_DMA support physical addresses up to
> > 40-bit, set an appropriate DMA mask for that purpose.
> > 
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

As an FYI, the subject prefix should have been "mtd: rawnand: brcmnand:". I
changed it before applying.


Thanks,
Miquèl
