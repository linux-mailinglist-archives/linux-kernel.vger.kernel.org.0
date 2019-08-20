Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3996684
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfHTQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 12:37:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38671 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:37:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so3224589wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E4X7QCNLqGFBsy/7pYjpRVoBo5sZi0bTAtJeoQQ6ohc=;
        b=RHXI2pd8xSNAOhiPMeC+zKnJLolrcnrYEE8IdqtrRtZm+LTWR2jIdytsHYP772tydL
         86yw3Dw52LEBYnxuDoSDGwXVa9yxtLMuY9557kTc1/fD2uS5q1/wFfWLoq/phfVdu/Wl
         IGVblh7ZhuU9PSfx2o6iOygsL3xE8Pf8SDliWe6ptmDUkDyIYJQaTT8fiHEqDRRT/4+x
         LG4pf1Z3b/SmsVeMVQ/ZXnz4S51tmOaNlcWBV4Efw8uw9a7nd4UOaI6uDsUo1HEYbAsZ
         gVfsvmRP7I9q+rmxdUuKTMYreWyIhUF1B94aW85wc6ejCH41MJqTCuX1xed1W9AZPRJv
         o5xw==
X-Gm-Message-State: APjAAAWSfdm/wXPT67OvvWRFXq7TaU6obSyv0ad1c/RoMTJ9pcHAgAEP
        8XUDaNdU92M9DmtC6VxdPWg=
X-Google-Smtp-Source: APXvYqyWdL5QMRDrlWABWdxtx+qi5mJSVMhKc+4wusrmLOkgTE8w+/nuZlj5Jc1f8al4Vo4HPQPOEQ==
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr858820wmt.147.1566319051721;
        Tue, 20 Aug 2019 09:37:31 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n14sm58485385wra.75.2019.08.20.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 09:37:31 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH] mm/balloon_compaction: suppress allocation warnings
Date:   Tue, 20 Aug 2019 02:16:46 -0700
Message-Id: <20190820091646.29642-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to print warnings when balloon page allocation fails,
as they are expected and can be handled gracefully.  Since VMware
balloon now uses balloon-compaction infrastructure, and suppressed these
warnings before, it is also beneficial to suppress these warnings to
keep the same behavior that the balloon had before.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/balloon_compaction.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 798275a51887..26de020aae7b 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -124,7 +124,8 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 struct page *balloon_page_alloc(void)
 {
 	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY);
+				       __GFP_NOMEMALLOC | __GFP_NORETRY |
+				       __GFP_NOWARN);
 	return page;
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
-- 
2.19.1

