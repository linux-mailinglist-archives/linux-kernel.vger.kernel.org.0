Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60352B59A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 14:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfE0MnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 08:43:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfE0MnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:43:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so16808917wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wfKAsx1k3aZxm1g3WHRqV/EWJCTGjV5kvipkF29KWgY=;
        b=RbixjwZfkqTf7IjnopTanq0l4LQmRfQrKZvuDGX7vGcEw57/aoOmAB7MvWEgbsFEEQ
         FnNubmDp9BOqpEMqt7ceQvKzMftLMFAlYy8DH6ClC2u3tTNNQyTt4j07CKKUSop2lyKK
         O6BY8X+QzDpCyZneUK62VsxMklgpvmSbEBloeNMS8blv125hNBND2y7hPxGdRXhUasVA
         2BKmUMDZse3jc8EwYgQfNqwVUguTsaERfTcXWFAeT/UUpTVqivGAIncepVhKdgPlYTfK
         WttPp0FRlWnvcMT8iOT+SL2Yyn1PINPI2xPOErptKrxeTxaG1FcfI2gSKDI+Gzarc7QB
         N8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wfKAsx1k3aZxm1g3WHRqV/EWJCTGjV5kvipkF29KWgY=;
        b=OEdukgv/E9OvWltQGW1UhkN1h/OpHZ1DHrxUdXoucYiKx/6ieXAXkrdspM45t1VQv3
         jhBCKz8ZNR0tf7V5ag+UZxHqD2eP4bRIldZ0c0pwpwr/mHLEGUn43ZjZWGW/iqO47668
         4YVbna1t8OFzrOvURY6z9fbeUMTZdzn6NkyYOKFvjlmNbRFIm/RXu6Oher6mikFhBsfB
         +3MrY6adRUw5eH0CcGvVtRi01T2ddYnGrmUuXy5RaLC3xAx/GRGkJ+qdkGggVi9pilzr
         5hEddt3HBCPIHIR1ecMkl/zIQBokmIaC+Z4jdyg/Blczi1NUII2xkUc1JfgTBRbFGf3j
         nK1A==
X-Gm-Message-State: APjAAAVliC+l/O2rZFeBg/IBAFuVwcwibKTTe76UNNiEeKRMKxLstwMa
        0gCBBvAGHaNnswYLfTylF1kkDQ==
X-Google-Smtp-Source: APXvYqxnfjIHIRa4qi07Fsf6jQxGYjFAlyaqW/pJH4kjCXSboDIWvjhSeowBftxypf9mHpHl5S6bwQ==
X-Received: by 2002:adf:db89:: with SMTP id u9mr36557444wri.294.1558960991581;
        Mon, 27 May 2019 05:43:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: meson-gx: add dram-access-quirk property
Date:   Mon, 27 May 2019 14:43:05 +0200
Message-Id: <20190527124307.32075-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
makes any DRAM access from the MMC controller fail.

Add the amlogic,dram-access-quirk property so signal this particular
controller has this bug and needs a quirk to work properly.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
index 13e70409e8ac..ccc5358db131 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
@@ -22,6 +22,10 @@ Required properties:
   clock rate requested by the MMC core.
 - resets     : phandle of the internal reset line
 
+Optional properties:
+- amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
+  DRAM memory, like on the G12A dedicated SDIO controller.
+
 Example:
 
 	sd_emmc_a: mmc@70000 {
-- 
2.21.0

