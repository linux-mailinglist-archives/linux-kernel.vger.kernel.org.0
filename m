Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C4A850DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbfHGQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 12:17:32 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43095 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388602AbfHGQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:17:31 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0AB8B2000F;
        Wed,  7 Aug 2019 16:17:28 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: r852: Use dev_get_drvdata
Date:   Wed,  7 Aug 2019 18:17:19 +0200
Message-Id: <20190807161719.13404-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723124727.24851-1-hslester96@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 75de0eb28d03ebe3c9448fc04372df5c39b6cacc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 12:47:27 UTC, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
