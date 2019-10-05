Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167BECCA02
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfJENJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 09:09:58 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:36248 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJENJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:09:58 -0400
Received: from ipservice-092-217-086-168.092.217.pools.vodafone-ip.de ([92.217.86.168] helo=reykholt.kaiser.cx)
        by viti.kaiser.cx with esmtpa (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iGjoh-0003SB-QF; Sat, 05 Oct 2019 15:09:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/2] dt-bindings: display: fix native-mode setting
Date:   Sat,  5 Oct 2019 15:09:19 +0200
Message-Id: <20191005130921.12874-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918193853.25689-1-martin@kaiser.cx>
References: <20190918193853.25689-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to
Documentation/devicetree/bindings/display/panel/display-timing.txt,
native-mode is a property of the display-timings node.

If it's located outside of display-timings, the native-mode setting is
ignored and the first display timing is used.

We've already fixed the board definitions which got this wrong. Fix the
examples in the device tree bindings as well.

Martin Kaiser (2):
  dt-bindings: display: imx: fix native-mode setting
  dt-bindings: display: clps711x-fb: fix native-mode setting

 Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt | 2 +-
 Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

