Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E31C437B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfFMPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:00:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45419 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732576AbfFMOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:42:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so22797837qtr.12;
        Thu, 13 Jun 2019 07:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JKH5sFy8+WUQIQRjDUBH3ut64hE9XedmFz/Phqo/jiU=;
        b=uJcXacSh/Qcn1YPznAJbN0ts3c29kkhqmTuPDc9dQTIXFp4nmT1FZeNYwrvEjGTv/t
         vZQvhbut2KfLxvQfM1CYK9TqDcon0AYx8wMjo6R63JwcDYFHRZEgaiGRadIssTEwVNfq
         8ju9Iv7AYpeuE9V6pTRoWJm9ZkLLzfSYzCD9gfVAh++SjQxTR1ZMsmmtS+JHctaFUmMy
         jI+azAN1PlxM+Vhse3WOG9V+ESMApHNcLAAmMXJVZmIhhNlWnTssvrdpkhwQlJb77d0n
         lfRmIOVFsBhsqAEezRlv8EZuytv8tMtg4+nIMEe1/UfZ9Csa5qabM/2vUwK36XcKj1U8
         mGcA==
X-Gm-Message-State: APjAAAUWMm7MaR/+6cpRyUOFgTxHscdqBe5ioKFY2hu8MYFzdIU4Bl84
        vsP2EzdfDO3SqC82Za8vtfHt5P0=
X-Google-Smtp-Source: APXvYqzdkEO/Ac9K3KMSiWPgOBD/tz58o7M++1siTknWyHKcMLw8aKPLqXFa2naotulLkAjCPPFZcQ==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr54157029qtn.107.1560436933881;
        Thu, 13 Jun 2019 07:42:13 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.243])
        by smtp.googlemail.com with ESMTPSA id d38sm2052810qtb.95.2019.06.13.07.42.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:42:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Also allow node names starting with '_'
Date:   Thu, 13 Jun 2019 08:42:09 -0600
Message-Id: <20190613144210.22181-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated nodes for overlays begin with '_'. The binding examples are
built as overlays in order to allow unresolved phandles, so we need to
allow the generated node names.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e68c839e9f51..a777168432d0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1028,7 +1028,7 @@ patternProperties:
 
   # Normal property name match without a comma
   # These should catch all node/property names without a prefix
-  "^[a-zA-Z0-9#][a-zA-Z0-9+\\-._@]{0,63}$": true
+  "^[a-zA-Z0-9#_][a-zA-Z0-9+\\-._@]{0,63}$": true
   "^[a-zA-Z0-9+\\-._]*@[0-9a-zA-Z,]*$": true
   "^#.*": true
 
-- 
2.20.1

