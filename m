Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA584131896
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAFTTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:19:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33370 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAFTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so12582650wmd.0;
        Mon, 06 Jan 2020 11:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1UZd588KnmQmUzBTD4SwiJjj/Xb17f1tveA2IC9y3s=;
        b=rHcMseXdgemDq5RIpHFgGNtskq+QGknOrn2EKwdiKU5N4QMh6K9MNxBZVaWM+bAVMp
         vqZWeo3d2oTfQ5gOEw1BRW+wg+hT1Y2+56VDSoahfZXXKznL0p3XAfK5ozMJi4GaTp4A
         xI8Uv5uOneECthoZMEcZ9Bc56IeQwaqYRA37bTZ4fD9Co7dkoD6NrSTw/S10IzRC1g6B
         RBUC3aA3d9dFqm+X3Fii3nt9WKv+Jh1QE2DoJiADMvNAccRJnPSiPMmaZf+LAz5FPQyD
         ETwPI74JacRj/Wl6FlOlHCXPltvwDe/DDHBkqrKi4IedWuiqmWArlkESQYQzW0MAk/qP
         FkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1UZd588KnmQmUzBTD4SwiJjj/Xb17f1tveA2IC9y3s=;
        b=N0NC+tzpvi/JVIJM/V11Qkrq5YJYP0U+3hrEegdVsH6eoHctdI4uGC9HKL/az2+hlt
         pGd9IfTfNCcTfSEaEtenqBcqCVX/f3HsVUq0IagrWlsrYyeTHfW2pHzss2lH7OFhaToS
         i7WRy+nn0MmV9tT4Supp0SjykQLMieXov6gCFmC3pTEZ1hHMwdsD0CM50ZowmH5P5PlJ
         PfSj/yLTkb5yMUfIA21+MJ7wJkEaM3BzH5E66oVPJqZmuj/slXr7jRpC8WVZSjAh+AX+
         jLMO+IyshIm7w+5se75SgaD9NHFABnfCbdWtDPVmzsPqUGGOdtapIkj4kN8LLoiHsvlG
         zIhg==
X-Gm-Message-State: APjAAAVLj+gBb80xNblqLgw/dzq0mvOEzvsu9avb9gXkR2wbw/wbgE37
        RCod1qD7rODZ+O73eD6cpsY=
X-Google-Smtp-Source: APXvYqx2+ofouotFGbJU0ynzqAg80kzheQxm9LAyM0HVfxEGL20L6qqBA8YW+GqfGEkU7fVOzlE8iQ==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr34748313wmf.133.1578338357027;
        Mon, 06 Jan 2020 11:19:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id o4sm72041756wrx.25.2020.01.06.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:16 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     paulmck@kernel.org
Cc:     corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2 6/7] doc/RCU/rcu: Use https instead of http if possible
Date:   Mon,  6 Jan 2020 20:18:51 +0100
Message-Id: <20200106191852.22973-7-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/RCU/rcu.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 2a830c51477e..0e03c6ef3147 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -79,7 +79,7 @@ Frequently Asked Questions
   Of these, one was allowed to lapse by the assignee, and the
   others have been contributed to the Linux kernel under GPL.
   There are now also LGPL implementations of user-level RCU
-  available (http://liburcu.org/).
+  available (https://liburcu.org/).
 
 - I hear that RCU needs work in order to support realtime kernels?
 
-- 
2.17.1

