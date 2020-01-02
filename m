Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4394C12F1C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 00:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgABXTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 18:19:51 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47167 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgABXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:19:51 -0500
Received: by mail-vk1-f201.google.com with SMTP id n9so16697601vkc.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 15:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kVgpbfrdFyyzSYGGFbgXSziUKzTWcn4XrnhMtwS4vPA=;
        b=naNXRzqP4eq5jR2xonGKtj51+vylv6Yying5ZawbfOW3zs+5KFwQXlWSsu45RITUOr
         hxF65GnQA5prSB4shmGn8eypDxfWnMtXSpfnY7fq/YTHasOG5rcp1pZvHgFp9kyZePW9
         XjnC2fB4OhAoqmbqMi6hxzKPF+LjhZ6UkHEFVI5TDPzeUnC/63LjlGVH5QOijFDuUuDQ
         eZ8UOGuj1z4gd/05QxPOz1q0bXQYYlLr4S5q86VzpSKjPEdIBX3xj+B2fBmL22HeKoKw
         V+lzL5DPvlv3gmHuFBWN6vLdTypMG7l9/YB4NPXEecVFNzHcK++BQa24wenyni3CcxCw
         QxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kVgpbfrdFyyzSYGGFbgXSziUKzTWcn4XrnhMtwS4vPA=;
        b=hFKDmhQtxDPw9JLAw9zO0jBmUkUzyaMr6Oy1XTUPk62219JMTh6ryqV82DbqkcmA64
         6OFFIso9tglaT/7nPOxkaneh+JGPSkfPuLwVJbyelKkBYUhTAlieUVU2YudGK7gtONFI
         ryRf053GQML564ZLnSU+cCMCL1t47MFnbNI/kd/UaXEirPxK5FTZVZcsGrvXxRxBf/DG
         tZQpQ46OokqOKJBrtKdks1uX+8di6WGKQ0jhVK2zsUKlPHH+kGcy57Y7RYONSPIQVOeK
         99qvpUpNPQWFoSSmh/8tS6cKDTS67pKsYzpjdKLojn7uD47dlAZ0fKdie/pVYsxcovXa
         pHQQ==
X-Gm-Message-State: APjAAAWpnF2/XqdqHjXBzbz8ZbETMN6lfrET7fRsJunNNXZDNtIXwwWF
        WXOE+uFWKVAb4gQ2y1vxLs3RFh2PSLlGkno=
X-Google-Smtp-Source: APXvYqxa6DqUBLbiprpmN9WvlFsjMhuvZ5hJC9bKtp8oHiV7FMhRzq9iAsR99Wzf38lUxiphVOaeWsgBVWL4+rk=
X-Received: by 2002:ab0:710c:: with SMTP id x12mr46193205uan.81.1578007188489;
 Thu, 02 Jan 2020 15:19:48 -0800 (PST)
Date:   Thu,  2 Jan 2020 15:19:39 -0800
In-Reply-To: <20200102231940.202896-1-semenzato@google.com>
Message-Id: <20200102231940.202896-2-semenzato@google.com>
Mime-Version: 1.0
References: <20200102231940.202896-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 1/2] Documentation: clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        elliott@hpe.com, Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entering hibernation (suspend-to-disk) will fail if the kernel
cannot allocate enough memory to create a snapshot of all pages
in use; i.e., if memory in use is over 1/2 of total RAM.  This
patch makes this limitation clearer in the documentation.  Without
it, users may assume that hibernation can replace suspend-to-RAM
when in fact its functionality is more limited.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index cd3a28cb81f4..a2d5632b7856 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -112,7 +112,9 @@ Hibernation
 This state (also referred to as Suspend-to-Disk or STD) offers the greatest
 energy savings and can be used even in the absence of low-level platform support
 for system suspend.  However, it requires some low-level code for resuming the
-system to be present for the underlying CPU architecture.
+system to be present for the underlying CPU architecture.  Additionally, the
+current implementation can enter the hibernation state only when memory
+usage is sufficiently low (see "Limitations" below).
 
 Hibernation is significantly different from any of the system suspend variants.
 It takes three system state changes to put it into hibernation and two system
@@ -149,6 +151,14 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
 configuration option is set.  However, this option can only be set if support
 for the given CPU architecture includes the low-level code for system resume.
 
+Limitations of Hibernation
+==========================
+
+When entering hibernation, the kernel tries to allocate a chunk of memory large
+enough to contain a copy of all pages in use, to use it for the system
+snapshot.  If the allocation fails, the system cannot hibernate and the
+operation fails with ENOMEM.  This will happen, for instance, when the total
+amount of anonymous pages (process data) exceeds 1/2 of total RAM.
 
 Basic ``sysfs`` Interfaces for System Suspend and Hibernation
 =============================================================
-- 
2.24.1.735.g03f4e72817-goog

