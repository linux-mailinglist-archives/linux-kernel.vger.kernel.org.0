Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF4179B91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgCDWOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 17:14:24 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41017 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388508AbgCDWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:23 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so4197259ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slmOLpdIbjI5QyAjKPc7cej/Tzyq5DfvzSm4Ztafae8=;
        b=ecN/elXI6djHnjKOjuizUlbuZJhSwPC5OCKNCufxl/wtlZb8szUY5hv3RZbtDfuyut
         M4EOscKs55/2R2aMEu38z9NkZUDXkprSPuyVva6hc/Fqv2sJKhmgxPzHwYyLCNAQ4Aut
         H5ULfGaZT2Xdfudf09SNt7vsZBWjk9AK8Zk38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slmOLpdIbjI5QyAjKPc7cej/Tzyq5DfvzSm4Ztafae8=;
        b=L0DqWk3MxA7Y7Rjw30LSWIddSWCVI31XD1GidPAQMeFx9So+g2ktP1KPfUp9t/k7ET
         1VLZK446EQjvoiJ1IW38CMM8qWIgjhlrgYjCCstXX5nXM0x6yUIfkZUYOIoE2mwGDn3i
         3r20xiTwUhf/Yl+8poSpMiVDr8ZmV/qAYJWrBBTxXKJ0rwHPPW382feeRHFXxO2cOlcw
         yfVIVdqW01tV4CUmDQXApM55OkTcN1acC5vZkg7Bxcjxa3Cw/4xJLBeIOKj/lfUn0HzJ
         zV9EP25Z3q+4s20AJLheS30f3nM8YqgDqGGkGM+L4H76htjKCPC6WKVLNAEVRHwKCtIM
         iLBQ==
X-Gm-Message-State: ANhLgQ1J9V/QTgE3XE8upxSk6uT6D21FBA0QlMQxNfDC+hLwSD07wzMu
        sXCLreQar4oMdcSJWDRN9+eipQ==
X-Google-Smtp-Source: ADFU+vvtttXCtOoapb1Bl0NcpOGalK4Y39X0zQcS/sDoJw9QE2E2iSZda+0cyiHM4ZSp4ozHIzE72w==
X-Received: by 2002:a6b:9245:: with SMTP id u66mr3907500iod.110.1583360062502;
        Wed, 04 Mar 2020 14:14:22 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:22 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests: android: ion: Fix ionmap_test compile error
Date:   Wed,  4 Mar 2020 15:13:34 -0700
Message-Id: <bc4a7fd417e1f76c3dfba387962d5ed74464e9d8.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ionmap_test compile rule is missing ipcsocket.c dependency. Add it to
fix the following compile errors:

..android/ion/ionutils.c:221: undefined reference to `sendtosocket'
..android/ion/ionutils.c:243: undefined reference to `receivefromsocket'

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/android/ion/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index 0eb7ab626e1c..42b71f005332 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -17,4 +17,4 @@ include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
-$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
+$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c ipcsocket.c
-- 
2.20.1

