Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD31964C6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgC1JS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 05:18:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37172 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:18:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id x1so4465207plm.4;
        Sat, 28 Mar 2020 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uEulqnoWhYVrXbCXkjImpUi0gSJmkTSnXSHAVgk4dzk=;
        b=VIsBg3fKj45txEWcrOyOCib8Y6r/8J7Y2RtDCyi4wSJBF2XN1ieldKVSMdGvq0b3OK
         8ajy3jdyzWFmIJIVL/xkqzhKcutM3Dc+mSM1qD8zD7m4mnk6mVwAtrowF8rpYCYBIpui
         JoeMiBEOLDLTsBFEIeuohyy9pNag6sjjFjfHHr+b8sXuz6Xr3zJgwWIRYr2rMyVLD260
         HIWgYeaKwre2HdTVd/FXAGtiToX/nkjcs0ng5VqjYCDrTBaL0JhezWfDJV3JvXNbmS+E
         /a5b+ERX5h8NEDNW26kHwiAkJeZewbLksJY5HHkk8WUQ/wAb38osOgPQV5Rl/22/MwgK
         Pi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uEulqnoWhYVrXbCXkjImpUi0gSJmkTSnXSHAVgk4dzk=;
        b=MaBGhuSutBf01gCaK57pjA2iOuomB65lOg6GjEbIzG+sQBUBs9SGgtquJ7GwqaPFSP
         GImzrtXo86PbYsTFvL2+yHHVhh1H4QNw5c93CD+YLFIKuyElH12ol8RFPrkPcedr/clY
         W7IjOwjd2BQcV5vPP4XJrDOK1Lg2KY8uZABEZ9KoPnJ0gNNJvRygtbcApRgddiTOhrpX
         yFgmP/tK+Gf4+leknhWFUMgzffbjfRpve2vr/jB6a8i/N9dfHKgCTlE3ad30V+ww2bqX
         sCOxjaWcQwajp2eRwRrSqxUnz4g9krd41mwmpipEaMAKctCElkbSDKNXEgsAAMOwzHYa
         Y8WA==
X-Gm-Message-State: ANhLgQ0eHdYqULq0B43xthVXR2HgC1ZL0vDDgzv28I98grLa+hK5/hXu
        N69wZkDZXnOUkA3fMlLZugE=
X-Google-Smtp-Source: ADFU+vs0VLGJZj1c1Mf3RkATTnXr6awH9f+oSWdL9DN5o4hQVBEOjYuAJ+yi4iZtUVJTG0iGs4AlsA==
X-Received: by 2002:a17:902:ba08:: with SMTP id j8mr3163660pls.70.1585387136045;
        Sat, 28 Mar 2020 02:18:56 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id x188sm5935844pfx.198.2020.03.28.02.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 02:18:55 -0700 (PDT)
Date:   Sat, 28 Mar 2020 14:48:50 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: Use the correct style for SPDX License Identifier
Message-ID: <20200328091844.GA3648@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to USB Core.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/usb/core/hub.h           | 2 +-
 drivers/usb/core/otg_whitelist.h | 2 +-
 drivers/usb/core/usb.h           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index a97dd1ba964e..73f4482d833a 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * usb hub driver head file
  *
diff --git a/drivers/usb/core/otg_whitelist.h b/drivers/usb/core/otg_whitelist.h
index 2ae90158ded7..fdd4897401e2 100644
--- a/drivers/usb/core/otg_whitelist.h
+++ b/drivers/usb/core/otg_whitelist.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * drivers/usb/core/otg_whitelist.h
  *
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 64ed4023a8c8..19e4c550bc73 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Released under the GPLv2 only.
  */
-- 
2.17.1

