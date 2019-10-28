Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CCAE7033
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 12:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfJ1LON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 07:14:13 -0400
Received: from knopi.disroot.org ([178.21.23.139]:34198 "EHLO
        knopi.disroot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:14:13 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 07:14:12 EDT
Received: from localhost (localhost [127.0.0.1])
        by disroot.org (Postfix) with ESMTP id A667130B3D;
        Mon, 28 Oct 2019 12:08:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
        by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
        with UTF8SMTP id 2l6BXwpU0LXA; Mon, 28 Oct 2019 12:08:22 +0100 (CET)
From:   Dhanuka Warusadura <csx@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
        t=1572260902; bh=s1qf9ZKS5xrrd7dcGul2Q+7zTiwuK5JOO7Osfl0QXxE=;
        h=From:To:Cc:Subject:Date;
        b=kpBWMmsbz1Af+NAs4+nHDlo8hHRxMWl+pW32NcVPeoJZz4c1SG40r9aWYrLrHGlqr
         pI8LdT8MkjKyAb9u1XGVx4f74dMnwSa19WrSMO9unW5/ZDhN91iSxF62Zp1z6MBHRT
         PEs0ArcA3s5EVuItJIXENxJezFAuWA92d/SqR7JQqXU1Q6RXVNZfp3uEMnDZ/xzumv
         staxkvT2w8zUSBYHBYkAhDKNPVcq39nz6DzoRWceWOjq1ZNblP7YxxE+5RT2q6etMm
         qoO2DwH13b+pIy4wnExTt1/xWtrI39eJ+xmhW8KbY2WuGUhaa6zhfIfjuj6PD116GN
         qaRkVamggMtgw==
To:     zbr@ioremap.net, skhan@linuxfoundation.org, mchehab@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Dhanuka Warusadura <csx@disroot.org>
Subject: [PATCH] Fixes documentation warning.
Date:   Mon, 28 Oct 2019 16:37:44 +0530
Message-Id: <20191028110744.6523-1-csx@disroot.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes - warning: Function parameter or member 'of_match_table'
not described in 'w1_family'

Signed-off-by: Dhanuka Warusadura <csx@disroot.org>
---
 include/linux/w1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 7da0c7588e04..cebf3464bc03 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -262,6 +262,7 @@ struct w1_family_ops {
  * @family_entry:	family linked list
  * @fid:		8 bit family identifier
  * @fops:		operations for this family
+ * @of_match_table: open firmware match table
  * @refcnt:		reference counter
  */
 struct w1_family {
-- 
2.24.0.rc1

