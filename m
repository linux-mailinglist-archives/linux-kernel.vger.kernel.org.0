Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40DE980E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 09:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJ3IYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 04:24:41 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46113 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfJ3IYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:24:41 -0400
X-Originating-IP: 81.185.173.67
Received: from localhost.localdomain (67.173.185.81.rev.sfr.net [81.185.173.67])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 04E3AE000D;
        Wed, 30 Oct 2019 08:24:37 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <linux-mtd@lists.infradead.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: brcmnand: Fix NULL pointer assignment
Date:   Wed, 30 Oct 2019 09:24:35 +0100
Message-Id: <20191030082435.11939-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191021164555.5330-1-f.fainelli@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 0e04b2ff7123378c7b41a0bf8156a466a49d730a
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-21 at 16:45:54 UTC, Florian Fainelli wrote:
> Sparse complained about the following:
> 
> drivers/mtd/nand/raw/brcmnand/brcmnand.c:921:40: warning: Using plain integer as NULL pointer
> 
> fix this issue by assigning the pointer to NULL.
> 
> Fixes: c1ac2dc34b51 ("mtd: rawnand: brcmnand: When oops in progress use pio and interrupt polling")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
