Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915CCA2EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 07:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfH3FCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 01:02:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfH3FCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:02:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7AB7961B14; Fri, 30 Aug 2019 05:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567141334;
        bh=fe+1CIFsLrsFmj7GnadvoGOHiiGzQrdsXLHYlpV+vnM=;
        h=From:To:Cc:Subject:Date:From;
        b=DF35DWi/vcIha8ZdCxzYGat7OgmKEDoWJ9P16AGIJunFqUn8gDuZY6RzkK1YBvQXc
         OyzXUZlhXMt3ZkhRluU+RMIKQvCCnZL3QzcSJHghAiMqdzjXYjAdvWUm4jaKC9hywP
         oxorZWI2p1t24zo3fb3J5k5M4pIcb3UjLU0ViFPg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65CF3602FC;
        Fri, 30 Aug 2019 05:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567141333;
        bh=fe+1CIFsLrsFmj7GnadvoGOHiiGzQrdsXLHYlpV+vnM=;
        h=From:To:Cc:Subject:Date:From;
        b=cq6tFOjrdTDeySUCvbiv+pnJOqt1EA0f/z2kgaQPmN973eij2IW0UMUzos6pQ8aIZ
         Dyj0sVSZ34RKvan+TEX75lLPeQqCeD70ezOD2PTF1BL6S9FMfmm0jI6fKZdlVzQeAV
         zuAmz7WnqM0Xb9GteUde4UCbbtVEvZTEGsV+AQoE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65CF3602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v2] Bluetooth: hci_qca: wait for Pre shutdown complete event before sending the Power off pulse
Date:   Fri, 30 Aug 2019 10:31:44 +0530
Message-Id: <1567141304-24600-1-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SoC receives pre shut down command, it share the same
with other COEX shared clients. So SoC needs a short time
after sending VS pre shutdown command before turning off
the regulators and sending the power off pulse. Along with
short delay, needs to wait for command complete event for
Pre shutdown VS command

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in V2:
- Modified commit text.
---
 drivers/bluetooth/btqca.c   | 22 ++++++++++++++++++++++
 drivers/bluetooth/hci_qca.c |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8b33128..d48dc9e 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -99,6 +99,28 @@ static int qca_send_reset(struct hci_dev *hdev)
 	return 0;
 }
 
+int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err;
+
+	bt_dev_dbg(hdev, "QCA pre shutdown cmd");
+
+	skb = __hci_cmd_sync_ev(hdev, QCA_PRE_SHUTDOWN_CMD, 0,
+				NULL, HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "QCA preshutdown_cmd failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
+
 static void qca_tlv_check_data(struct rome_config *config,
 				const struct firmware *fw)
 {
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ab4c18e..43df13c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1367,6 +1367,11 @@ static int qca_power_off(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 
+	/* Perform pre shutdown command */
+	qca_send_pre_shutdown_cmd(hdev);
+
+	usleep_range(8000, 10000);
+
 	qca_power_shutdown(hu);
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

