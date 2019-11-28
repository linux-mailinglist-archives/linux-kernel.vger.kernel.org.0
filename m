Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A75C10C9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 14:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfK1Nny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 08:43:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33245 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfK1Nnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:43:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so1552322wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWB0GnHdmXhKLKHodka8vOS+SgvA6x8EElzWcdcx5ww=;
        b=F1DEWss5lWPIOHF1keRZXlAR8uX19LLPvRfTbPq0IGYG2LZ5nSNZFGU9oW0IZn/6Bn
         Z4zm5JyDek6NV2gKYHZxSW9rLehMcmfmekenEFg8DDGo2iN5OhWe1aDkhjoCmZx2Ir3o
         uRyeHpHi61ZR2Xdb+jeHSTXjT/eCAS/AYdOPvy2+vKFi8V1jKW0G+GG7U6aZXmUvrPwW
         OLCVvYFrZRlDM9xrAiMvDCv2T2MMlcg6+9Xcfr5hGdOTKXnyolbZyHPV37O9WcSvuMQa
         zYk+gtd4Wk8wTD190V/dklglqsiwPOPw9lAfK9LGqVTfCFI6T1mAJt0/0Lpp/Hkr4QyU
         BMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWB0GnHdmXhKLKHodka8vOS+SgvA6x8EElzWcdcx5ww=;
        b=K+eH0lLsNrFkk6p89+uY1bd+Tc1MLNRZ3yLlJnDwLFc9GffVf8qrPe6pjLo8Oyd1o1
         k1PU456YI1q2XTQMHjGYlh3HQ9w8DPzJ8k5UtncQma9AoebqxOp3HOBcn8//JbKi+0e/
         R82V3xOqrD1IK3rvhntog9L2K1jVJXtq2XDA5bJ3WOcWNmMQQzEoIDpMveIHr/sWRaJT
         0zjyC3LX7sA6QNdiXvPXMwgf48U2r/vG/zehEYKmRHXbBnGWgYSyZiQOUXWhV/5BMaf+
         GRAaQyQQ7eVFsfn7ROgmM0y6GJWfS0lRe9NBkyPiNZNxV1fXjMSLvlObwTVzCKJFwu67
         LtNQ==
X-Gm-Message-State: APjAAAVDWB41l7VUXz0paB6DoliHSehSXt8XITM8vsp+4z8RsjkQb7/C
        jCF3PWbc/rcCJLJdCbu8Sqqn2MA8ysE=
X-Google-Smtp-Source: APXvYqzBZTvoaBQhXf4XJ+7VH/b38mWo1iX1Z0B6XnUNVcuTjgKirzmpRYM5aHebl+qRmeZIJVJ/tg==
X-Received: by 2002:adf:f147:: with SMTP id y7mr48400538wro.236.1574948629807;
        Thu, 28 Nov 2019 05:43:49 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id u26sm10743407wmj.9.2019.11.28.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 05:43:49 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: connector: Improve the english of the initial description
Date:   Thu, 28 Nov 2019 13:43:58 +0000
Message-Id: <20191128134358.3880498-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128134358.3880498-1-bryan.odonoghue@linaro.org>
References: <20191128134358.3880498-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description lacks a few indefinite articles when reading and as a
result is a bit clunky to read. Introduce a few indefinite articles to
appease the grammar gods.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index d357987181ee..88578ac1a8a7 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -1,8 +1,8 @@
 USB Connector
 =============
 
-USB connector node represents physical USB connector. It should be
-a child of USB interface controller.
+A USB connector node represents a physical USB connector. It should be
+a child of a USB interface controller.
 
 Required properties:
 - compatible: describes type of the connector, must be one of:
-- 
2.24.0

