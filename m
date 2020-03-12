Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3949182634
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 01:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgCLAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 20:22:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37330 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbgCLAWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:22:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id 6so5139990wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMQYZ+6NFPRcSEcavCV/oXjjG97VYnibSYtGEAw9FKE=;
        b=YBCJcKO7WMERIDKhjn9c2ArgxPEQrxYKQEQ6LEfLaxrvuoz6rScdfqIJUaX/XDRZny
         brr2Fvy1Sghb7FOcgZLndwtSBycagaPxcRLChohsdVmGmuJKinJ3Fv/UY+FUdT1CGwow
         qeYRKy9iruEhap5M+4IhNnTM94la8flsSvACVFbjxmIblKzpQuxUjPg/puovL1noOdlb
         7opS1YDKCcch3XvJe31/eHlb7ES3VRqmIcVcKefQZ2GrEuNx7y3T+nEsWOOgNNdDPIOV
         SKeLbUsxg4iEOonOYb5ImSQZTmzPPzAGf5KFWeiZaZ1B4kU3KN0X3+vB7XcXs0dIlP51
         mQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMQYZ+6NFPRcSEcavCV/oXjjG97VYnibSYtGEAw9FKE=;
        b=bwOLfPOCylaCI+OKTkT7RpbmSjwwGzfHmhTnoE8OOlR1g9CK3og15u+nN1oVj9r2dc
         F5MtG4WB2Jl9B9K6ZiRKVDS1twaiqVd8cY8GUrcH6lvmVkzKWEDFQTnrNilAcESfFrcg
         U/UORVOZwM25asGkKdZRaQDtLu5Rr/muKpSyhMC/3DEH2DkzfKjYkY+GITE6TCFyjLPR
         E/h2aou4fylpEDTNd7Bxd1J4aJyegLZdKFTqyIu0v356H9rxs6MtH2dGmnte3PYOxSD1
         hmClFeKMKtge5QTAYiIrnr1OpgM4CYfRNn6sVKHeoAE54+zMzDXCjJvz+D5X65S5Qh4T
         npmw==
X-Gm-Message-State: ANhLgQ3YASFlDH6ricOU0wnEiYtjoT1Yj54z2H8FiYk5TG5GBwNGQg+M
        yNWGNeN3BJ5ND07hX5W6BA==
X-Google-Smtp-Source: ADFU+vvHuG1Q+7bqN43LnZR4hfTQIj8sE/4uXvN+STf+QvB2YqxjAzzHIOIClefMyg4+5nuJtTiiOQ==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr7543466wro.58.1583972527134;
        Wed, 11 Mar 2020 17:22:07 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-15-144.as13285.net. [2.102.15.144])
        by smtp.googlemail.com with ESMTPSA id w9sm35254337wrn.35.2020.03.11.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 17:22:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] backing-dev: refactor wb_congested_put()
Date:   Thu, 12 Mar 2020 00:21:56 +0000
Message-Id: <20200312002156.49023-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312002156.49023-1-jbi.octave@gmail.com>
References: <20200312002156.49023-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wb_congested_put() was written in such a way that made it difficult
	for Sparse tool not to complain
Expanding the function locking block in the if statement improves on
the readability of the code. Rewritting it  comes with one add-on:

It fixes a warning reported by Sparse tool at wb_congested_put()

warning: context imbalance in wb_congested_put() - unexpected unlock

Refactor the function wb_congested_put()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/backing-dev.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 62f05f605fb5..9d47c0b6a42c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -464,18 +464,21 @@ void wb_congested_put(struct bdi_writeback_congested *congested)
 {
 	unsigned long flags;
 
-	if (!refcount_dec_and_lock_irqsave(&congested->refcnt, &cgwb_lock, &flags))
-		return;
-
+	if (!refcount_dec_not_one(&congested->refcnt)) {
+		spin_lock_irqsave(&cgwb_lock, flags);
+		if (!refcount_dec_and_test(&congested->refcnt)) {
+			spin_unlock_irqrestore(&cgwb_lock, flags);
+			return;
+		}
 	/* bdi might already have been destroyed leaving @congested unlinked */
-	if (congested->__bdi) {
-		rb_erase(&congested->rb_node,
-			 &congested->__bdi->cgwb_congested_tree);
-		congested->__bdi = NULL;
+		if (congested->__bdi) {
+			rb_erase(&congested->rb_node,
+				 &congested->__bdi->cgwb_congested_tree);
+			congested->__bdi = NULL;
+		}
+		spin_unlock_irqrestore(&cgwb_lock, flags);
+		kfree(congested);
 	}
-
-	spin_unlock_irqrestore(&cgwb_lock, flags);
-	kfree(congested);
 }
 
 static void cgwb_release_workfn(struct work_struct *work)
-- 
2.24.1

