Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAE7C19B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfGaMid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 08:38:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfGaMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:28 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7BFEF2853E3;
        Wed, 31 Jul 2019 13:38:26 +0100 (BST)
Date:   Wed, 31 Jul 2019 14:38:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH 5/6] mtd: spi-nor: Add s3an_post_sfdp_fixups()
Message-ID: <20190731143822.79fa7c82@collabora.com>
In-Reply-To: <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
        <20190731091145.27374-6-tudor.ambarus@microchip.com>
        <MN2PR02MB5727FF8617B1A2FC89739601AFDF0@MN2PR02MB5727.namprd02.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 12:31:19 +0000
Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:

> Hi Tudor,
> 
> Thanks for the updates. With these kind of updates, we can add Vendor specific
> Code easily, like Xilinx Dual parallel and stacked modes.
> In these configurations we need to tweak the nor parameters like page_size, sectors etc.
> So with the help of these patches. we can easily update these parameters.

Absolutely not. This is just a solution to recover from broken SFDP
tables.
