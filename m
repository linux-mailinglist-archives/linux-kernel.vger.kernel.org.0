Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03AED5D48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfJNIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 04:21:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:65351 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729923AbfJNIVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:21:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 01:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="199341831"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 01:21:13 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iJvbM-000AU2-MO; Mon, 14 Oct 2019 16:21:12 +0800
Date:   Mon, 14 Oct 2019 16:20:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     kbuild-all@lists.01.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [RFC PATCH] drm/bridge: anx7625: ANX_OUI[] can be static
Message-ID: <20191014082037.crfdamwf3jcqcsit@332d0cec05f4>
References: <55295c49503a963f3417b917fd7163feb26ed0b6.1570760115.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55295c49503a963f3417b917fd7163feb26ed0b6.1570760115.git.xji@analogixsemi.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 152a82b6747f ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP bridge driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 anx7625.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 96adf3b89d7f0..a261f4d31ea88 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -728,7 +728,7 @@ static int anx7625_dpi_config(struct anx7625_data *ctx)
 	return ret;
 }
 
-const u8 ANX_OUI[3] = { 0x00, 0x22, 0xB9 };
+static const u8 ANX_OUI[3] = { 0x00, 0x22, 0xB9 };
 static int is_anx_dongle(struct anx7625_data *ctx)
 {
 	u8 buf[3];
