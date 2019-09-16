Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0CB3369
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 04:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfIPCa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 22:30:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19167 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728049AbfIPCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:30:57 -0400
X-UUID: 7c80d2b7c4eb44afa2af2701a38bad7b-20190916
X-UUID: 7c80d2b7c4eb44afa2af2701a38bad7b-20190916
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1217469425; Mon, 16 Sep 2019 10:29:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 10:29:46 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Sep 2019 10:29:45 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 0/8] add driver for boe,tv101wum-nl6, boe,tv101wum-n53, auo,kd101n80-45na and auo,b101uan08.3 panels
Date:   Mon, 16 Sep 2019 10:29:33 +0800
Message-ID: <20190916022941.15404-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 2383DF5C1B7A65AC387BB84E774E25DA2CBF0E84ADC564254AA45A1F6C629A0B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:
 - add auo,b101uan08.3 panel for this driver.
 - add boe,tv101wum-n53 panel for this driver.

Changes since v3:
 - remove check enable_gpio.
 - fine tune the auo,kd101n80-45na panel's power on timing.

Changes since v2:
 - correct the panel size
 - remove blank line in Kconfig
 - move auo,kd101n80-45na panel driver in this series.

Changes since v1:

 - update typo nl6 -> n16.
 - update new panel config and makefile are added in alphabetically order.
 - add the panel mode and panel info in driver data.
 - merge auo,kd101n80-45a and boe,tv101wum-nl6 in one driver

Jitao Shi (8):
  dt-bindings: display: panel: Add BOE tv101wum-n16 panel bindings
  drm/panel: support for BOE tv101wum-nl6 wuxga dsi video mode panel
  dt-bindings: display: panel: add auo kd101n80-45na panel bindings
  drm/panel: support for auo,kd101n80-45na wuxga dsi video mode panel
  dt-bindings: display: panel: add boe tv101wum-n53 panel documentation
  drm/panel: support for boe,tv101wum-n53 wuxga dsi video mode panel
  dt-bindings: display: panel: add AUO auo,b101uan08.3 panel
    documentation
  drm/panel: support for auo,b101uan08.3 wuxga dsi video mode panel

 .../display/panel/auo,b101uan08.3.txt         |  34 +
 .../display/panel/auo,kd101n80-45na.txt       |  34 +
 .../display/panel/boe,tv101wum-n53.txt        |  34 +
 .../display/panel/boe,tv101wum-nl6.txt        |  34 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 876 ++++++++++++++++++
 7 files changed, 1022 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c

-- 
2.21.0

