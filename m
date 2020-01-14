Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722F713B063
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgANRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:05:57 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:38985 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgANRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:05:56 -0500
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D137B200009;
        Tue, 14 Jan 2020 17:05:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v3 5/5] mtd: rawnand: denali: remove hard-coded DENALI_DEFAULT_OOB_SKIP_BYTES
Date:   Tue, 14 Jan 2020 18:05:34 +0100
Message-Id: <20200114170534.1622-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220113155.28177-6-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: cd038db7b0f092b225c61ee2648ab3c2efc1fbfc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 11:31:55 UTC, Masahiro Yamada wrote:
> As commit 0d55c668b218 (mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES
> register to 8 if unset") says, there were three solutions discussed:
> 
>   [1] Add a DT property to specify the skipped bytes in OOB
>   [2] Associate the preferred value with compatible
>   [3] Hard-code the default value in the driver
> 
> At that time, [3] was chosen because I did not have enough information
> about the other platforms than UniPhier.
> 
> That commit also says "The preferred value may vary by platform. If so,
> please trade up to a different solution." My intention was to replace
> [3] with [2], not keep both [2] and [3].
> 
> Now that we have switched to [2] for SOCFPGA's SPARE_AREA_SKIP_BYTES=2,
> [3] should be removed. This should be OK because denali_pci.c just
> gets back to the original behavior.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
