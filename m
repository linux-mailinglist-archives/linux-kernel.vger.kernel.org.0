Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB63D1C949
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfENNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 09:17:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfENNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:17:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so19167914wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NHszGXSdUYSHK5uiVaOzd/y+HHMtNL3fJ2rPoCVo3g=;
        b=VZocPOVESSDEPvFL0dJL+elMQ2Nb5SYlsD4nuQip05q+rekdjt1P9QmQXwQr4020y1
         rfSH/h0zxy11PaBkABxFwEI2S0tHoizmzY/7jXWp9kh39cp01loi74dEMVWnzlpZBiSa
         RcCxGOF4fXk3Lhg/iPBpELisQXpJCLPSodBu8kDIV9JPw1Lx7iyZoTRtahYMrJ1dTI9y
         gx2MDKC+qGVAdAJcwQg+metyZZsuZuBastHWAxF9GtBIb3ehS7uWqY9tdlIOgEQwaV6G
         ZYBfluvCcTFV+6ZOZpuE18DHRciPN5ypgRtqKOjPmzVOUTiw6QBRmB986D2+C5oVvTPv
         +Vuw==
X-Gm-Message-State: APjAAAU74qt6YA8KNWXV/DjOAfFT7E3z7uEXs+mnwJXbz7C3u/mC0Km5
        QDQoZTuEtzg+kGQgSByZLK/wQ75c3ZDMrA==
X-Google-Smtp-Source: APXvYqz90MXu1Y+IegMsTYBwvQ7q04E4Nwy8CUaUfOYUksdQNjQvegVE/S1PVrMeC+cUogaaT3sQLA==
X-Received: by 2002:adf:cd0d:: with SMTP id w13mr21219109wrm.38.1557839822566;
        Tue, 14 May 2019 06:17:02 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o4sm3420247wmc.38.2019.05.14.06.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:17:01 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: [PATCH RFC v2 4/4] mm/ksm: add force merging/unmerging documentation
Date:   Tue, 14 May 2019 15:16:54 +0200
Message-Id: <20190514131654.25463-5-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514131654.25463-1-oleksandr@redhat.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document respective sysfs knob.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 9303786632d1..4302b92910ec 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -78,6 +78,17 @@ KSM daemon sysfs interface
 The KSM daemon is controlled by sysfs files in ``/sys/kernel/mm/ksm/``,
 readable by all but writable only by root:
 
+force_madvise
+        write-only control to force merging/unmerging for specific
+        task.
+
+        To mark the VMAs as mergeable, use:
+        ``echo PID > /sys/kernel/mm/ksm/force_madvise``
+
+        To unmerge all the VMAs, use:
+        ``echo -PID > /sys/kernel/mm/ksm/force_madvise``
+        (note the prepending "minus")
+
 pages_to_scan
         how many pages to scan before ksmd goes to sleep
         e.g. ``echo 100 > /sys/kernel/mm/ksm/pages_to_scan``.
-- 
2.21.0

