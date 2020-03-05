Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE330179EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 06:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCEFCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 00:02:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgCEFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:02:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so2137854pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 21:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4y1bjuDihHx2oTrIgnH3W8hlU6GthTh0USQXogLFnA=;
        b=BAwLygGc+cbMJxseyd+EFVvY8q7V30mqYzVTTSkxSv6SEDlPP17rNHZjoHl0VR6psd
         UjgL8sjesWeib2YlBcV2uLrZdJaV/cOZh2X4xhbs5JlKkp6XmFt+N88DnDe106GJX2zp
         l+MTCHbtbt8onH+AZd0ufLRY/z2vOKBZswpck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4y1bjuDihHx2oTrIgnH3W8hlU6GthTh0USQXogLFnA=;
        b=RR/vgoYxfQodC7n07blpMXaC0yWNLIGhgBMZIfWOzXdzdVit2mH7WpuvmhZe+qPnvI
         H68lypvo5kDfrkDX/MhWAS/Rqarg5ngud8XhB8xfLKNafAF966MHhJbHeCUny3k56a1U
         Bz1F+C/6erHg2AXNxzRZquUAI0RumAmVseQlMeSbesD0MzOiYBcDZmMYO0QX2/NaQ358
         Srqrb3IsZv0coePXUDA7FbyflYeVGgiCRH1NPJ2vnjZzBdhDcpvBZ6R/y/fdsAo1Qgbn
         tkTZinuv65vQxl1EgPpq/OgKKO/FBAksv1gVyr/T5C0kiraLUlY2fokZxLFjuWygGwoG
         hL4w==
X-Gm-Message-State: ANhLgQ1E7CrD6L6bocbJl4yTD5LdaZqBqaOiC5BuVTZIaLyLr4weJZcV
        0R79MI/C0XzcOSqn15NyOqN31Q==
X-Google-Smtp-Source: ADFU+vvWx25e9jYZqzCSqaGAkmRaphEj/PgjffJq3MCSsLDQMbV5G1+yLhiRLui6IqbawgQdywROtw==
X-Received: by 2002:a63:441e:: with SMTP id r30mr5741154pga.51.1583384541389;
        Wed, 04 Mar 2020 21:02:21 -0800 (PST)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:e9fe:faad:3d84:58ea])
        by smtp.gmail.com with ESMTPSA id y7sm17820466pfq.15.2020.03.04.21.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 21:02:20 -0800 (PST)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next v5 3/4] bpf, doc: add BPF JIT for RV32G to BPF documentation
Date:   Wed,  4 Mar 2020 21:02:06 -0800
Message-Id: <20200305050207.4159-4-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305050207.4159-1-luke.r.nels@gmail.com>
References: <20200305050207.4159-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update filter.txt and admin-guide to mention the BPF JIT for RV32G.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst | 3 ++-
 Documentation/networking/filter.txt      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 287b98708a40..e043c9213388 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -67,7 +67,8 @@ two flavors of JITs, the newer eBPF JIT currently supported on:
   - sparc64
   - mips64
   - s390x
-  - riscv
+  - riscv64
+  - riscv32
 
 And the older cBPF JIT supported on the following archs:
 
diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index c4a328f2d57a..2f0f8b17dade 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -606,7 +606,7 @@ before a conversion to the new layout is being done behind the scenes!
 
 Currently, the classic BPF format is being used for JITing on most
 32-bit architectures, whereas x86-64, aarch64, s390x, powerpc64,
-sparc64, arm32, riscv (RV64G) perform JIT compilation from eBPF
+sparc64, arm32, riscv64, riscv32 perform JIT compilation from eBPF
 instruction set.
 
 Some core changes of the new internal format:
-- 
2.20.1

