Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B5BF1BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 18:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfKFRBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 12:01:07 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:23671 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfKFRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059664;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=S1CYtW/UKvourRGitE9tLFPWLqns2bi9wjMLuuoA2Yo=;
        b=mEcudq/MpkHqKMLM8f7VDd7qiXz+9BS6YucYeqGAIX/GmnwmfvbzGFIpTvw6k10UqJ
        ijB+lJxavw4rJiUxmZyls2KMRbBFOVjoyB+81xewH7OXxD64yISPNub+qEGIPsRJmNTl
        V5ckT2I3eSxEpPx3KBnU1dLo/R3HWz33Ebea/MXtZVJQzFTefYVS9rR+rWAUAZz0L38o
        3OkpD2yQasfh+yzrLEp7br5RS9voqoPhSLsvoTn2kR6ZqfSKK8nI09JWclrq0Mq3qrB3
        HModIx9o49fEXGPd0r251dLRkWlO4iZW1OZVCql/arviiI+XY9UTK05VRKrn51MgcFA9
        LQtg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H12hLp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:02 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/7] drm/mcde: DSI video mode fixes
Date:   Wed,  6 Nov 2019 17:58:28 +0100
Message-Id: <20191106165835.2863-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of fixes to make DSI video mode work better
using the MCDE driver. With these changes, MCDE appears to work
properly for the video mode panel I have been testing with.

Note: The patch that fixes the DSI link register setup for
video mode [1] is still necessary; but we still need to finish it
and actually make it initialize a panel correctly.

This series contains only patches for the other parts in MCDE.
I have tested it by disabling most of the register setup in the
DSI driver, which makes it re-use the properly working DSI register
set by the bootloader.

[1]: https://lists.freedesktop.org/archives/dri-devel/2019-October/238175.html

Stephan Gerhold (7):
  drm/mcde: Provide vblank handling unconditionally
  drm/mcde: Fix frame sync setup for video mode panels
  drm/mcde: dsi: Make video mode errors more verbose
  drm/mcde: dsi: Delay start of video stream generator
  drm/mcde: dsi: Fix duplicated DSI connector
  drm/mcde: dsi: Enable clocks in pre_enable() instead of mode_set()
  drm/mcde: Handle pending vblank while disabling display

 drivers/gpu/drm/mcde/mcde_display.c  |  57 +++++----
 drivers/gpu/drm/mcde/mcde_drm.h      |   1 +
 drivers/gpu/drm/mcde/mcde_drv.c      |  18 +--
 drivers/gpu/drm/mcde/mcde_dsi.c      | 167 +++++++++++++--------------
 drivers/gpu/drm/mcde/mcde_dsi_regs.h |  10 ++
 5 files changed, 126 insertions(+), 127 deletions(-)

-- 
2.23.0

