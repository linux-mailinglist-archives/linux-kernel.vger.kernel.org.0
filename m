Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FD2A78C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2019 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEZBTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 21:19:39 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44633 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfEZBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:34 -0400
Received: by mail-vk1-f193.google.com with SMTP id j4so3080886vke.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnpgGOdciidlMQgT6hGzG/WRh1cBgTY3o2k478rY6UM=;
        b=B6CTZcrYqQ0WvN3JdD0vakwRpRNKWj+RjGJljZcyiKvCZVSzNURC3Of/05ewDtjiVJ
         n+OFBvCwoPvpTH39L4ZXCBGFcko1j2kIScpLTLBI/uulRkI9uvCrgGHE556vTp8zfgWR
         HoGcv8XD1gIT9w+EN1KMhZg5be8FGA4STVDP5ILdvvsYkMuu0w3pTsDn27Bh+8dACfN2
         KyLZmSVyE1VC5Xq1Hm4AgG9ZigXblFXTM1qTIECReSvArsZwvJWT0fiRXt0i/93fLzyO
         T0+MNg4ZmuyzjHFyRJ8wsARTk3AbMiA4SS6BBmbfK68AYmOtof9nI8zln1UyAPoY5aLG
         PPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnpgGOdciidlMQgT6hGzG/WRh1cBgTY3o2k478rY6UM=;
        b=AkO9xaedLVuFUdvK1vQX3eEXCc0+b+Oh1F8Ktmf2GgW8W64e82CPDf/vb5ikFkr7KK
         iqwRWDqbJw/yvI7B1CyJq8mEKowBCddlyD/d2wUInDJVDX3b6QHlnXuJc7UYIX6OaoUv
         Fj1Sr+tBRsViJov7MWlbvcklW61pIKKhQMaWytvbFZqGUdUuFi23bcnGAlVNPB0KGDl2
         mgNQ+F9WpVlPyEnnNFcxE7OejodRdxofwF18g/HrGY3/XaJnCKmnXEx196kHpdQ6hvMW
         FBH5d8dIwq9GuraUXjNYrZJmnGhhIgNvU9iuyWygJN025xS4XA5RDnXFe5mtPQwcv8f8
         Jjog==
X-Gm-Message-State: APjAAAW50sR8fatKvaSmbvY+zOmv14YfONw3nhYiaitZ0TBIh1j6BQbi
        jYSp+hu2oFDsggM1KyX6X97Z2j3ZlOI=
X-Google-Smtp-Source: APXvYqyjAxACk1htIHAwqPyaPOJyLmdZFkegkv7+a/tSbTvYhykfGq3e+vdXk5No541/Mv4S27s5qQ==
X-Received: by 2002:a1f:24c4:: with SMTP id k187mr12809681vkk.26.1558833573128;
        Sat, 25 May 2019 18:19:33 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:32 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 3/8] staging: kpc2000: kpc_i2c: Use BIT macro rather than manual bit shifting
Date:   Sun, 26 May 2019 01:18:29 +0000
Message-Id: <6efa564b07731fde4647a5b62c42b0f71ce82607.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FEATURES_* symbols use bit shifting of the style (1 << k) in order
to assign a certain meaning to the value of inividual bits being set
in the value of a given variable. Instead, use the BIT() macro in
order to improve readability and maintain consistency with the rest
of the kernel.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index b2a9cda05f1b..1d100bb7c548 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -116,12 +116,12 @@ struct i2c_device {
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS      0x9c22
 
 
-#define FEATURE_SMBUS_PEC       (1 << 0)
-#define FEATURE_BLOCK_BUFFER    (1 << 1)
-#define FEATURE_BLOCK_PROC      (1 << 2)
-#define FEATURE_I2C_BLOCK_READ  (1 << 3)
+#define FEATURE_SMBUS_PEC       BIT(0)
+#define FEATURE_BLOCK_BUFFER    BIT(1)
+#define FEATURE_BLOCK_PROC      BIT(2)
+#define FEATURE_I2C_BLOCK_READ  BIT(3)
 /* Not really a feature, but it's convenient to handle it as such */
-#define FEATURE_IDF             (1 << 15)
+#define FEATURE_IDF             BIT(15)
 
 // FIXME!
 #undef inb_p
-- 
2.21.0

