Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29B68E49A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 07:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfHOFwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 01:52:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46541 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfHOFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:52:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so692930plz.13;
        Wed, 14 Aug 2019 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7fRAJxOdOc1GNCOY9NWJKA8JD3G32E5XpmwWmSfP4U=;
        b=Roo+3MIe+UPeGog0Ys9Q5X+o02oZmXWPWNvA277ShX2Uh/iTpC8J6m8Fywx7+0z3su
         p9HSPzqYDzhcq38yN3G892zMYWot1hkljWXPTu+wW9A8QRWf3s0Uy1ZZadGGa93jxrSY
         SX73Ce1mAVnmxGR8LNmwgu/mwjFRKNCJJMDGXSsrQ67lHZL0Qyy7xHpRet4fJl/mRoqF
         vSKIIh4Vo+KQIykoD/EIhurpZXgrf09HsjEITjHGZRVnZXNcTEKOZqfTn+RjCm3S+lFQ
         0FpI3MVwZBP7knVoVpGzJM51HaDVzNP85mUvkJ7A1sfAsmtow7/XenhdCVEtrC2kkehC
         8g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7fRAJxOdOc1GNCOY9NWJKA8JD3G32E5XpmwWmSfP4U=;
        b=IefLZgYjAJEpNIgqJRUVbn/l9Kyqo8kavXM5MG7MR/5bwsxJpMYuhWcL0thwV3touG
         BZvP3wJOigiuQz8b34HmBd2EnQi7BBDjXbj6w7ksLI3nnSnsTzUoGJ3mjCSb3WCqZlN4
         uk7CLz/67CzorMNh6GjVkTcRD/3oshupN7BEl3TdCa2154ESwyYzPYiKhbLyeQ21uc1E
         MBQyZKYW8RSR5cVH3K6TIaEkOlGQMIrOQqyVhXnbFMWu5HkHsL5F/c+OpsF8D+2RwXe5
         mUwlyNn5NeCSRnVa0EJxUiLWSB7w3d5maZFKgbRSHzPduXRl05by8mAoFdS5DZvqbBj9
         Utzw==
X-Gm-Message-State: APjAAAXfE4T6sEhm2kxYRv+vPuuKxgy4lP8zjB5LbPscUeZPCFUqREW2
        c5qDmDbIEZNMRjji+EOVjozCymST
X-Google-Smtp-Source: APXvYqyoQRo8ZdTbK4DaTDT0cIfD6LjGfd+e/+e9szDXSQCjnD3SlKtdkvnk3TDe5L2mcwCfG5JWHw==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr2944795plk.35.1565848324382;
        Wed, 14 Aug 2019 22:52:04 -0700 (PDT)
Received: from localhost.localdomain ([110.225.3.176])
        by smtp.gmail.com with ESMTPSA id e66sm280441pfe.142.2019.08.14.22.52.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 22:52:03 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] Bluetooth: hci_qca: Make structure qca_proto constant
Date:   Thu, 15 Aug 2019 11:21:49 +0530
Message-Id: <20190815055149.1062-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static structure qca_proto, of type hci_uart_proto, is used four times:
as the last argument in function hci_uart_register_device(), and as the
only argument to functions hci_uart_register_proto() and
hci_uart_unregister_proto(). In all three of these functions, the
parameter corresponding to qca_proto is declared as constant. Therefore,
make qca_proto itself constant as well in order to protect it from
unintended modification.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 82a0a3691a63..80923fc9418f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1326,7 +1326,7 @@ static int qca_setup(struct hci_uart *hu)
 	return ret;
 }
 
-static struct hci_uart_proto qca_proto = {
+static const struct hci_uart_proto qca_proto = {
 	.id		= HCI_UART_QCA,
 	.name		= "QCA",
 	.manufacturer	= 29,
-- 
2.19.1

