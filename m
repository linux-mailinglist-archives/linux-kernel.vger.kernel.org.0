Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F329180654
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCJSao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:30:44 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35721 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:30:43 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id CFB7DC0006;
        Tue, 10 Mar 2020 18:30:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vigneshr@ti.com,
        miquel.raynal@bootlin.com, han.xu@nxp.com, richard@nod.at,
        mripard@kernel.org, wens@csie.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     vkoul@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] mtd: rawnand: qcom: Release resources on failure within qcom_nandc_alloc()
Date:   Tue, 10 Mar 2020 19:30:40 +0100
Message-Id: <20200310183040.18252-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227123749.24064-6-peter.ujfalusi@ti.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 92c29840b69db0bec6155a7623e0b1725ffb8936
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 12:37:47 UTC, Peter Ujfalusi wrote:
> In case when DMA channel request or alloc_bam_transaction() fails,
> dma_unmap_single() and any channels already requested should be released.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
