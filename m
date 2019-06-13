Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEA944E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 23:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfFMVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 17:12:47 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:48110 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729897AbfFMVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:12:47 -0400
Received: by mail-oi1-f202.google.com with SMTP id s197so67194oih.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F73bmQBhyaZz/5F17E2exd9oLZdsZmUd/nxm20yXKlg=;
        b=Hij3glu7oVn6Nsh5fxHUC/N4NPmbOfTsM/VYNb2Mvft11iu54EgM7k60O66qA27nVh
         ISUgkj8FrqcrAF2PUFq2tFhX/5Im0sDyDJltDfHuh1oETDJrPJp4wHPQKmUpt2ZqARB7
         PHjkdJ1wYYh1iymPNM/P/tai3tBrTM04A77wfGwUfOLEs0wmbm4gz+hKFEuvSiPWrtaw
         m9sVU/lIU0IDaLmnlcHmmbowws2YSoZHBk08hs2GRZSxkoDBqAt/wjDPV6dwRIjwj0UN
         rvHmRtjI1HWDfikevKttQqWLwmxKGsVa1OCqsOen0tnvhsylB7T8xYvwYzycgqBKoOP0
         3jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F73bmQBhyaZz/5F17E2exd9oLZdsZmUd/nxm20yXKlg=;
        b=MpFXNrwoVQ6QTJFMunAyr9cgzZVU8evKPKKuKkY+FNRlcjqZXErcnbQu2U/LTjllc7
         s0c6r7TFEr28LvppjV9EAARc+3umuIRJafZnNimc4Qcy43448qxcA48USHDajGBTel64
         drnL/c96TmNA4njXTc0uyMTt/QBywPGu/TgiEF+8WSWWxYrBfkdxzjnfXG1qCK0UBZXr
         SWQfccVDadprCJb4o96Y1qYSZl8J7ppqecCPK4QvXYkr9+olbcZjTJbxG4gmK23NNWQ9
         0ATAlO435ZJHNkgNKV4FafIFPARG6+3lyda2e5nGJMZsqmkaW5a4U8G/6tuOzKuT6x02
         OxpA==
X-Gm-Message-State: APjAAAWLWdlSbpr/Bv6FDtYhA2Mdmy37RKIW6IM5fNLN7JtrdZFyBNhl
        7Ghl4OREWicsXzfRLSSOqrEfBPEBVw==
X-Google-Smtp-Source: APXvYqxfw1+oe9SB9sZWxTOs5duv5rsHABMQo1lxHtq8x0EYHKRS9MoXIIXHqukewEL4qOtgROYiw+b2AA==
X-Received: by 2002:a9d:222c:: with SMTP id o41mr43289722ota.19.1560460366502;
 Thu, 13 Jun 2019 14:12:46 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:12:28 -0700
Message-Id: <20190613211228.34092-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
From:   Nathan Huckleberry <nhuck@google.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a negative
signed value is undefined [-Wshift-negative-value] / (ptat[0] - ptat[2])) +
FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~ drivers/thermal/rcar_gen3_thermal.c:126:29
note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x) <<
FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18: warning:
shifting a negative signed value is undefined [-Wshift-negative-value]
tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~

Upon further investigating it looks like there is no real reason for
TJ_3 to be -41. Usages subtract -41, code would be cleaner to just add.

Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of Tj_1")
Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/531
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index a56463308694..f4b4558c08e9 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -131,7 +131,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
 
 /* no idea where these constants come from */
-#define TJ_3 -41
+#define TJ_3 41
 
 static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
 					 int *ptat, const int *thcode,
@@ -144,11 +144,11 @@ static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
 	tsc->tj_t = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
+		     / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
 
 	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
-				 tsc->tj_t - FIXPT_INT(TJ_3));
-	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
+				 tsc->tj_t + FIXPT_INT(TJ_3));
+	tsc->coef.b1 = FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
 
 	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
 				 tsc->tj_t - FIXPT_INT(ths_tj_1));
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

