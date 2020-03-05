Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2817A747
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 09:21:27 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:33808 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:21:27 -0500
Received: by mail-wm1-f74.google.com with SMTP id y18so2934050wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KkLXOOSG3EccFvXnveAsAjlCd4Cuj/e0jkzvyAbgB9g=;
        b=JAEu655oVlP803DUPmFEFcJtMF7GKi5Pm8Xu3AvJKPaTPuv327j4Lf+gB68JWk4HMl
         B3hwPYZscDeQERssWDU8vSj7Q9yHTc7PBHYpnN8pIMbugNaNo/HqWTbRXUQYGjw3gs6g
         RHuaQWMJJQ4oLChBSxN5avIbljDKL5a4v+ac/QVRlPkHN9DznJq0WUGnxpWzHQjEEfq4
         GRED7ydakxpgmyx+Guvg5RiiRbKa74Xh5waQXMTwloEFhoUz+QL0AhgXCJLoyYq89Pef
         HkIm0IK+TKicJOqAxd/y/P+3dVaYAuoUMcPnzahdAwY9fvhkfmzpYXuEpxdLzw8l5bwm
         qCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KkLXOOSG3EccFvXnveAsAjlCd4Cuj/e0jkzvyAbgB9g=;
        b=QsKTHdtPl/X29BNjeKiAUKDfMxU2ZBrz5Ed8XSh1EyGKxv8WNZPsm9AS6RybAr+EbU
         c+NEQ5PUp1xS3x6JmSOoJ3qDUXwNuUxRKo4O2aPq2NXuxG985DI46Zo4brFN15FzLHxj
         acmCnh9B2MuglUjy6hvOZCBYDP77x4hDGDi4KL67HW+q/wj0kulkqa++ABruLHAfFXTA
         T8ymLuMpEvIVSCPMAAF/ITYDo5NnRZS3WsG0/2vhd6bUAP+wgIfO8UGX/tUqJxQGEpxI
         DHS8SqHZLq/5Cun6VCfAtAXjA1Y6pTH4R4jn0sHzCVjjWSW2+m9uG4VmVcZBKFcjJylu
         XjNw==
X-Gm-Message-State: ANhLgQ3cluc8Sn6x3wLgrmJ7J0CPfhscQZNSvrYBIbRowmBXFbEMwg/g
        6NkIyuOvfSiHFc0oJZ6E81KBoM++Pw==
X-Google-Smtp-Source: ADFU+vsojjuV2Y3WrRp0OMv8B+DtoxHhJ5q8hgHCEutNmwosAt9lgZxbEoh1Igdb87PKMCkR88PhAWtEjA==
X-Received: by 2002:adf:e742:: with SMTP id c2mr10459658wrn.262.1583418079894;
 Thu, 05 Mar 2020 06:21:19 -0800 (PST)
Date:   Thu,  5 Mar 2020 15:21:07 +0100
Message-Id: <20200305142109.50945-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/3] kcsan: Fix a typo in a comment
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

s/slots slots/slots/

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
[elver: commit message]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index eb30ecdc8c009..ee8200835b607 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -45,7 +45,7 @@ static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
 };
 
 /*
- * Helper macros to index into adjacent slots slots, starting from address slot
+ * Helper macros to index into adjacent slots, starting from address slot
  * itself, followed by the right and left slots.
  *
  * The purpose is 2-fold:
-- 
2.25.0.265.gbab2e86ba0-goog

