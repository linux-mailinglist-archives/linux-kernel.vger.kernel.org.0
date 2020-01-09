Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228A81353BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgAIHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:34:52 -0500
Received: from mail.manjaro.org ([176.9.38.148]:40496 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgAIHew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:34:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 4FE1936E4161;
        Thu,  9 Jan 2020 08:34:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r6a5lqKyRSmw; Thu,  9 Jan 2020 08:34:49 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/1] Regression in rockchipdrm
Date:   Thu,  9 Jan 2020 08:31:28 +0100
Message-Id: <20200109073129.378507-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2589c4025f13 ("drm/rockchip: Avoid drm_dp_link helpers") changed
the datatype used for storing the display port data rate to u8.
A u8 is not sufficient to store the data rate, resulting in a crash due
to incorrect calculations.

This series resolves the issue by restoring the data type changed in
commit 2589c4025f13 to their original type.

Thanks to CrystalGamma for identifying the commit causing the regression.

v2: Keep lane count as u8

Tobias Schramm (1):
  drm/rockchip: fix integer type used for storing dp data rate

 drivers/gpu/drm/rockchip/cdn-dp-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.24.1

