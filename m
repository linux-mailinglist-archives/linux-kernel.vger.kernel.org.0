Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8D13B0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgANR3x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jan 2020 12:29:53 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50371 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:29:53 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B916F60005;
        Tue, 14 Jan 2020 17:29:50 +0000 (UTC)
Date:   Tue, 14 Jan 2020 18:29:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chen Wandun <chenwandun@huawei.com>, kyungmin.park@samsung.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: onenand: samsung: remove variable 'tmp' set but
 not used
Message-ID: <20200114182949.5b5165b7@xps13>
In-Reply-To: <20200114170849.2229-1-miquel.raynal@bootlin.com>
References: <1574424534-141265-1-git-send-email-chenwandun@huawei.com>
        <20200114170849.2229-1-miquel.raynal@bootlin.com>
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
18:08:49 +0100:

> On Fri, 2019-11-22 at 12:08:54 UTC, Chen Wandun wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > drivers/mtd/nand/onenand/samsung_mtd.c: In function s3c_onenand_check_lock_status:
> > drivers/mtd/nand/onenand/samsung_mtd.c:731:6: warning: variable tmp set but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Chen Wandun <chenwandun@huawei.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

As an FYI, the subject prefix should have been "mtd: onenand: samsung:". I
changed it before applying.


Thanks,
Miquèl
