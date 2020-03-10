Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6A180659
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgCJSa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 14:30:58 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43607 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:30:57 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CEFDF200008;
        Tue, 10 Mar 2020 18:30:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vigneshr@ti.com,
        miquel.raynal@bootlin.com, han.xu@nxp.com, richard@nod.at,
        mripard@kernel.org, wens@csie.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     vkoul@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] mtd: rawnand: marvell: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 10 Mar 2020 19:30:52 +0100
Message-Id: <20200310183052.18377-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227123749.24064-4-peter.ujfalusi@ti.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 5b7a13c9de313a4125d25a04e93707cb8a5ce9a1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 12:37:45 UTC, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> Use using dma_request_chan() directly to return the real error code.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
