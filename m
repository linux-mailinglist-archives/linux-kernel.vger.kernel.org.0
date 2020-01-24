Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6314A148A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgAXOqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:46:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387979AbgAXOqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7510AFA8;
        Fri, 24 Jan 2020 14:46:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/22] staging: vc04_services: suspend/resume cleanup
Date:   Fri, 24 Jan 2020 15:45:54 +0100
Message-Id: <20200124144617.2213-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in the process of preparing vchiq to support the Raspberry Pi 4, I
stumbled upon a bunch of dead code in it. Which this series deletes.

Ultimately the idea is to clean up vchiq_bcm2835_arm.c up to a point
where it'll be easy to join it with vchiq_arm.c, which IIRC the TODO
file states, should be the sole responsible for platform code.

With this we'll be able to introduce RPi4's functionality in a cleaner
way.

Overall it's a 500 line clean up, I tried to keep the patches as small and
manageable as possible, but I'd be happy to squash them if you prefer it
that way.

This was tested on a RPi3-B using the camera and HDMI audio and
vchiq_test app.

---

Nicolas Saenz Julienne (22):
  staging: vc04_services: Remove unused variables in struct
    vchiq_arm_state
  staging: vc04_services: Get rid of resume_blocked in struct
    vchiq_arm_state
  staging: vc04_services: Get rid of resume_blocker completion in struct
    vchiq_arm_state
  staging: vc04_services: get rid of blocked_blocker completion in
    struct vchiq_arm_state
  staging: vc04_services: Delete blocked_count in struct vchiq_arm_state
  staging: vc04_services: get rid of vchiq_platform_use_suspend_timer()
  staging: vc04_services: Get rid of vchiq_platform_paused/resumed()
  staging: vc04_services: Get rid of vchiq_platform_suspend/resume()
  staging: vc04_services: Get rid of vchiq_platform_videocore_wanted()
  staging: vc04_services: Get rid of vchiq_platform_handle_timeout()
  staging: vc04_services: Get rid of vchiq_on_remote_use_active()
  staging: vc04_services: Get rid of vchiq_arm_vcsuspend()
  staging: vc04_services: Get rid of vchiq_check_resume()
  staging: vc04_services: Delete vc_suspend_complete completion
  staging: vc04_services: Get rid of unused suspend/resume states
  staging: vc04_services: Get rid of USE_TYPE_SERVICE_NO_RESUME
  staging: vc04_services: Delete vchiq_platform_check_suspend()
  staging: vc04_services: Get of even more suspend/resume states
  staging: vc04_services: Get rid of vc_suspend_state in struct
    vchiq_arm_state
  staging: vc04_services: Get rid of vchiq_arm_vcresume()'s signature
  staging: vc04_services: Get rid of the rest of suspend/resume state
    handling
  staging: vc04_services: vchiq_arm: Get rid of unused defines

 .../interface/vchiq_arm/vchiq_2835_arm.c      |  43 --
 .../interface/vchiq_arm/vchiq_arm.c           | 496 +-----------------
 .../interface/vchiq_arm/vchiq_arm.h           |  81 +--
 .../interface/vchiq_arm/vchiq_core.c          |  16 -
 .../interface/vchiq_arm/vchiq_core.h          |  15 -
 5 files changed, 11 insertions(+), 640 deletions(-)

-- 
2.25.0

