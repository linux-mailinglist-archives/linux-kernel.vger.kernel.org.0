Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A99113B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfEBHJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 03:09:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38448 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfEBHJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:09:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so606826pla.5;
        Thu, 02 May 2019 00:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=YLq7hFFY8IY1CJitrOlj+XcEZ39UvarzKyemjjnbEVgtGU3ANtBrFn9EFWd41pjayM
         9ARXHWpI/hovyjS/l6i+Kz6KQmvZ233Vtpe4o7Z2j79ZraUbCYNPEx5wXXzSyJkYo+qW
         p/85INvNvAVXqj1Em/bKZ3JC0DaZCsq/ZXDAPv++ridmCcI5yRoJNPA+vZrieVlCn44S
         ocPjF4fqmeRyMgfl+96MkhaFHeKyUedpXOjG6PHXc0Nc/lfSKFEKMqlZ1u5Dbv776OFS
         Dt7kgy8BhdbSECqbylY8ZrBNoXHv1Xz/xk79B9Ue1e+KjcPZHEsZZYcr9dTwlAqzEhpE
         thOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQAGErRRsp1BGyaJxVL4RRJn7QR6RpeFY3r/P7e2cqs=;
        b=BZ9Rmpw6GusfMbgZf10agk/xbTSmkTRMmVlJwp/ZQg9NYZfhn0goA1djg0Jco919AO
         SIkF7HnU4hYBE6XeW90Uj8WltOiHbW2rV9beZSgvQ++B2BtB+O+Mn31ab75/5qehYtTy
         l3STIKmjyCp7LLgZaHjz+ZC7TEpTQM36zq/gcy/Sf03iDi67raZtDUYpurfhA19w2RuK
         uwupEmYeoXDrqsmB6de73RlAS/YTXiuA0MbbWOMbxNKOuOhD7SByM2A0yOqqepZKL2tj
         11WOBBoAyHfoByy9wE3AEKF5XFQ6sGAlLnDX0nD2twNFunBtDxyPXGzYLYO6Ml+0o7dH
         gP8A==
X-Gm-Message-State: APjAAAWiTbJeSl9SKZvjH8rxexjDKfNLdQXv0htkH5ZeOsceVa281CXa
        PWxeCnTxSBWc5l7pfUAv+bo=
X-Google-Smtp-Source: APXvYqw6DrfzXK6hl4Vg9uGn3FyrDJE2Enw7XT4/uXyVzh8gmDvWMm8wirOEpAf24IJQluncKx7siQ==
X-Received: by 2002:a17:902:820c:: with SMTP id x12mr2011786pln.199.1556780981526;
        Thu, 02 May 2019 00:09:41 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:09:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 01/27] Documentation: add Linux x86 docs to Sphinx TOC tree
Date:   Thu,  2 May 2019 15:06:07 +0800
Message-Id: <20190502070633.9809-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a index.rst for x86 support. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst     | 1 +
 Documentation/x86/index.rst | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/x86/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 80a421cb935e..d65dd4934a1a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,7 @@ implementation.
 .. toctree::
    :maxdepth: 2
 
+   x86/index
    sh/index
 
 Filesystem Documentation
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
new file mode 100644
index 000000000000..9f34545a9c52
--- /dev/null
+++ b/Documentation/x86/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+x86-specific Documentation
+==========================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
-- 
2.20.1

