Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA52135C97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgAIPXK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 10:23:10 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59207 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgAIPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:23:09 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 2F1B1240004;
        Thu,  9 Jan 2020 15:23:04 +0000 (UTC)
Date:   Thu, 9 Jan 2020 16:23:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM
 dependency
Message-ID: <20200109162303.35f4f0a3@xps13>
In-Reply-To: <20191211192742.95699-3-brendanhiggins@google.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
        <20191211192742.95699-3-brendanhiggins@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

Brendan Higgins <brendanhiggins@google.com> wrote on Wed, 11 Dec 2019
11:27:37 -0800:

> Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
> drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
> ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Sorry for the delay.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
