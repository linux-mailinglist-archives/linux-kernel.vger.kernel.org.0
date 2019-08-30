Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94128A39CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfH3PDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:03:10 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:39034 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfH3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:03:10 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id vT382000305gfCL01T38bz; Fri, 30 Aug 2019 17:03:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0003gg-4Y; Fri, 30 Aug 2019 17:03:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iQe-0005MH-2B; Fri, 30 Aug 2019 17:03:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/5] dt-bindings: arm: idle-states: Miscellaneous improvements
Date:   Fri, 30 Aug 2019 17:02:57 +0200
Message-Id: <20190830150302.20551-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Replace abbreviations "eg" and "ie" by "e.g." resp. "i.e.",
  - Correct references to wake-up delay,
  - Correct "constraints guarantees" to "constraint guarantees",
  - Add punctuation marks to improve readability,
  - Move exit-latency-us explanation to exit-latency-us section.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Split to ease review.
Feel free to squash into a single commit.

Geert Uytterhoeven (5):
  dt-bindings: arm: idle-states: Use "e.g." and "i.e." consistently
  dt-bindings: arm: idle-states: Correct references to wake-up delay
  dt-bindings: arm: idle-states: Correct "constraint guarantees"
  dt-bindings: arm: idle-states: Add punctuation to improve readability
  dt-bindings: arm: idle-states: Move exit-latency-us explanation

 .../devicetree/bindings/arm/idle-states.txt   | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
