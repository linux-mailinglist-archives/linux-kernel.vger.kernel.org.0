Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F37181196
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgCKHRG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 03:17:06 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54521 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:17:05 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 44C9B1C000D;
        Wed, 11 Mar 2020 07:17:03 +0000 (UTC)
Date:   Wed, 11 Mar 2020 08:17:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [PATCH 2/4] mtd: rawnand: cadence: fix calculating avaialble
 oob size
Message-ID: <20200310193823.76319593@xps13>
In-Reply-To: <20200310182951.17794-1-miquel.raynal@bootlin.com>
References: <1581328530-29966-2-git-send-email-piotrs@cadence.com>
        <20200310182951.17794-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 10 Mar 2020
19:29:51 +0100:

> On Mon, 2020-02-10 at 09:55:26 UTC, Piotr Sroka wrote:
> > Previously ecc_sector size was used for calculation but its value
> > was not yet known.
> > 
> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.
> 

I applied patch 2, 3 and 4 after having changed the commit message as
suggested and with the Fixes/Cc: stable tags added.

Thanks,
Miquèl
