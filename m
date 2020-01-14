Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6013B075
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgANRHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 12:07:08 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41167 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:07:07 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13.lan (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 21B01E000B;
        Tue, 14 Jan 2020 17:07:02 +0000 (UTC)
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
Subject: Re: [PATCH v3 1/5] mtd: rawnand: denali_dt: error out if platform has no associated data
Date:   Tue, 14 Jan 2020 18:06:52 +0100
Message-Id: <20200114170652.1913-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220113155.28177-2-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: bc3cbbe1ce92aa30a33798e0e816663cfddb805e
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 11:31:51 UTC, Masahiro Yamada wrote:
> denali->ecc_caps is a mandatory parameter. If it were left unset,
> nand_ecc_choose_conf() would end up with NULL pointer access.
> 
> So, every compatible must be associated with proper denali_dt_data.
> If of_device_get_match_data() returns NULL, let it fail immediately.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
