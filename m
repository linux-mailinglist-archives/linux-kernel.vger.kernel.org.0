Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27EAFDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfIKNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 09:42:57 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:59288 "EHLO
        20.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfIKNm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:42:57 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 09:42:56 EDT
Received: from player168.ha.ovh.net (unknown [10.109.159.248])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 91D9C12FEB9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:03:35 +0200 (CEST)
Received: from qperret.net (115.ip-51-255-42.eu [51.255.42.115])
        (Authenticated sender: qperret@qperret.net)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id BC049997FD25;
        Wed, 11 Sep 2019 13:03:18 +0000 (UTC)
From:   Quentin Perret <qperret@qperret.net>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@qperret.net
Subject: [PATCH RESEND v8 0/4] Make IPA use PM_EM
Date:   Wed, 11 Sep 2019 15:03:10 +0200
Message-Id: <20190911130314.29973-1-qperret@qperret.net>
X-Mailer: git-send-email 2.17.1
X-Ovh-Tracer-Id: 17340828891127700473
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending this from an email address I can access. For a cover letter,
see:
https://lore.kernel.org/lkml/20190812084235.21440-1-quentin.perret@arm.com/

Changes in v8:
 - Fixed checkpatch errors (Rui)

Changes in v7
 - Added patch 02/04 to fix the build error reported by the kbuild bot

Changes in v6
 - Added Daniel's and Viresh's Acked-by to all patches

Changes in v5:
 - Changed patch 02 to guard IPA-specific code in cpu_cooling.c with
   appropriate ifdefery (Daniel)
 - Rebased on 5.2-rc2

Changes in v4:
 - Added Viresh's Acked-by to all 3 patches
 - Improved commit message of patch 3/3 to explain how it has no
   functional impact on existing users (Eduardo)

Changes in v3:
 - Changed warning message for unordered tables to something more
   explicit (Viresh)
 - Changed WARN() into a pr_err() for consistency

Changes in v2:
 - Fixed patch 01/03 to actually enable CONFIG_ENERGY_MODEL
 - Added "depends on ENERGY_MODEL" to IPA (Daniel)
 - Added check to bail out if the freq table is unsorted (Viresh)


Quentin Perret (4):
  arm64: defconfig: Enable CONFIG_ENERGY_MODEL
  PM / EM: Declare EM data types unconditionally
  thermal: cpu_cooling: Make the power-related code depend on IPA
  thermal: cpu_cooling: Migrate to using the EM framework

 arch/arm64/configs/defconfig  |   1 +
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 427 ++++++++++++++--------------------
 include/linux/energy_model.h  |   3 +-
 4 files changed, 178 insertions(+), 254 deletions(-)

-- 
2.22.1

