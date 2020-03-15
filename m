Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87617185F17
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 19:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgCOSiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 14:38:07 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:48245 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgCOSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:38:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gSqK13NPzw;
        Sun, 15 Mar 2020 19:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584297485; bh=wwHl4ckQVVyEhjv3zlUJvCyhzJS+DJkqAAlUhZ0JEtc=;
        h=Date:From:Subject:To:Cc:From;
        b=cj9KAAvrmBshazU43V+ZM8S8apAfivsy/u8csZwZC+zil0QzrdOM0Is1uUrNLJL20
         uGQdsYQJXzqqFk2+IgbzoyvL5/78MmT8akciCiuroTd2lqWrLndMHWRQ4v0BFoPAPJ
         h8YRR43KkbF8a3jyupMw3Jze0LGHHujdn+RWv3hnJzXW5ajp0qmHn4/vsKB+VKDl2p
         RWrV3JUnScZGQqZfXM18HjzHRsIsYnlybINU74LuW7TfCWGmw+/XkgpadJgp9Obk7K
         pqSH1L786H9t7M79SWphah1VjHl3psnesVvQp059VZZHqSBNwpHs8LRII4nmisY2Nb
         NMDr8O5YgPhrQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 19:38:04 +0100
Message-Id: <cover.1584296940.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/3] clk: at91: support configuring PCKx parent via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends AT91 with clock references to PCKx and PLLA/AUDIOPLL.

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.

Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: sama5d2: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91sam9260.c   |  7 +++--
 drivers/clk/at91/at91sam9rl.c    |  6 +++--
 drivers/clk/at91/at91sam9x5.c    |  6 +++--
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d4.c       |  6 +++--
 include/dt-bindings/clock/at91.h |  3 +++
 8 files changed, 52 insertions(+), 40 deletions(-)

-- 
2.20.1

