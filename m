Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E1017D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfEHPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 11:24:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34888 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfEHPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id t87so10097183pfa.2;
        Wed, 08 May 2019 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=DDEgfy9Y7g44NIMh5+M+07BsXJe3HWeRWv6k7nkm3XMvraF0qD1dHX7w2GnTYpntvg
         bcm0drJh71xcBYc2XMst7laIsj1VNcmtlure5/ir83o34zXE70arsKxkqd6YC8gNRzI2
         yatZSy/v1ZZUbaobTNvS7VjFpdIyUCN2fY7Nq5WQMs0tjSlPPKXJlRXoO8n3Bapmvl3d
         1CxPvR4DfwWKm/rfRDTJl10zMwYYmqpC2/G+RQwyA5sotEt3yywk2/dgadU9DOueg+Yy
         zIX2OGj0KfCjog3GwT2Vw83jgqEtmP9aSKVtw0TlrTbZdkjE95GQwvAboqjU0YmJE/HK
         Q5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PKBU7pt8rvrhzoOSyv05XPu1ZaQkpgjUMyroog+NNeg=;
        b=WM8hOw47QDDil6k9QlwXt2AfqixNe/GRBukiIq8BkXDxRG9tuuVihtfF8JzRzA8ypQ
         63xyHtXTF7Z++FC3peB20D8iz/VHTUVK7KF56kf28jzr7/A+cVEV4NkDYK+ARjxV2+F8
         pUcOW1EtQvoI7dYtYw69rAYEkytr/1l2UwqJvHF2BkjdJ6OmAxvajCo4ECzM0dhq9wt1
         xRvPVaz09iRuI2WerU+QkRnn6JySQl+TcjONj5zPDhZCcV9iWTe9awzjHQCaNmaGaVAX
         KrfqSeLJu1C/Hst7UZoeUWGjKpbDHmUhlJPxeiaCrTkPIqjaN6sg4br72nIRt41eNKce
         9yqw==
X-Gm-Message-State: APjAAAWlHGjHRkajU52kywKxty7ZyMHI/wcgJE85vmPS+5d6VNXJo0DC
        wWpvYZ8rZiY0SgMmnfscma4=
X-Google-Smtp-Source: APXvYqzkDr9YTACDMbfvSyci3SM2fAMXlWQXDJ4OnY0AqZ2ubwrNMdIeGvG4CHbRjEjzNg3ZVrjNWA==
X-Received: by 2002:a65:6656:: with SMTP id z22mr47484808pgv.333.1557329086476;
        Wed, 08 May 2019 08:24:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 26/27] Documentation: x86: convert x86_64/cpu-hotplug-spec to reST
Date:   Wed,  8 May 2019 23:21:40 +0800
Message-Id: <20190508152141.8740-27-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst}    | 5 ++++-
 Documentation/x86/x86_64/index.rst                           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)
 rename Documentation/x86/x86_64/{cpu-hotplug-spec => cpu-hotplug-spec.rst} (88%)

diff --git a/Documentation/x86/x86_64/cpu-hotplug-spec b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
similarity index 88%
rename from Documentation/x86/x86_64/cpu-hotplug-spec
rename to Documentation/x86/x86_64/cpu-hotplug-spec.rst
index 3c23e0587db3..8d1c91f0c880 100644
--- a/Documentation/x86/x86_64/cpu-hotplug-spec
+++ b/Documentation/x86/x86_64/cpu-hotplug-spec.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
 Firmware support for CPU hotplug under Linux/x86-64
----------------------------------------------------
+===================================================
 
 Linux/x86-64 supports CPU hotplug now. For various reasons Linux wants to
 know in advance of boot time the maximum number of CPUs that could be plugged
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index e2a324cde671..c04b6eab3c76 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -12,3 +12,4 @@ x86_64 Support
    mm
    5level-paging
    fake-numa-for-cpusets
+   cpu-hotplug-spec
-- 
2.20.1

