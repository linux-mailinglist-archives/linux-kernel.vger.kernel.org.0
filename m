Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC7180675
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCJScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:32:08 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58607 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:32:07 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B9F63C0010;
        Tue, 10 Mar 2020 18:32:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        frieder.schrempf@kontron.de, linux-mtd@lists.infradead.org,
        tglx@linutronix.de, allison@lohutok.net
Subject: Re: [PATCH v5 1/2] mtd: rawnand: Add support for Macronix NAND randomizer
Date:   Tue, 10 Mar 2020 19:32:04 +0100
Message-Id: <20200310183204.18963-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1581922600-25461-2-git-send-email-masonccyang@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: db955f2f752f20ce0bf4859430999d3c119d7cc4
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-17 at 06:56:39 UTC, Mason Yang wrote:
> Macronix NANDs support randomizer operation for user data scrambled,
> which can be enabled with a SET_FEATURE.
> 
> User data written to the NAND device without randomizer is still readable
> after randomizer function enabled.
> The penalty of randomizer are subpage accesses prohibited and more time
> period is needed in program operation and entering deep power-down mode.
> i.e., tPROG 300us to 340us(randomizer enabled)
> 
> For more high-reliability concern, if subpage write not available with
> hardware ECC and then to enable randomizer is recommended by default.
> Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> to see if this high-reliability function is supported. By adding a new
> specific DT property in children nodes to enable randomizer function.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
