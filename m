Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5A851A9EF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 03:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfELB0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 21:26:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33726 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfELBZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:53 -0400
Received: by mail-it1-f193.google.com with SMTP id u16so10792466itc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BugBRhEBl3G1fy7c7RR+dHZQApGESbUCUc9bnd+0Brg=;
        b=wisLLX59mbsDuhRnzFKNEtf9oOEPwlmc7PpaGaBg7gkYeuG4UqrK+zqrhXleO0/U5v
         qLDpyv9u2O2uqBVSskQbAM3ts50+sYspzicdtlS4vU8y3jk35Tis4l2nzyh8MqfjIZan
         wDcLqe0bAXnoYFvGAeu8paG3YKvvWxIt7cJZrd3pm3kK2H5/T3mTDBDjmwXCi0A8tSnv
         pXgBe9vX2upBcCm6rqMQa0CuUvlL+e5RJnVPpvMQ2x+zCYB+Y4FzsPfufEHXdZ+ngKnv
         6xsuT9ezZRvhyFmrKplc+x9YxNB6FLZh0hcPaNVf+gn+IJYuPUwT/eHSIk8PwD5GKm/X
         wK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BugBRhEBl3G1fy7c7RR+dHZQApGESbUCUc9bnd+0Brg=;
        b=MhRyRMfsTKaKGUceGJDingOHthLoz05eoX1QwEmLhZCvXSVJcROKpb6xwkid3HcVxR
         PvS724E1jhQ8vEc0XulhOo92XR+kyjPB7Z/tESl2VJTTPU7cyatfDOpeUk3Zkt2YjkFO
         1rJmadX4VQjV6zGVMCCxdQb8hWPFMFhDpUML84NsXDTJc6ztKxLnVjewsWZkXm3VNUdA
         5WSyfRZXlCQDtIc3A1hjbRKmIZXXTT7s5ZN+xNKPR98xBAjlTNZDI4zqmb7419gkLF/E
         L5ZWFBZaxlY11MjRqtGOV2GeEk17W2XL9+LJeihou4/RZy1/OzFrRF4vZ75rp2U24t1S
         3+AA==
X-Gm-Message-State: APjAAAWRTu3FOIzZXwqBp/Bn+3XGeyj8oRZ14qf51AQnVyO9afFMgGhF
        8kHr+wljhaQz0lCfyIqlQpMzFQ==
X-Google-Smtp-Source: APXvYqzH6/GYaQyL1hOOMcXrsXk8vWuXyAJ1hq9nVALW6eheGL93ZHDjJmxovdZscIM+fHFwI+Imgg==
X-Received: by 2002:a02:80e:: with SMTP id 14mr13632821jac.71.1557624352463;
        Sat, 11 May 2019 18:25:52 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:51 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 16/18] MAINTAINERS: add entry for the Qualcomm IPA driver
Date:   Sat, 11 May 2019 20:25:06 -0500
Message-Id: <20190512012508.10608-17-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry in the MAINTAINERS file for the Qualcomm IPA driver

Signed-off-by: Alex Elder <elder@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c2fce72e694..2348a90d4dff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12694,6 +12694,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
 
+QCOM IPA DRIVER
+M:	Alex Elder <elder@kernel.org>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ipa/
+
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
 M:	Gabriel Somlo <somlo@cmu.edu>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.20.1

