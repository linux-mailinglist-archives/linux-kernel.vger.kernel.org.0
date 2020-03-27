Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005CC19604B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0VQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 17:16:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:42838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgC0VQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:16:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B4E7AC4A;
        Fri, 27 Mar 2020 21:16:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-fixes-2020-03-27
Date:   Fri, 27 Mar 2020 22:16:30 +0100
Message-Id: <20200327211632.32346-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 55c7c0621078bd73e9d4d2a11eb36e61bc6fe998:

  ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations (2020-03-22 14:45:24 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-fixes-2020-03-27

for you to fetch changes up to be08d278eb09210fefbad4c9b27d7843f1c096b2:

  ARM: dts: bcm283x: Add cells encoding format to firmware bus (2020-03-27 21:36:17 +0100)

----------------------------------------------------------------
This patch is to be squashed into 55c7c0621078 ("ARM: dts: bcm283x: Fix
vc4's firmware bus DMA limitations") as it turned out to be faulty

----------------------------------------------------------------
Nicolas Saenz Julienne (1):
      ARM: dts: bcm283x: Add cells encoding format to firmware bus

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 3 +++
 1 file changed, 3 insertions(+)
