Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEBC1964A1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgC1Iwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 04:52:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38061 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgC1Iwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so8670384wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFx2SvxjuM8tE54W6RW3E84IYMCe6MfkwCtMSoI/4p4=;
        b=vMP8/BQAFLQ8VvClMhcoO3IYuDH/LvWr7JZU/piKMWD5TW1fLKoy8q2DYAgHqu85fC
         IhowxOxuR+SHHJcmg71uyYaQ8gndSfOkVRF9xQa/w0Tkmvs3fU+69GGHz2VXsj/6mqz6
         bUh6JyJaqN0uqT1j+a0inItKz8yYPoK8Y3Ngxc4eefTgJeyMvfpMpnDDo6b0ajvLNzxU
         GrMkzQNFJ99DU5WSPrjEoC9W1Sqs/zp82ZvR4vgGgCewSc6RtE7Z8hEcQ7+KV4NL2TYv
         Kz7sxcbwKqFnIM2wAC44/cqHlKybbJ5JR5nT+xyxNl3SCoVNNCLzxztX3GJYHHFt8ElO
         +iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFx2SvxjuM8tE54W6RW3E84IYMCe6MfkwCtMSoI/4p4=;
        b=Z30yVqXmpfqd4tGVo3YHFA51yTT+T12qUanBtH18E6L9JNSCqA2U0gc9ifdsSYQNSZ
         GvIIihUcsTwV9kVlXqMSmR4w2Km6AZBT9CkZqgffGoFu0Aep72ybNabJOCki0S7eNSF3
         sFgw0BkOQ8Qax9g4mHV3tq5VtJgNuxjXJD1W6f/yaiP/Gru3xZ9hMbo2UioZA99q6I/9
         gl4l3ClGXdui8eXrDU6gVOWCR4I12Ns46ZQiW5bocT4BgKzXNkUwDz1WTa1YIht52FcT
         Gnj6uoyIBmMrD0TCfrrBk7YjiMDdHHzHkHBhB1IQ30hcwkdcNIcRlIt+Z1wq+CPlsrT4
         V+7w==
X-Gm-Message-State: ANhLgQ11o2mha8ZyKIcsfDiXvox3Rb9Y1/GT0A069tm+nlRtHEAjphjO
        sggpcvS/ZnrWDyCVKUaNAiP1G/r6
X-Google-Smtp-Source: ADFU+vvwncRynA3CsJPrEjFwSOleCojRfO7y8bwh3yU0zeJH737bON/bnM0d5Sj0K5/qy5A/D0rKBQ==
X-Received: by 2002:a7b:c18e:: with SMTP id y14mr63081wmi.99.1585385571801;
        Sat, 28 Mar 2020 01:52:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:50 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 6/6] habanalabs: increase timeout during reset
Date:   Sat, 28 Mar 2020 11:52:38 +0300
Message-Id: <20200328085238.3428-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing training, the DL framework (e.g. tensorflow) performs hundreds
of thousands of memory allocations and mappings. In case the driver needs
to perform hard-reset during training, the driver kills the application and
unmaps all those memory allocations. Unfortunately, because of that large
amount of mappings, the driver isn't able to do that in the current timeout
(5 seconds). Therefore, increase the timeout significantly to 30 seconds
to avoid situation where the driver resets the device with active mappings,
which sometime can cause a kernel bug.

BTW, it doesn't mean we will spend all the 30 seconds because the reset
thread checks every one second if the unmap operation is done.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 199f7835ae46..6c54d0ba0a1d 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -23,7 +23,7 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
-#define HL_PENDING_RESET_PER_SEC	5
+#define HL_PENDING_RESET_PER_SEC	30
 
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
-- 
2.17.1

