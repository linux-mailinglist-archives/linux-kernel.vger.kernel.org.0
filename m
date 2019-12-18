Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B521912458C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLRLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 06:17:50 -0500
Received: from foss.arm.com ([217.140.110.172]:42336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfLRLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:17:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12D330E;
        Wed, 18 Dec 2019 03:17:47 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F10D43F6CF;
        Wed, 18 Dec 2019 03:17:46 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 00/11] firmware: arm_scmi: Add support for multiple device per protocol
Date:   Wed, 18 Dec 2019 11:17:31 +0000
Message-Id: <20191218111742.29731-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only one scmi device is created for each protocol enumerated.
However, there is requirement to make use of some procotols by multiple
kernel subsystems/frameworks. One such example is SCMI PERFORMANCE
protocol which can be used by both cpufreq and devfreq drivers.
Similarly, SENSOR protocol may be used by either hwmon or iio subsystems,
and POWER protocol may be used by genpd and regulator drivers.

This series adds support for multiple device per protocol using scmi device
name if one is available. It also updates existing drivers to add
scmi device names to driver id tables.

Regards,
Sudeep

v1[1]->v2:
	- Dropped all the changes that mixes up the device specific init
	  with the protocol
	- Used idr_replace to skip protocol initialisation as suggested
	- Added collected reviewed/acked-by
	- Reworded hwmon changes to reflect that hwmon/iio drivers will
	  be mutually exclusive and hwmon needs to be removed if IIO
	  support is added

[1] https://lore.kernel.org/lkml/20191210145345.11616-1-sudeep.holla@arm.com/

Sudeep Holla (11):
  firmware: arm_scmi: Add support for multiple device per protocol
  firmware: arm_scmi: Skip scmi mbox channel setup for addtional devices
  firmware: arm_scmi: Add names to scmi devices created
  firmware: arm_scmi: Add versions and identifier attributes using dev_groups
  firmware: arm_scmi: Match scmi device by both name and protocol id
  firmware: arm_scmi: Stash version in protocol init functions
  firmware: arm_scmi: Skip protocol initialisation for additional devices
  clk: scmi: Match scmi device by both name and protocol id
  cpufreq: scmi: Match scmi device by both name and protocol id
  hwmon: (scmi-hwmon) Match scmi device by both name and protocol id
  reset: reset-scmi: Match scmi device by both name and protocol id

 drivers/clk/clk-scmi.c                     |  2 +-
 drivers/cpufreq/scmi-cpufreq.c             |  2 +-
 drivers/firmware/arm_scmi/bus.c            | 29 ++++++-
 drivers/firmware/arm_scmi/clock.c          |  2 +
 drivers/firmware/arm_scmi/driver.c         | 92 +++++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c           |  2 +
 drivers/firmware/arm_scmi/power.c          |  2 +
 drivers/firmware/arm_scmi/reset.c          |  2 +
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  2 +-
 drivers/firmware/arm_scmi/sensors.c        |  2 +
 drivers/hwmon/scmi-hwmon.c                 |  2 +-
 drivers/reset/reset-scmi.c                 |  2 +-
 include/linux/scmi_protocol.h              |  5 +-
 13 files changed, 134 insertions(+), 12 deletions(-)

-- 
2.17.1

