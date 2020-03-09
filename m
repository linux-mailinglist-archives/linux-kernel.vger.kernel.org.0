Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5F17E8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 20:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCITnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 15:43:03 -0400
Received: from v6.sk ([167.172.42.174]:34528 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCITnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:43:03 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id DBBDC60EEE;
        Mon,  9 Mar 2020 19:43:00 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/17] clk: mmp2: MMP2 CLK Update
Date:   Mon,  9 Mar 2020 20:42:37 +0100
Message-Id: <20200309194254.29009-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch series, that includes fixes and
enhancements for the MMP2/MMP3 clock driver that I hope to get into 5.7.
Compared to first submission, patches 11/17 to 17/17 were added.
Details in changelogs of individual patches.

It starts off with a handful of cleanups:

  [PATCH v2 01/17] clk: mmp2: Remove a unused prototype
  [PATCH v2 02/17] clk: mmp2: Constify some strings
  [PATCH v2 03/17] dt-bindings: clock: Convert marvell,mmp2-clock to

The next patch adds the logic for calculating the rate of clock signals
coming from the PLLs dynamically. Currently they are hardcoded to more
or less wrong values (how wrong it is depends on how did firmware set
things up), which causes bad timings when they are used (e.g. to generate
display clock).

  [PATCH v2 04/17] clk: mmp2: Add support for PLL clock sources

Then MMP2 is switched over to use it:

  [PATCH v2 05/17] clk: mmp2: Stop pretending PLL outputs are constant

Switching MMP3 requires some more work, because until now, the driver
didn't distinguish between the versions of the SoC:

  [PATCH v2 06/17] dt-bindings: clock: Add MMP3 compatible string
  [PATCH v2 07/17] clk: mmp2: Check for MMP3
  [PATCH v2 08/17] dt-bindings: marvell,mmp2: Add clock ids for MMP3 PLLs
  [PATCH v2 09/17] clk: mmp2: Add PLLs that are available on MMP3
  [PATCH v2 10/17] ARM: dts: mmp3: Use the MMP3 compatible string for

Patches that follow add just add more clocks paired with DT bindings:

  [PATCH v2 11/17] dt-bindings: marvell,mmp2: Add clock ids for the GPU
  [PATCH v2 12/17] clk: mmp2: add the GPU clocks
  [PATCH v2 13/17] dt-bindings: marvell,mmp2: Add clock ids for the
  [PATCH v2 14/17] clk: mmp2: Add clocks for the thermal sensors
  [PATCH v2 15/17] dt-bindings: marvell,mmp2: Add clock id for the fifth
  [PATCH v2 16/17] clk: mmp2: Add clock for fifth SD HCI on MMP3

The last one is a straightforward bug fix, independent of the rest of the
patch set:

  [PATCH v2 17/17] clk: mmp2: Fix bit masks for LCDC I/O and pixel clocks

The hardware vendor doesn't supply documentation, so this is best-effort
work based on the code dump from Marvell and OLPC Open Firmware.

Tested on MMP2 and MMP3 based hardware I have; details in relevant
commit messages.

Thank you,
Lubo


