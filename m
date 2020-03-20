Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD2018C919
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 09:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCTIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 04:44:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCTIoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:44:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 373A4AEC4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 08:44:31 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] edd: Use scnprintf() for avoiding potential buffer overflow
Date:   Fri, 20 Mar 2020 09:44:29 +0100
Message-Id: <20200320084429.1803-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This driver looks like an orphan.  If no one takes it, I'm willing to
merge the patch through my tree.

 drivers/firmware/edd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 29906e39ab4b..14d0970a7198 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -341,7 +341,7 @@ edd_show_legacy_max_cylinder(struct edd_device *edev, char *buf)
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "%u\n", info->legacy_max_cylinder);
+	p += scnprintf(p, left, "%u\n", info->legacy_max_cylinder);
 	return (p - buf);
 }
 
@@ -356,7 +356,7 @@ edd_show_legacy_max_head(struct edd_device *edev, char *buf)
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "%u\n", info->legacy_max_head);
+	p += scnprintf(p, left, "%u\n", info->legacy_max_head);
 	return (p - buf);
 }
 
@@ -371,7 +371,7 @@ edd_show_legacy_sectors_per_track(struct edd_device *edev, char *buf)
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "%u\n", info->legacy_sectors_per_track);
+	p += scnprintf(p, left, "%u\n", info->legacy_sectors_per_track);
 	return (p - buf);
 }
 
-- 
2.16.4

