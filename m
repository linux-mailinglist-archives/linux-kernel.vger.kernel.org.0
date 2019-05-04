Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C255B138BB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEDKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 06:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfEDKZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:25:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FB43ACC4;
        Sat,  4 May 2019 10:25:43 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Date:   Sat, 04 May 2019 20:24:56 +1000
Subject: [PATCH 0/4] mtk-sd enhancement to support MT7621 - V2
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        thirtythreeforty@gmail.com
Message-ID: <155696540998.8632.5242582397805128125.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT7621 MIPS-based SOC contains an sdhci unit that is
much the same as the units supported by mtk-sd.c.

These patches enhance the driver so that I can use it on my MT7621
board (gnubee.org).

This series have been revised based on feedback from Chaotian.

Thanks,
NeilBrown

---

NeilBrown (4):
      mmc: mtk-sd: don't hard-code interrupt trigger type
      mmc: mtk-sd: add support for config found in mt7620 family SOCs.
      mmc: mtk-sd: enable internal card-detect logic.
      mmc: mtk-sd: select REGULATOR


 Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1 
 drivers/mmc/host/Kconfig                         |    1 
 drivers/mmc/host/mtk-sd.c                        |   78 +++++++++++++++++++++-
 3 files changed, 75 insertions(+), 5 deletions(-)

--
Signature

