Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714517670C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfGZNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:14:46 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36322 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGZNOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2CC44FB07;
        Fri, 26 Jul 2019 15:14:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RdK5Fd9fsItN; Fri, 26 Jul 2019 15:14:41 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0AE6046AA1; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] drm/panel: jh057n00900: Move dsi init sequence to prepare
Date:   Fri, 26 Jul 2019 15:14:35 +0200
Message-Id: <cover.1564146727.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If the panel is wrapped in a panel_bridge it gets prepar()ed before the
upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
are not enabled yet). To avoid this move the panel's first DSI access to
enable() so the upstream bridge can prepare the DSI host controller in
it's pre_enable().

The second patch makes the disable() call symmetric to the above and the third
one just eases debugging.

Changes from v1:
* As per review comments by Sam Ravnborg
  * Ignore failures to disable the backlight in jh057n_disable()
  * Add 'drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently'
* Collected Reviewed-By: Thanks Sam!

To: "Guido Günther" <agx@sigxcpu.org>,Purism Kernel Team <kernel@puri.sm>,Thierry Reding <thierry.reding@gmail.com>,Sam Ravnborg <sam@ravnborg.org>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org


Guido Günther (4):
  drm/panel: jh057n00900: Move panel DSI init to enable()
  drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
  drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
  drm/panel: jh057n00900: Use drm_panel_{unprepare,disable} consistently

 .../drm/panel/panel-rocktech-jh057n00900.c    | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
2.20.1

