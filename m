Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12F76248F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbfGHPoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 11:44:10 -0400
Received: from foss.arm.com ([217.140.110.172]:51994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391208AbfGHPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:44:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C320F360;
        Mon,  8 Jul 2019 08:44:06 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5A943F59C;
        Mon,  8 Jul 2019 08:44:05 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 0/6] firmware: arm_scmi: miscellaneous fixes/updates
Date:   Mon,  8 Jul 2019 16:43:52 +0100
Message-Id: <20190708154358.16227-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are few miscellaneous fixes and updates to SCMI. Fixes are mostly
for the reported issues and updates are based on code inspection during
development of new features(delayed response and notifications). The
new features will follow this.

--
Regards,
Sudeep

Nishad Kamdar (1):
  firmware: arm_scmi: Use the correct style for SPDX License Identifier

Sudeep Holla (5):
  firmware: arm_scmi: Align few names in sensors protocol with SCMI specification
  firmware: arm_scmi: Remove extra check for invalid length message responses
  firmware: arm_scmi: Fix few trivial typos in comments
  firmware: arm_scmi: Use the term 'message' instead of 'command'
  firmware: arm_scmi: Check if platform has released shmem before using

 drivers/firmware/arm_scmi/common.h  | 12 ++++++------
 drivers/firmware/arm_scmi/driver.c  | 24 +++++++++++++-----------
 drivers/firmware/arm_scmi/sensors.c | 28 +++++++++++++++-------------
 include/linux/scmi_protocol.h       | 12 ++++++------
 4 files changed, 40 insertions(+), 36 deletions(-)

-- 
2.17.1

