Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3C13B068
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANRGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:06:23 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58159 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:06:23 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5A41EC0004;
        Tue, 14 Jan 2020 17:06:17 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: mtd: denali_dt: document reset property
Date:   Tue, 14 Jan 2020 18:06:07 +0100
Message-Id: <20200114170607.1762-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220113155.28177-4-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 66ab41b69859dd499fa251d9e8155370e7447afa
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 11:31:53 UTC, Masahiro Yamada wrote:
> According to the Denali NAND Flash Memory Controller User's Guide,
> this IP has two reset signals.
> 
>   rst_n:     reset most of FFs in the controller core
>   reg_rst_n: reset all FFs in the register interface, and in the
>              initialization sequencer
> 
> This commit specifies these reset signals.
> 
> It is possible to control them separately from the IP point of view
> although they might be often tied up together in actual SoC integration.
> 
> At least for the upstream platforms, Altera/Intel SOCFPGA and Socionext
> UniPhier, the reset controller seems to provide only 1-bit control for
> the NAND controller. If it is the case, the resets property should
> reference to the same phandles for "nand" and "reg" resets, like this:
> 
>     resets = <&nand_rst>, <&nand_rst>;
>     reset-names = "nand", "reg";
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
