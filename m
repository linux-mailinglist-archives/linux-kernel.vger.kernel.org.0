Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7967C903
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfGaQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:43:41 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:55508 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfGaQni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:43:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4CD8BFB04;
        Wed, 31 Jul 2019 18:43:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9TGo641ILXY0; Wed, 31 Jul 2019 18:43:33 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5EB7746D8A; Wed, 31 Jul 2019 18:43:31 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] imx: Fix typo in iMQ8MQ reset names
Date:   Wed, 31 Jul 2019 18:43:29 +0200
Message-Id: <cover.1564591352.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the mipi dsi resets were called

  IMX8MQ_RESET_MIPI_DIS_

instead of

  IMX8MQ_RESET_MIPI_DSI_

Since they're DSI related this looks like a typo.

Guido Günther (2):
  dt-bindings: reset: Fix typo in imx8mq resets
  reset: imx7: Fix IMX8MQ_RESET_MIPI_DSI_ defines

 drivers/reset/reset-imx7.c               | 12 ++++++------
 include/dt-bindings/reset/imx8mq-reset.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.20.1

