Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB7183B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCLVdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 17:33:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:27195 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCLVdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:33:07 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6D220240004;
        Thu, 12 Mar 2020 21:33:03 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v7 6/6] mtd: spinand: micron: Add new Micron SPI NAND devices with multiple dies
Date:   Thu, 12 Mar 2020 22:33:02 +0100
Message-Id: <20200312213302.7185-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311175735.2007-7-sshivamurthy@micron.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 9f9ae0c253c1e058fbc845e26c4a32a7d777f0dc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-11 at 17:57:35 UTC, shiva.linuxworks@gmail.com wrote:
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add device table for new Micron SPI NAND devices, which have multiple
> dies.
> 
> Also, enable support to select the dies.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
