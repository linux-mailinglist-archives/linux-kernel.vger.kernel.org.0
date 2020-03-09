Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5120117DEC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCILcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 07:32:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55229 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCILcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:32:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id np16so4246182pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k04BRGZHR/QqhuU/poR1nzLbUDIgGLImpsqGHW3wXA=;
        b=Pa17L/M1pd207BXYQKDDTkKWp/GpfXk1nPhFypxmBIneOeH9L1dMLuE5/gBf5VM0kf
         cOE+W2F+bpYsALGe2loR9zz+mLeWpA0C3MZwsr5cc98J9HJd9uQHBeFLdKrY1+vUfe/W
         4Y4Z/7VDmvtAuSiS4hwDnRterr0QzqcBv1DLceMdJKOH9gJj9wbe4ZTqa3Kn/yo85Qt2
         rsgszAMrJYIn3fvdZ58g/pOR0uPrnd2tl6dhcSPhcQWlLkmhEADowpih+IHGLYxzMdC+
         cLyMtWQI+85WDgmh3betFQWwtzNR8R0+WleVAH5zsCIoSDxrMCmEhB+crcTY7od13MuM
         UlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k04BRGZHR/QqhuU/poR1nzLbUDIgGLImpsqGHW3wXA=;
        b=OYMFEuiVeksmx+t4h2Kbc5WtzhUtrYscMM0YNi2KT6zy33GCprw0CW1a1yhGKC4Mf+
         u2au9vDE5Z+Yvnsfu2hdKgozcs8Eyq32wyHdr2Xw+EQJ7dDfJIId53XzkqhaeCmcrFbV
         Wpqw3R2ld/t17dPVMk83cDar4M3fxSpUaWXfxlhqVwJULP7KkIiRq46huHSXdOQHyoAW
         vNX04+z78N1IqqjTnzrFVWWVC0x+x3HZ8xUY0xkAn70G0knUg8GeQ80IX6VJ6mqA/of3
         /qqqKwG4taJcI/2YEW8/zHC/J0Hoctj0kIWeFIlL8j6ENkGznMcwQWoZd5WOMqAZsTVe
         Cnag==
X-Gm-Message-State: ANhLgQ0upXx8QtWCxg5W5EkMtYCSHVvHLw8czUTKnXPHxWZ+ArSxHusH
        1w8hqALHzp14L91NDFx7ThH4kesaU4g=
X-Google-Smtp-Source: ADFU+vun4P1U5QIdL+uosgEY/IG8IA0AO2ZME/p+zXPyYKQVJACmVRZ85s+IKqhyroOdqCGDJr1XgQ==
X-Received: by 2002:a17:90b:4903:: with SMTP id kr3mr11658661pjb.3.1583753524257;
        Mon, 09 Mar 2020 04:32:04 -0700 (PDT)
Received: from nutanix.eng.nutanix.com ([192.146.154.247])
        by smtp.googlemail.com with ESMTPSA id c15sm19435613pja.30.2020.03.09.04.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:32:03 -0700 (PDT)
From:   Shaju Abraham <shajunutanix@gmail.com>
X-Google-Original-From: Shaju Abraham <shaju.abraham@nutanix.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shajunutanix@gmail.com,
        Shaju Abraham <shaju.abraham@nutanix.com>
Subject: [PATCH] mm/vmpressure.c: Include GFP_KERNEL flag to vmpressure
Date:   Mon,  9 Mar 2020 11:31:41 +0000
Message-Id: <20200309113141.167289-1-shaju.abraham@nutanix.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM pressure notification flags have excluded GFP_KERNEL with the
reasoning that user land will not be able to take any action in case of
kernel memory being low. This is not true always. Consider the case of
a user land program managing all the huge memory pages. By including
GFP_KERNEL flag whenever the kernel memory is low, pressure notification
can be send, and the manager process can split huge pages to satisfy kernel
memory requirement.
This is a common scanario in cloud. Most of the host memory is reserved
as hugepages and can be broken down to small pages on demand. This is
done to minimise fragmentation so that Virtual Machine power on will be
successful always.

Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
---
 mm/vmpressure.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 4bac22fe1aa2..7ccfb3dd8173 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -253,7 +253,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	 * Indirect reclaim (kswapd) sets sc->gfp_mask to GFP_KERNEL, so
 	 * we account it too.
 	 */
-	if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO | __GFP_FS)))
+	if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO |
+		     __GFP_FS | GFP_KERNEL)))
 		return;
 
 	/*
-- 
2.20.1

