Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA38156C66
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 21:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBIUdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 15:33:16 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41857 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBIUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:33:15 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C739D1BF203;
        Sun,  9 Feb 2020 20:33:13 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] docs: userspace: ioctl-number: remove mc146818rtc conflict
Date:   Sun,  9 Feb 2020 21:33:04 +0100
Message-Id: <20200209203304.66004-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.3.43pre2, the RTC ioctls definitions were actually moved from
linux/mc146818rtc.h to linux/rtc.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2e91370dc159..f759edafd938 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -266,7 +266,6 @@ Code  Seq#    Include File                                           Comments
 'o'   01-A1  `linux/dvb/*.h`                                         DVB
 'p'   00-0F  linux/phantom.h                                         conflict! (OpenHaptics needs this)
 'p'   00-1F  linux/rtc.h                                             conflict!
-'p'   00-3F  linux/mc146818rtc.h                                     conflict!
 'p'   40-7F  linux/nvram.h
 'p'   80-9F  linux/ppdev.h                                           user-space parport
                                                                      <mailto:tim@cyberelk.net>
-- 
2.24.1

