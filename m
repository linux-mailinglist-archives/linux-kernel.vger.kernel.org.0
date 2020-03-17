Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C01889D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 17:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCQQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 12:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:10:28 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880D420724;
        Tue, 17 Mar 2020 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584461427;
        bh=TE0OALslBnAglDc0PbW0+eztUT4bhEdyvuy67q7ODsA=;
        h=From:To:Cc:Subject:Date:From;
        b=t8O7crINsA3AtuGuMMK+pePvF5aF7Fb0BIZ1zxo4crz2S9zepUdiZ303EtOl0nAfm
         4DZKRihRj8Xp/JbUwFFLy7LidMQ5YRnCmhfg6NdhMC2SAILL8Db8Y/bncOQIHfzaV6
         XNTFBaPv+ie6KQcXKLng6/sY+pKK3hCkVDBZ4/10=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv3 0/5] clk: agilex: add clock driver
Date:   Tue, 17 Mar 2020 11:10:17 -0500
Message-Id: <20200317161022.11181-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 3 of the patchset to add a clock driver to the Agilex
platform.

This version adds 2 new patches that was a result from comments received
in v2.

Patch 2/5: clk: socfpga: remove clk_ops enable/disable methods
Patch 3/5: clk: socfpga: add const to _ops data structures

Thanks,
Dinh


Dinh Nguyen (5):
  clk: socfpga: stratix10: use new parent data scheme
  clk: socfpga: remove clk_ops enable/disable methods
  clk: socfpga: add const to _ops data structures
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform

 .../bindings/clock/intel,agilex.yaml          |  36 ++
 drivers/clk/Makefile                          |   3 +-
 drivers/clk/socfpga/Makefile                  |   2 +
 drivers/clk/socfpga/clk-agilex.c              | 454 ++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c            |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c          |  10 +-
 drivers/clk/socfpga/clk-pll-a10.c             |   4 +-
 drivers/clk/socfpga/clk-pll-s10.c             |  78 ++-
 drivers/clk/socfpga/clk-pll.c                 |   4 +-
 drivers/clk/socfpga/clk-s10.c                 | 160 ++++--
 drivers/clk/socfpga/stratix10-clk.h           |  10 +-
 include/dt-bindings/clock/agilex-clock.h      |  70 +++
 12 files changed, 784 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.25.1

