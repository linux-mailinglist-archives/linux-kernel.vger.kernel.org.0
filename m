Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD076191C75
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgCXWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:05:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42583 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCXWFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:05:38 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C461E20004;
        Tue, 24 Mar 2020 22:05:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, zhangweimin12@huawei.com,
        wangle6@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd:Fix issue where write_cached_data() fails but write() still returns success
Date:   Tue, 24 Mar 2020 23:05:33 +0100
Message-Id: <20200324220533.15273-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1584674111-101462-1-git-send-email-nixiaoming@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4e4a9a828af29785fad12ecc11583769e1282024
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-20 at 03:15:11 UTC, Xiaoming Ni wrote:
> mtdblock_flush()
> 	-->write_cached_data()
> 		--->erase_write()
> 		     mtdblock: erase of region [0x40000, 0x20000] on "xxx" failed
> 
> Because mtdblock_flush() always returns 0,
> even if write_cached_data() fails and data is not written to the device,
> syscall_write() still returns success
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
