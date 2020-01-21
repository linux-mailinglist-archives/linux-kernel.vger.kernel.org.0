Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D906D143838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAUI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:29:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47804 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728655AbgAUI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:29:45 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00L8Re4d005791;
        Tue, 21 Jan 2020 03:29:05 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkyta6spf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 03:29:05 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 00L8T2vE052554
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 21 Jan 2020 03:29:03 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 21 Jan
 2020 00:29:01 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 21 Jan 2020 00:29:00 -0800
Received: from btogorean-pc.ad.analog.com ([10.48.65.146])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00L8Sm9Z001010;
        Tue, 21 Jan 2020 03:28:50 -0500
From:   Bogdan Togorean <bogdan.togorean@analog.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <sam@ravnborg.org>, <alexander.deucher@amd.com>,
        <matt.redfearn@thinci.com>, <robdclark@chromium.org>,
        <wsa+renesas@sang-engineering.com>, <linux-kernel@vger.kernel.org>,
        Bogdan Togorean <bogdan.togorean@analog.com>
Subject: [PATCH v4 0/3] drm: bridge: adv7511: Add support for ADV7535
Date:   Tue, 21 Jan 2020 10:27:18 +0200
Message-ID: <20200121082719.27972-1-bogdan.togorean@analog.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_02:2020-01-20,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=913 mlxscore=0 suspectscore=1
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set add support for ADV7535 part in ADV7511 driver.

ADV7535 and ADV7533 are pin to pin compatible parts but ADV7535
support TMDS clock upto 148.5Mhz and resolutions up to 1080p@60Hz.

---
Changes in v4:
 - get out ADV7533 v1p2 voltage selection of this patch set
 - removal CONFIG_DRM_I2C_ADV7533 from Kconfig moved to new commit

Bogdan Togorean (3):
  drm: bridge: adv7511: Remove DRM_I2C_ADV7533 Kconfig
  drm: bridge: adv7511: Add support for ADV7535
  dt-bindings: drm: bridge: adv7511: Add ADV7535 support

 .../bindings/display/bridge/adi,adv7511.txt   | 23 ++++++-----
 drivers/gpu/drm/bridge/adv7511/Kconfig        | 13 ++----
 drivers/gpu/drm/bridge/adv7511/Makefile       |  3 +-
 drivers/gpu/drm/bridge/adv7511/adv7511.h      | 40 +------------------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  | 20 +++++-----
 5 files changed, 26 insertions(+), 73 deletions(-)

-- 
2.24.1

