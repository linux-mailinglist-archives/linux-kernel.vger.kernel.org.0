Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A7140CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAQOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 09:39:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:57378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgAQOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0CB49AAC2;
        Fri, 17 Jan 2020 14:38:59 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 00/15] coresight: make drivers modular
Date:   Fri, 17 Jan 2020 15:39:55 +0100
Message-Id: <20200117144010.11149-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goal of this patchset is to make coresight drivers modular and enable
them by default in the arm64 and arm defconfigs. This is work-in-progress
and completely untested. Mainly, module exit calls are incomplete or
missing. Posting here to get early feedback.

Please review.

Thanks you,

Best regards,
Yousaf 

Mian Yousaf Kaukab (15):
  Revert "drivers/hwtracing: make coresight-* explicitly non-modular"
  coresight: remove multiple init calls from funnel driver
  coresight: remove multiple init calls from replicator driver
  coresight: make API private
  coresight: rename coresight.c to coresight-bus.c
  coresight: combine bus and PMU init calls
  coresight: Makefile: regroup object files
  coresight: tmc-etr: add function to register catu ops
  coresight: etm-perf: remove unnecessary configuration check
  coresight: export global symbols
  coresight: add coresight prefix to barrier_pkt
  coresight: use IS_ENABLED macro for configuration symbols
  coresight: Kconfig: make all configurations tristate
  arm64: defconfig: enable coresight
  arm: config: enable coresight in v5 and v7 defconfigs

 arch/arm/configs/multi_v5_defconfig                |    8 +
 arch/arm/configs/multi_v7_defconfig                |    8 +
 arch/arm64/configs/defconfig                       |    8 +
 drivers/hwtracing/coresight/Kconfig                |   47 +-
 drivers/hwtracing/coresight/Makefile               |   23 +-
 drivers/hwtracing/coresight/coresight-bus.c        | 1368 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-catu.c       |    9 +-
 drivers/hwtracing/coresight/coresight-catu.h       |    2 -
 drivers/hwtracing/coresight/coresight-etb10.c      |    9 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |    4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   13 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |   12 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |    7 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   34 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   32 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   34 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |    2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   23 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |    6 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |    3 +
 drivers/hwtracing/coresight/coresight-tpiu.c       |    6 +-
 drivers/hwtracing/coresight/coresight.c            | 1338 -------------------
 include/linux/amba/bus.h                           |    9 -
 include/linux/coresight.h                          |   50 -
 25 files changed, 1602 insertions(+), 1457 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-bus.c
 delete mode 100644 drivers/hwtracing/coresight/coresight.c

-- 
2.16.4

