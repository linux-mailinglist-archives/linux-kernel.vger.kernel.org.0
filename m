Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34D65B27C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGAAne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jun 2019 20:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfGAAne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:43:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1F4CADE6;
        Mon,  1 Jul 2019 00:43:31 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 01 Jul 2019 10:43:07 +1000
Subject: [PATCH 0/2] staging: update mt7621 dts for some recent driver
 changes
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Message-ID: <156194175140.1430.2478988354194078582.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt7621 MMC driver was recently removed from staging due to
copyright concerns.  Since then drivers/mmc/host/mtk-sd.c has been
enhanced to work with the mt7621 IP.  The first patch updates
the dts file to match this driver.

Earlier, the drivers/net/ethernet/mediatek/ driver was enhanced
to work with mt7621 hardware and the mt7621-eth driver was removed
from staging.  The second patch enhances the mt7621.dtsi to better
support this driver and particularly to allow the second network port
to be used in at least one of its possible configurations.

Thanks,
NeilBrown

---

NeilBrown (2):
      staging: mt7621-dts: update sdhci config.
      staging: mt7621-dts: add support for second network interface


 drivers/staging/mt7621-dts/Kconfig     |    7 ++++
 drivers/staging/mt7621-dts/Makefile    |    1 +
 drivers/staging/mt7621-dts/gbpc1.dts   |    2 +
 drivers/staging/mt7621-dts/gbpc2.dts   |   21 +++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi |   53 +++++++++++++++++++++++++++++---
 5 files changed, 77 insertions(+), 7 deletions(-)
 create mode 100644 drivers/staging/mt7621-dts/gbpc2.dts

--
Signature

