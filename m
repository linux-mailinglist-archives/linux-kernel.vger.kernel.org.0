Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640955A429
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfF1Sg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 14:36:56 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36441 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfF1Sg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:36:56 -0400
X-Originating-IP: 81.185.164.234
Received: from localhost.localdomain (234.164.185.81.rev.sfr.net [81.185.164.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A6CFE1BF20B;
        Fri, 28 Jun 2019 18:36:41 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 14/27] mtd: nand: use kzalloc instead of kmalloc and memset
Date:   Fri, 28 Jun 2019 20:36:33 +0200
Message-Id: <20190628183633.18797-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190628024814.15527-1-huangfq.daxian@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 17c929e1334ee0647ce9f3aba1d6bc645c1e5206
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 02:48:13 UTC, Fuqian Huang wrote:
> Replace kmalloc followed by a memset with kzalloc.
> 
> There is a recommendation to use zeroing allocator
> rather than allocator followed by memset with 0 in
> ./scripts/coccinelle/api/alloc/zalloc-simple.cocci
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
