Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16B51A805
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEKNsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 09:48:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 09:48:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPSMH-0004ze-GL; Sat, 11 May 2019 13:48:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: bcm2835-camera: remove redundant assignment to variable ret
Date:   Sat, 11 May 2019 14:48:13 +0100
Message-Id: <20190511134813.5645-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized however this is never read and later
it is being reassigned to a new value. The initialization is redundant and
hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vc04_services/bcm2835-camera/controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 9841c30450ce..74410fedffad 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -579,7 +579,7 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
 			  struct v4l2_ctrl *ctrl,
 			  const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
-	int ret = -EINVAL;
+	int ret;
 	struct vchiq_mmal_port *control;
 
 	control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
-- 
2.20.1

