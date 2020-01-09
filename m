Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE96136170
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbgAITwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:52:25 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45282 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgAITwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:52:25 -0500
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id DBCF03A9CD6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 19:14:34 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C32EF240003;
        Thu,  9 Jan 2020 19:14:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor.Ambarus@microchip.com, john.garry@huawei.com,
        vigneshr@ti.com, richard@nod.at, miquel.raynal@bootlin.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: Fix the writing of the Status Register on micron flashes
Date:   Thu,  9 Jan 2020 20:14:23 +0100
Message-Id: <20200109191423.10589-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191203144948.15137-1-tudor.ambarus@microchip.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 82de6a6fb67e16a30ec2f586b1f6976c2d7b4b62
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-03 at 14:50:01 UTC,  wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Micron flashes do not support 16 bit writes on the Status Register.
> According to micron datasheets, when using the Write Status Register
> (01h) command, the chip select should be driven LOW and held LOW until
> the eighth bit of the last data byte has been latched in, after which
> it must be driven HIGH. If CS is not driven HIGH, the command is not
> executed, flag status register error bits are not set, and the write enable
> latch remains set to 1. This fixes the lock operations on micron flashes.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Tested-by: John Garry <john.garry@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
