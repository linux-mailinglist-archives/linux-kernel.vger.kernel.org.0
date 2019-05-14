Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CC1CF34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfENSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 14:39:16 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:63549 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfENSjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:39:16 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 14:39:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D469A3F7F2;
        Tue, 14 May 2019 20:29:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-999 required=6.31
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ntDtz1TyoPSy; Tue, 14 May 2019 20:29:33 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0C1D83F393;
        Tue, 14 May 2019 20:29:31 +0200 (CEST)
Date:   Tue, 14 May 2019 20:29:31 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, JuergenUrban@gmx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Message-ID: <20190514182931.GA2559@sx9>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Robin!

> > For HCs that have local memory, replace the current DMA API usage
> > with a genalloc generic allocator to manage the mappings for these
> > devices.
> > This is in preparation for dropping the existing "coherent" dma
> > mem declaration APIs. Current implementation was relying on a short
> > circuit in the DMA API that in the end, was acting as an allocator
> > for these type of devices.
> > 
> > Only compiled tested, so any volunteers willing to test are most welcome.
> 
> I recall an out-of-tree PlayStation 2 OHCI driver being another 
> HCD_LOCAL_MEM user - if Fredrik and Juergen are still active on that, 
> hopefully they might be able to comment on whether this approach can 
> work for them too. Patchwork link just in case: 
> https://patchwork.kernel.org/project/linux-usb/list/?series=117433

True. In fact I'm preparing a patch submission for this PS2 OHCI driver,
along with about a hundred other patches (unrelated to the USB subsystem).
Hopefully in a few weeks. My patches are currently on top of v5.0. What
branch/version is recommended to try this DMA update?

Here is the v5.0.11 PS2 OHCI driver, for reference:

https://github.com/frno7/linux/blob/ps2-v5.0.11/drivers/usb/host/ohci-ps2.c

Fredrik
