Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B581B2237C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfERMYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 May 2019 08:24:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44312 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729805AbfERMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 08:24:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so4558020pgv.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0I8XY/qdfaKqcITM2R1tleqMnQJjh74m0Ur1DIN+avc=;
        b=ekeWfcFGN9cG50a8opLLcLEwfo6hXB0u1DaDXFlSbHNCpCuge1FLMkvaZQlUZQwx6O
         hN9goCtF9sb6vvzGm2pyDL9LMNJGOk8nsHdKCCRd+OEd7Ic5VmhC5KVQ9boA0kInX/lC
         kdtWMnvqf4NCrXm+OgFpe7VmTt/+PKDuUpFSqb9n+jKltgE5PEn/U/sjf8TUmHdWQFAb
         9gtTym445Gm3CiH0lp91Yfs9v0Khr+t87/Iz2rboxS9aAj/EP6FJjqKxbRb1tY2YWIOG
         rwTrWxCnTU5TWGRdIelH2/7eVS5TBd1gtpIle8P7IFcyxJPhfjTyQtz/qFuDVYZ6YaHw
         9MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0I8XY/qdfaKqcITM2R1tleqMnQJjh74m0Ur1DIN+avc=;
        b=pHxKhfrJnMT5pLuVUV2ZesjbEpeB294dEJLrj68EtPVNow3JTcW7ofnLtaCGvlM4TW
         Ujdxdi/16KBdvzbVtAF8x67fmAoHdM00kO59aauD/VS5jCMBz651hoXCnk1HcenUsPOr
         oKpGoew8h2kzAtPO7Cd0C8IsIHRSDomxsqdfclKpA5RK+TJvawv/T/aJaJh87l1HKaR4
         VxQ89FixPYXbkWC5H/rvxvIb3AspYHCCfRnEOth7BR4491HuSPYNp54kIjAL6ApKucUr
         OEeMzO0ViJyUntqCebxkXrg7/AqMesOOI2ukdbGF62copZrhzxroJvP6a4QAgU2WgOfK
         lklg==
X-Gm-Message-State: APjAAAW4KApdaFdHb6xwHYL5WuGwLGO/9E42G+nhUSs0TZBDdmE5StUv
        MRPPi749Oj7bDeudTOWF4Bw=
X-Google-Smtp-Source: APXvYqzA1CmWgnrOiS1klomXWXDdakgmWR+A8VX3AewSdTkghup0esNpA3KsoXq/v3q58UMhpZrTQA==
X-Received: by 2002:a63:ee0a:: with SMTP id e10mr49123714pgi.28.1558182246475;
        Sat, 18 May 2019 05:24:06 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id u134sm18266471pfc.61.2019.05.18.05.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 05:24:05 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     lenb@kernel.org
Cc:     sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] sfi: fix typos in code comments
Date:   Sat, 18 May 2019 20:23:12 +0800
Message-Id: <20190518122312.19988-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix lengh to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 drivers/sfi/sfi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sfi/sfi_core.c b/drivers/sfi/sfi_core.c
index a5136901dd8a..b184c541cfd0 100644
--- a/drivers/sfi/sfi_core.c
+++ b/drivers/sfi/sfi_core.c
@@ -129,7 +129,7 @@ static void sfi_print_table_header(unsigned long long pa,
 
 /*
  * sfi_verify_table()
- * Sanity check table lengh, calculate checksum
+ * Sanity check table length, calculate checksum
  */
 static int sfi_verify_table(struct sfi_table_header *table)
 {
-- 
2.18.0

