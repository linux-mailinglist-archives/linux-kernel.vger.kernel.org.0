Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD39012CC64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 05:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfL3E4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 23:56:47 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:51871 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfL3E4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 23:56:46 -0500
Received: by mail-pj1-f54.google.com with SMTP id j11so7335234pjs.1;
        Sun, 29 Dec 2019 20:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHonOFx9xvoaxw9VR4rjUajN0rQFPRRu1qbwdwLtluM=;
        b=I26Kt6BXe/bs3RKdS7TvuPHoQLPP36DaaylbkeUGm07p/tsj6+xrKZ8EcqzLlX8S3T
         XHtvjSnrV1miNibMIgdxH39rQN0WDy6XpwrnJnjcPStIayC3XCf/8E+ga0u7hwPvW86/
         FoHQPUjKV9xrDq1ScZw/7f0TAV7x8GMg7GirZxEfZIgjlGGmIXvhUoPXM94Ao/lEhU1n
         5lRRonDDEpCUJOZ9JJJizl1fiLsrQZLqLOHkZxLG3DRb/+LLxC7SG07jK/UKi6/Al+To
         PjHHtBeWt3ycq3MQsVRyf1TDmzab7dXLHw3SIEm4dk8NdV3qZdPXb73lFb+dKQdv+k2C
         ESNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHonOFx9xvoaxw9VR4rjUajN0rQFPRRu1qbwdwLtluM=;
        b=CosqAuiyT77rt1f0g+OGtvzcDdC/Rhr2er8oQdheIXl5m6N36c765+uwlZhlRl30Ys
         //h6cwEuJOY5qvlU95Va7D2BoX0fiDHw6/R+Gj6Zeqj7FR7kql2JL/XAR4++L8VwRq4/
         D3LXFPsx94LjUwTZW5u5CfNQTzxt4yXxdZojVymqk77YESO7hg2HBXQebTgcYGIrls67
         NHcayvzpZiWC4Zh2tWvDNi0x1CeOSKfd1IvhXRmLnNPcfH6osyrGDVT/Mr56zfjKAG9p
         c2VKHLCtCZuKapv7MaNiTwXPPESF4OejA7PmDeN3uIDQe757l2bj2mBS66KS3g3z0xaN
         D2bA==
X-Gm-Message-State: APjAAAW6ky21n/v0R4rCZLU2ReuQr7xT0c0JAYSaAjyQXJ1x+a48f6n3
        tq3vfn+i0FfSzlcnWrC5WN0=
X-Google-Smtp-Source: APXvYqw1++iHS5nGi4FAQv302tgaxvpsufWb8c0MrnMXtzyVHTs/XWuByUtQY2feaQbTHjYI56VjUg==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr43104676pjb.10.1577681805492;
        Sun, 29 Dec 2019 20:56:45 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:da15:c0bd:33c1:e2ad])
        by smtp.gmail.com with ESMTPSA id b1sm22373189pjw.4.2019.12.29.20.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 20:56:45 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 8/8] Documentation: nfs: fault_injection: convert to ReST
Date:   Mon, 30 Dec 2019 01:56:02 -0300
Message-Id: <5f2dfdb34ef391d63e126867937ae0216c31cf2e.1577681164.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1577681164.git.dwlsalmeida@gmail.com>
References: <cover.1577681164.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert fault_injection.txt to ReST and move it to admin-guide.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 .../nfs/fault_injection.rst}                                 | 5 +++--
 Documentation/admin-guide/nfs/index.rst                      | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)

diff --git a/Documentation/filesystems/nfs/fault_injection.txt b/Documentation/admin-guide/nfs/fault_injection.rst
similarity index 98%
rename from Documentation/filesystems/nfs/fault_injection.txt
rename to Documentation/admin-guide/nfs/fault_injection.rst
index f3a5b0a8ac05..eb029c0c15ce 100644
--- a/Documentation/filesystems/nfs/fault_injection.txt
+++ b/Documentation/admin-guide/nfs/fault_injection.rst
@@ -1,6 +1,7 @@
+===================
+NFS Fault Injection
+===================
 
-Fault Injection
-===============
 Fault injection is a method for forcing errors that may not normally occur, or
 may be difficult to reproduce.  Forcing these errors in a controlled environment
 can help the developer find and fix bugs before their code is shipped in a
diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index c96e93b61744..410b8ccad11b 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -12,4 +12,5 @@ NFS
     nfs-idmapper
     pnfs-block-server
     pnfs-scsi-server
+    fault_injection
 
-- 
2.24.1

