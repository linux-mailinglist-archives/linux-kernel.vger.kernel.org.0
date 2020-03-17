Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5F1882BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCQL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 07:59:18 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:45402 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:59:18 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48hWtD10dDzw;
        Tue, 17 Mar 2020 12:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584446356; bh=mWo3VWEs8kJsqzR0upHbKdlUzSYwbJU2fXorl6by/+o=;
        h=Date:From:Subject:To:Cc:From;
        b=fP2UXQNPvLrtxnrBxBJ1G3ZdIzN1L827eTszxFXdalDbhr8GqFpjj9cLlggXrZUYD
         lwvLMpytP5alj8e4Ik5S+bmgQnrjeEgAFQxJEEblFMBz3j5ujCFInzC02ZiXxSbTKT
         Wrbg33qce3qsLuzPMVtEoZ/7wOHCJeFGlJOICeHRAsseIEQ+CY/z3xJ6HLXJxtESLA
         bWwjw9jLmxfn/Jl8jQh1rWSWy5gSFdM22v8FmS71Oxhna0xjGq0Ycfoz2WjVzRTlhF
         x966K0PscdMflIW0OT0ATJ1kFLMHhqNWpv8bDB6tQ/xpumWrqXNIj9h8Pa/mTUKuYw
         jQq0wrhdzHpZQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 17 Mar 2020 12:59:13 +0100
Message-Id: <cover.1584446053.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/3] clk: at91: support configuring PCKx parent via DT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends AT91 with clock references to PCKx and
PLLA/AUDIOPLL.

First patch simplifies clock table allocation. Next two update the table
with missing clock pointers and IDs.

v2: rebased against current clk/clk-at91 tree

Michał Mirosław (3):
  clk: at91: optimize pmc data allocation
  clk: at91: allow setting PCKx parent via DT
  clk: at91: sama5d2: allow setting all PMC clock parents via DT

 drivers/clk/at91/at91sam9260.c   |  7 +++--
 drivers/clk/at91/at91sam9g45.c   |  6 +++--
 drivers/clk/at91/at91sam9n12.c   |  6 +++--
 drivers/clk/at91/at91sam9rl.c    |  6 +++--
 drivers/clk/at91/at91sam9x5.c    |  6 +++--
 drivers/clk/at91/pmc.c           | 44 ++++++++++++--------------------
 drivers/clk/at91/pmc.h           |  8 ++++--
 drivers/clk/at91/sam9x60.c       |  6 +++--
 drivers/clk/at91/sama5d2.c       | 12 ++++++---
 drivers/clk/at91/sama5d3.c       |  6 +++--
 drivers/clk/at91/sama5d4.c       |  6 +++--
 include/dt-bindings/clock/at91.h |  3 +++
 12 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.20.1

