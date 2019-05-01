Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DB10484
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 06:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfEAEYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 00:24:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38685 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfEAEYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:24:51 -0400
Received: by mail-it1-f193.google.com with SMTP id q19so8386587itk.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=bXPq+uYZBllNp89Ncns5MG2LqYR1C1A1rOSBdvHs+5oJ/NitdfplPmEEINCKRZ8IVi
         gIBbdyBYUBqe2+HAE8HBBXcmvBjJYaz/BxkC8oL9rnCGmXMWdw7NXEqXi6qf+IluO6ns
         eNHqY5GYXs/ppadxm2tK4IL8JIPG6i1MgNT3WGY1TVpqN5BGZlPO9q/sB3mB0Lufw7le
         0C2lQYSwqC5P4v3DH1L8PzCylu+UtduWSdidbtOTuzoj4aK+AWL1Nv0iaJF3Cur6AvFe
         ki0aLVYJMatFVsmsYOz+AwMGF3MImwdhMjhu8nz8RjcQb+YDohdooG9s+Y3gu97bmtxD
         iTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=aNQB0qvtiJDPOekMEIWJdUXL8B2EPHtpWXUL22B7EP0=;
        b=FuVxgsm3OoQ071eeCgXKfbjxk48LA++x2GcqLnF8dosjL5xo8vYdGeKpAhDYd8SHac
         GoeZarIS/LwuOnuiL8JhuvaQDtFxMSFzN8BxJmi41pEvJuAQfXvlkpKlko4kz+TzF8fH
         KmW5YjXycgXIhSdQShqF0Hj9TlCsbXw32WVbLSW6L0YaLnTzBSSnVWPjupRJ/2d4wGdX
         vxz/r6U4ooonIf7XcTHtHILF86+WPFRRvt+bz1/CIoy6jiCIPQRViSVC3fNRcc8Xjw//
         FcyrgbfWlkIVAdYB5BEzX0uRpqfMTHYhx/DUnliw8+hrY1AHFuXja2/60G8gsPNAuiuT
         dZ0w==
X-Gm-Message-State: APjAAAXTqtuv2I+dS94jcLml7I6F1UBvp4mY/uDP9iopGDhV2cqrI/gO
        qljrJpaOap9IEc5NtWT0hRM=
X-Google-Smtp-Source: APXvYqyK6rvKKVkuqt42TqCby4sZA7/wqhNA4UvsSC7/b20zO2sKHdutxxNfyItSxE4ro/U8R07eeg==
X-Received: by 2002:a05:6638:94:: with SMTP id v20mr2781901jao.2.1556684690828;
        Tue, 30 Apr 2019 21:24:50 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id b8sm2569728itb.20.2019.04.30.21.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:24:50 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH 14/18] topology: Create package_cpus sysfs attribute
Date:   Wed,  1 May 2019 00:24:23 -0400
Message-Id: <3ac58ab3d2973b77997c8865cd2e181c6708540a.1556657368.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1556657368.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The existing sysfs cpu/topology/core_siblings (and core_siblings_list)
attributes are documented, implemented, and used by programs to
represent set of logical CPUs sharing the same package.

This makes sense if the next topology level above a core
is always a package.  But on systems where there is a die
topology level between a core and a package, the name
and its definition become inconsistent.

So without changing its function, add a name for this map
that describes what it actually is -- package CPUs --
the set of CPUs that share the same package.

This new name will be immune to changes in topology, since
it describes threads at the current level, not siblings
at a contained level.

Signed-off-by: Len Brown <len.brown@intel.com>
Suggested-by: Brice Goglin <Brice.Goglin@inria.fr>
---
 Documentation/cputopology.txt | 12 ++++++------
 drivers/base/topology.c       |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
index 2ff8a1e9a2db..48af5c290e20 100644
--- a/Documentation/cputopology.txt
+++ b/Documentation/cputopology.txt
@@ -46,15 +46,15 @@ thread_siblings_list:
 	human-readable list of cpuX's hardware threads within the same
 	core as cpuX.
 
-core_siblings:
+package_cpus:
 
-	internal kernel map of cpuX's hardware threads within the same
-	physical_package_id.
+	internal kernel map of the CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings")
 
-core_siblings_list:
+package_cpus_list:
 
-	human-readable list of cpuX's hardware threads within the same
-	physical_package_id.
+	human-readable list of CPUs sharing the same physical_package_id.
+	(deprecated name: "core_siblings_list")
 
 book_siblings:
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 50352cf96f85..dc3c19b482f3 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -57,6 +57,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(package_cpus, core_cpumask);
+static DEVICE_ATTR_RO(package_cpus);
+static DEVICE_ATTR_RO(package_cpus_list);
+
 #ifdef CONFIG_SCHED_BOOK
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
@@ -81,6 +85,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_thread_siblings_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_package_cpus.attr,
+	&dev_attr_package_cpus_list.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
 	&dev_attr_book_siblings.attr,
-- 
2.18.0-rc0

