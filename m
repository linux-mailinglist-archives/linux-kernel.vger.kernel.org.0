Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F75A32A44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFCICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 04:02:35 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47375 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:02:35 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost.localdomain (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 889F3FF816;
        Mon,  3 Jun 2019 08:02:31 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jeff Kletsky <lede@allycomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 1/3] mtd: spinand: Define macros for page-read ops with three-byte addresses
Date:   Mon,  3 Jun 2019 10:02:28 +0200
Message-Id: <20190603080229.27577-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190522220555.11626-2-lede@allycomm.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: d014717d50b1efd011a3a028ce92563a4dc9bae5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 22:05:53 UTC, Jeff Kletsky wrote:
> From: Jeff Kletsky <git-commits@allycomm.com>
> 
> The GigaDevice GD5F1GQ4UFxxG SPI NAND utilizes three-byte addresses
> for its page-read ops.
> 
> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
> 
> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
