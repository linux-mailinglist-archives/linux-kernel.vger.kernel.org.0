Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010E5F0B08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 01:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfKFAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 19:30:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42815 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbfKFAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:30:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id s5so9163203pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGLlsN3tP5d3XlKJATDIW7JuXqbojd8kF/+EpW4xWDs=;
        b=eShP+02FUAYXD37ksphiWSo81YU0fqTV1ZEnEJl2Hp59W5Q0/v3YhV+bksWoBsb/mg
         bgXU6X0bANJoV1xRp8QqF0DJYTMO/Qlumfw7+LMPoyAL9Ltwd+M6z+Vgy02M413gn8ue
         g+u1C3FCWk6048ipYYk4/y/NlH64PfdOFfrSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGLlsN3tP5d3XlKJATDIW7JuXqbojd8kF/+EpW4xWDs=;
        b=OaHhi5GMXOUT0h576FH6c+ztwscRfKxWwf1Xi5dehFfkertMgT+Lcak1TcVT+9EgQO
         YcUSZyiNKJzdZ2wZomJ0K/bKPCk1jVuShD22Upo1i7PsvVFkGkX8cOFtwidsxbKiAQu7
         0oBPvML61/8GykMh5QXRzlZklWdLQ+LQ8nwQuwl4qCSVnzaLxMuw5Xl6nW+EhRCl1SFz
         iUbhcNB5ePcIfuM1ICAzAOaaJKxvOQrRayr1Iiyyj5+q9GwZGbEqYx9WFAs3OYriKqyE
         Ob1YCtmGmwWIh9dA1o0ORgMgaRpTyb9dkpT4+LI7hMb922Pr87RgBJwSYNuWaMYPeQCJ
         H9aw==
X-Gm-Message-State: APjAAAV94qPWrK6crBmjzGLuZoet1dBE1G+DeFhAROp+2YHaJSworu73
        72kFhc/pRKASZU3YMjxbdvqn3w==
X-Google-Smtp-Source: APXvYqy6wFT1XdF3SZGwpxsiume7DbFSVy8MGsUh62vslfzCMWI01MwVF+XFGm978PPHeKmbuvzZiw==
X-Received: by 2002:a63:3e0b:: with SMTP id l11mr35830888pga.448.1573000207369;
        Tue, 05 Nov 2019 16:30:07 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k9sm21032835pfk.72.2019.11.05.16.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:30:06 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Tue,  5 Nov 2019 16:29:21 -0800
Message-Id: <20191106002923.109344-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106002923.109344-1-abhishekpandit@chromium.org>
References: <20191106002923.109344-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM vendor specific commands to configure PCM.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btbcm.c | 27 +++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h | 12 ++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 2d2e6d862068..1b6afb11844a 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -105,6 +105,33 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Set PCM int params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc1e, 5, int_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Set PCM data params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_pcm_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..4cc6769f6bfb 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -49,11 +49,16 @@ struct bcm_set_pcm_format_params {
 	__u8 right_justify;
 } __packed;
 
+#define BCM_PCM_PARAMS_COUNT 10
+
 #if IS_ENABLED(CONFIG_BT_BCM)
 
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +79,13 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_set_pcm_params(struct hci_dev *hdev,
+			 const struct bcm_set_pcm_int_params *int_params,
+			 const struct bcm_set_pcm_format_params *format_params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

