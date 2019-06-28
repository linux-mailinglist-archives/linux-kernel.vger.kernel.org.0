Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23F35A423
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfF1Sgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 14:36:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39899 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfF1Sgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:36:32 -0400
X-Originating-IP: 81.185.164.234
Received: from localhost.localdomain (234.164.185.81.rev.sfr.net [81.185.164.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E819E40002;
        Fri, 28 Jun 2019 18:36:13 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com
Cc:     Amelie Delaunay <amelie.delaunay@st.com>, bbrezillon@kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] mtd: rawnand: stm32_fmc2: increase DMA completion timeouts
Date:   Fri, 28 Jun 2019 20:36:10 +0200
Message-Id: <20190628183610.18729-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <1561713486-26597-1-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: bce9437a0a48dd5e19490f56e1cdc39a9be5563c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-28 at 09:18:06 UTC, Christophe Kerello wrote:
> From: Amelie Delaunay <amelie.delaunay@st.com>
> 
> When the system is overloaded, DMA data transfer completion occurs after
> 100ms. Increase the timeouts to let it the time to complete.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
