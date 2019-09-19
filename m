Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617CBB7747
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbfISKX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 06:23:29 -0400
Received: from mx1.emlix.com ([188.40.240.192]:57538 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388940AbfISKX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:23:29 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 3D78B6038C;
        Thu, 19 Sep 2019 12:23:27 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     yibin.gong@nxp.com, fugang.duan@nxp.com, l.stach@pengutronix.de,
        dan.j.williams@intel.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, dmaengine@vger.kernel.or,
        linux-arm-kernel@lists.infradead.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH v2 0/3] Fix UART DMA freezes for i.MX SOCs
Date:   Thu, 19 Sep 2019 12:23:16 +0200
Message-Id: <20190919102319.23368-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some years and since many kernel versions there are reports that
RX UART DMA channel stops working at one point. So far the usual
workaround was to disable RX DMA. This patches fix the underlying
problem.

When a running sdma script does not find any usable destination buffer
to put its data into it just leads to stopping the channel being
scheduled again. As solution we manually retrigger the sdma script for
this channel and by this dissolve the freeze.

While this seems to work fine so far, it may come to buffer overruns
when the channel - even temporary - is stopped. This case has to be
addressed by device drivers by increasing the number of DMA periods.

This patch series was tested with the current kernel and backported to
kernel 4.15 with a special use case using a WL1837MOD via UART and
provoking the hanging of UART RX DMA within seconds after starting a
test application. It resulted in well known
  "Bluetooth: hci0: command 0x0408 tx timeout"
errors and complete stop of UART data reception. Our Bluetooth traffic
consists of many independent small packets, mostly only a few bytes,
causing high usage of periods.

Changelog v2:
 - adapt title (this patches are not only for i.MX6)
 - improve some comments and patch descriptions
 - add a dma_wb() around BD_DONE flag
 - add Reviewed-by tags
 - split off  "serial: imx: adapt rx buffer and dma periods"

Philipp Puschmann (3):
  dmaengine: imx-sdma: fix buffer ownership
  dmaengine: imx-sdma: fix dma freezes
  dmaengine: imx-sdma: drop redundant variable

 drivers/dma/imx-sdma.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

-- 
2.23.0

