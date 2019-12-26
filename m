Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAE12AED2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLZVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 16:19:57 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:42851 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:19:57 -0500
Received: by mail-pl1-f173.google.com with SMTP id p9so10901686plk.9;
        Thu, 26 Dec 2019 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZydGvrZJ5soQdjVtyWBSup80fHqEvz+pQXJo9U+D68=;
        b=SDHhuQQpKJbVXlc0Rqy9JNq14aEeqmzeFEXjQVA3ZvD2o5KXv44ZC8JPsOXN0Xh2D2
         ubb68n7e/rIkmOVSBCCBl5yGjCXqrk9XNo4IdWK8Tz+v4dJzHCcTSFgzq2zryijP5ZHR
         Kto4xagJbDT6RmnabUoI9NTZWzpg03osJJyYIy5uAGJTI70WdNk9I1Q67EbstC/F7KjB
         d1yiCShdRIhOWOlr1DE3iSavFRzYDks+/BGYr+lMp3b3cAjIuUNfEQhFaYmSMiLkZfJY
         47adXVpZWEA+Ia3Xxq1wrgSkg9XKGVxAIVJjO2KO8ZB6jdC0+vbCuXSUtCUgw4j7Vxad
         JcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZydGvrZJ5soQdjVtyWBSup80fHqEvz+pQXJo9U+D68=;
        b=WpHIMmwtxZEjE43ekwWpC1xx7K/QTZvifKCHoZ/Stf1Lwvt6iKvQOXgDLZOvk2VKTD
         Ncfqp36VfKHna4pNhcl9Bv7N+nerKhbGeI+YV6FXHI4HuNzIqX4SEp8qORDjW7/ZzAhi
         IkzHb1rbJ+9aCV1/FGoPuhAr3/d/hnGzwnvIVdfaxiZ8QGY6pWJbi6n+ErFY98OwfBWj
         4pnrb6VkCSW54W0fP+JoAUAQn4aaGAwDANxzCniqXV0TpiewNaI0/FIX9asy3VHwjUk3
         TzRUuZ2p5ohbOimFniU6pWa7G8QCfYpyQumWoQLTo+ndUHGPxRlTP/fNfk2AoH0wkOKk
         /MWw==
X-Gm-Message-State: APjAAAWpposrXj2vJRuy1KGR5o7z6Wf7suPCL8AfUBc/+InLruiihHlu
        Jkg5vParDsHFu3qz3ky9mPrn08AFh8zHgA==
X-Google-Smtp-Source: APXvYqzDdV0v9wFzWnGGJyGBrHWO9iwfcaRWW2+4jjXfBWGMNQnRY93tazrBZ6vNMg5c/ZHINpOoyQ==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr48727838pls.256.1577395196139;
        Thu, 26 Dec 2019 13:19:56 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id b22sm35114380pft.110.2019.12.26.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 13:19:55 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab+samsung@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/5] Documentation: nfs: Convert a few documents to RST and move them to admin-guide
Date:   Thu, 26 Dec 2019 18:19:42 -0300
Message-Id: <cover.1577394517.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

This series converts a few docs in Documentation/filesystems/nfs to RST.
The docs were also moved into admin-guide because they contain information
that might be useful for system administrators

Most changes are related to aesthetics and presentation, i.e. the content
itself remains mostly untouched. The use of markup was limited in order
not to negatively impact the plain-text reading experience.

Daniel W. S. Almeida (5):
  Documentation: convert nfs.txt to ReST
  Documentation: nfsroot.txt: convert to ReST
  Documentation: nfs-rdma: convert to ReST
  Documentation: convert nfsd-admin-interfaces to ReST
  Documentation: nfs: idmapper: convert to ReST

 Documentation/admin-guide/index.rst           |   1 +
 Documentation/admin-guide/nfs/index.rst       |  13 +
 .../nfs/nfs-client.rst}                       |  91 +++---
 .../nfs/nfs-idmapper.rst}                     |  31 +-
 Documentation/admin-guide/nfs/nfs-rdma.rst    | 290 ++++++++++++++++++
 .../nfs/nfsd-admin-interfaces.rst}            |  19 +-
 .../nfs/nfsroot.rst}                          | 140 +++++----
 Documentation/filesystems/nfs/nfs-rdma.txt    | 274 -----------------
 8 files changed, 453 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/admin-guide/nfs/index.rst
 rename Documentation/{filesystems/nfs/nfs.txt => admin-guide/nfs/nfs-client.rst} (72%)
 rename Documentation/{filesystems/nfs/idmapper.txt => admin-guide/nfs/nfs-idmapper.rst} (81%)
 create mode 100644 Documentation/admin-guide/nfs/nfs-rdma.rst
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)
 rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (83%)
 delete mode 100644 Documentation/filesystems/nfs/nfs-rdma.txt

-- 
2.24.1

