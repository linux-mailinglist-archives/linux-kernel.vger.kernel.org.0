Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978A5F1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfD3H6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Apr 2019 03:58:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33271 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3H6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:58:03 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7BA3460004;
        Tue, 30 Apr 2019 07:58:00 +0000 (UTC)
Date:   Tue, 30 Apr 2019 09:57:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 4/4] mtd: spinand: micron: Support for new Micron SPI
 NAND flashes
Message-ID: <20190430095759.07a3ca6d@xps13>
In-Reply-To: <MN2PR08MB5951DEE6417F39426483CF45B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951DEE6417F39426483CF45B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Tue, 26 Mar 2019 10:52:04 +0000:

> Driver is redesigned using parameter page to support Micron SPI NAND
> flashes.
> 
> Support for selecting die is enabled for multi-die flashes.
> Turn OOB layout generic.
> 
> Fixup some of the parameter page data as per Micron datasheet.
> 

Same remark: I think this patch would better be split.

> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Thanks,
Miquèl
