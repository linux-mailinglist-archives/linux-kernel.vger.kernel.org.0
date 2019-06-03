Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AB337F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 20:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFCSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 14:34:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42657 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so7509923pgd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78EuSAUxvk0eTVYgfPD6z4ab5WOs+lKw0I62++Yl618=;
        b=CsQ8HbTO8IlzQQKGlsM5+fJLbWEI2MJos78k7DutwaUcPfUG0iDsrElkrHoxz2qj1U
         c/NU1Nw/+fAWm57iDd+5sZn+ZnpB95rOe1yUoI+CxyhX2iyPnRmH5w7ZC/FHgXCc+sfN
         3gnF5Q0BZ8ZdFu6cj4VgaxajLMJlW1Who0h34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78EuSAUxvk0eTVYgfPD6z4ab5WOs+lKw0I62++Yl618=;
        b=VSpYdw+ibp+Rh9tKVnWAGSzcU9y68dphv58HHq+pJ4SUCjx2aNbtz4I4D9qQKbNxtU
         FzQkQHhbj4kHWh84C0umRpDQxrVzMoM4RP2zLbXBTZkWbzWH2La7kkQOxJKfCX6WEMh2
         OuxMXbehG/29dpI7X123M/fMDrnLKSOD2qj+c9hWHjLw99Oy0KBKs2rb6xUZabeqZrpU
         vxqmosR+SPfBRWyyAPkDfwZiJ5l+gns5cduTWu4pk1LwbwFLidGh+vf4GiXOHvUj5Uqm
         +b56dRfVqJxt6cK8eUvU5Y3PUgnOMtkan3GAKtCofNeBuIU2kJrf8cLH7E6veJ48Bizh
         dNcg==
X-Gm-Message-State: APjAAAWakAkrfzWoIbYy6aMoaHm0/8tOJ1MtzqOSzHQIZIeR6O5Ks9K7
        GEGfo6frIW9QsBxASpBqZFocTQ==
X-Google-Smtp-Source: APXvYqxd1tp2oLCjAOIPaRZ+9YiuZUB3isblM3Mx87v1tZEuxJrfwDiG40+SIdeWFfdBs8nbLS6C2Q==
X-Received: by 2002:aa7:8705:: with SMTP id b5mr10340371pfo.27.1559586866606;
        Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id x66sm17074409pfx.139.2019.06.03.11.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:26 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 13/30] mfd: cros_ec: Expand hash API
Date:   Mon,  3 Jun 2019 11:33:44 -0700
Message-Id: <20190603183401.151408-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve API to verify EC image signature.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0ff1941288cf..76943e64998a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2018,8 +2018,15 @@ enum ec_vboot_hash_status {
  * If one of these is specified, the EC will automatically update offset and
  * size to the correct values for the specified image (RO or RW).
  */
-#define EC_VBOOT_HASH_OFFSET_RO 0xfffffffe
-#define EC_VBOOT_HASH_OFFSET_RW 0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_RO		0xfffffffe
+#define EC_VBOOT_HASH_OFFSET_ACTIVE	0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_UPDATE	0xfffffffc
+
+/*
+ * 'RW' is vague if there are multiple RW images; we mean the active one,
+ * so the old constant is deprecated.
+ */
+#define EC_VBOOT_HASH_OFFSET_RW EC_VBOOT_HASH_OFFSET_ACTIVE
 
 /*****************************************************************************/
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

