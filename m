Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EB91321DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 10:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgAGJEn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jan 2020 04:04:43 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60583 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgAGJEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:04:42 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 16206FF80D;
        Tue,  7 Jan 2020 09:04:39 +0000 (UTC)
Date:   Tue, 7 Jan 2020 10:04:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: cadence: Fix cast to pointer from integer of
 different size warning
Message-ID: <20200107100439.23f86175@xps13>
In-Reply-To: <CAOesGMjp8=uOwTnGwuMwTJMKVh915udgkhSb0joKMTcwWBEy-Q@mail.gmail.com>
References: <20191216110947.6fb2423a@xps13>
        <20191218095715.25585-1-gomonovych@gmail.com>
        <CAOesGMjp8=uOwTnGwuMwTJMKVh915udgkhSb0joKMTcwWBEy-Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

Olof Johansson <olof@lixom.net> wrote on Mon, 6 Jan 2020 13:18:17 -0800:

> Miquel, this warning is still there both in mainline and linux-next.
> 
> Can you please apply it and get it sent in so we can keep the tree
> building cleaning and spot warnings without the noise? Thanks!
> 
> On Wed, Dec 18, 2019 at 1:57 AM Vasyl Gomonovych <gomonovych@gmail.com> wrote:
> >
> > Use dma_addr_t type to pass memory address and control data in
> > DMA descriptor fields memory_pointer and ctrl_data_ptr
> > To fix warning: cast to pointer from integer of different size
> >
> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>  
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 

Sorry, I am late. I'll send a fixes PR this week.

Thanks,
Miquèl
