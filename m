Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25CE10CA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEASXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 14:23:37 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36568 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEASXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:23:37 -0400
Received: by mail-oi1-f194.google.com with SMTP id l203so14483727oia.3;
        Wed, 01 May 2019 11:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pv0IhTFTSijdFF5H0HVxVYUnzdKwUwaNHWOJX4VCglE=;
        b=Li4BCscnvgDtdTK6M7nE7tsP7WouSAAWwuBzxr/bRZas7gtI6phgwJA8ki+O0vYbot
         NDru+DQLF6pSeyIrbGf2qF089JXa0r+JdHwsV3bSMVn6+LqjbrbKoDX4FB3X2HsrlhOK
         Mun2k2gD8x3SUh/q7wdpTfvJvEcvEzvCHKLxvu22HlBJ00cnWywelIjsXivVOAgxMvmB
         XuBKYN/X1qVdrkwMkURV72x9tX6bP6yXtjlLn4AfD1l8/MmVD9BmrqQ49F4CozuyXaKl
         JgQqMswK0IB+AGSiOdnl5yc7eFL24+kJAkRBSuUiNfZqQI4Cmt7QdZEdWA7qNoqUUttD
         QP1g==
X-Gm-Message-State: APjAAAXIgUdn6hbP34HxjqPPDPyRR2SV58f6gICoLypARKtKiaW+W1sT
        /0dO2BhB+lSdPQ1ezWD+4VrP3do=
X-Google-Smtp-Source: APXvYqxoCvQozMaslittCvrP9R6qGIuhiVa/yQSoadZzV5EOzdUkqgb6pP0GUZ2zxFyFYSyzkAqaXg==
X-Received: by 2002:aca:643:: with SMTP id 64mr5718968oig.29.1556735015177;
        Wed, 01 May 2019 11:23:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c17sm8533508otm.71.2019.05.01.11.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:23:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org,
        maxime.ripard@bootlin.com, grant.likely@arm.com
Subject: [PATCH] dt-bindings: Update schema project location to devicetree.org github group
Date:   Wed,  1 May 2019 13:23:32 -0500
Message-Id: <20190501182332.29094-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT schema tools are moving from my personal GH repo to the
devicetree.org group on GH. The new location is here:

https://github.com/devicetree-org/dt-schema.git

The old repo will be kept as a mirror.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/writing-schema.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/writing-schema.md b/Documentation/devicetree/writing-schema.md
index a3652d33a48f..dc032db36262 100644
--- a/Documentation/devicetree/writing-schema.md
+++ b/Documentation/devicetree/writing-schema.md
@@ -97,7 +97,7 @@ The DT schema project must be installed in order to validate the DT schema
 binding documents and validate DTS files using the DT schema. The DT schema
 project can be installed with pip:
 
-`pip3 install git+https://github.com/robherring/yaml-bindings.git@master`
+`pip3 install git+https://github.com/devicetree-org/dt-schema.git@master`
 
 dtc must also be built with YAML output support enabled. This requires that
 libyaml and its headers be installed on the host system.
-- 
2.20.1

