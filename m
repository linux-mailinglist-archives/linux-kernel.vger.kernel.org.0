Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A22149CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAZUMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 15:12:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:52030 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAZUMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:12:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 12:12:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="222331124"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jan 2020 12:12:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivoGQ-0006FK-Gl; Mon, 27 Jan 2020 04:12:10 +0800
Date:   Mon, 27 Jan 2020 04:11:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [RFC PATCH] staging: vc04_services: vchiq_dump_service_use_state can
 be static
Message-ID: <20200126201136.5c52szonqkuuavfc@f53c9c00458a>
References: <20200124144617.2213-7-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124144617.2213-7-nsaenzjulienne@suse.de>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fc2dd7f28276 ("staging: vc04_services: get rid of vchiq_platform_use_suspend_timer()")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 vchiq_arm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index a75d5092cc73b..f87818c03cfff 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2875,7 +2875,7 @@ struct service_data_struct {
 	int use_count;
 };
 
-void
+static void
 vchiq_dump_service_use_state(struct vchiq_state *state)
 {
 	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
