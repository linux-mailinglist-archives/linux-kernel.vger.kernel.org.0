Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7685213B080
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgANRHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:07:49 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42183 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:07:49 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7EDB420013;
        Tue, 14 Jan 2020 17:07:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock
Date:   Tue, 14 Jan 2020 18:07:27 +0100
Message-Id: <20200114170727.2044-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209214422.53661-1-natechancellor@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9ec8046363ac95bd10c1f96865f139c0e76902fd
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 21:44:23 UTC, Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/mtd/nand/onenand/onenand_base.c:1269:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         while (!ret) {
>         ^
> ../drivers/mtd/nand/onenand/onenand_base.c:1266:2: note: previous
> statement is here
>         if (column + thislen > writesize)
>         ^
> 1 warning generated.
> 
> This warning occurs because there is a space before the tab of the while
> loop. There are spaces at the beginning of a lot of the lines in this
> block, remove them so that the indentation is consistent with the Linux
> kernel coding style and clang no longer warns.
> 
> Fixes: a8de85d55700 ("[MTD] OneNAND: Implement read-while-load")
> Link: https://github.com/ClangBuiltLinux/linux/issues/794
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
