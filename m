Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E61BB5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439706AbfIWN7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 09:59:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39090 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437374AbfIWN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:58:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so9438225wml.4;
        Mon, 23 Sep 2019 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=Rqy21PONemEQUYOliMIMP9uYFwq0imIihVq9/skI9LRVxxWKwvCJ43YdqRhXiERWWV
         9jI2aDo3bEZhIP+UhpkumhfZLsAj1oeW8fLRAPlAe5b8Oni5j9IQrCROoEtKw0+bekt0
         9MowP0kBmNB4n2FUBxIke2JdzLkiTWtM/zVnPb6lrDykCQEuAlRK9JwDCOYZeVAdzhMJ
         RRc/2Pce+SFtCOzKlEQd1WcAsJETaowxiAvI4/WFvVXhCaeKZc9yJjoklVAmEG2x4zew
         u8i41FzYeYbWUShUzqrRUgL8Y15OvgBwWL7UR6qO5FnQlrAkxyznYRKu6vLoFIBIbbfL
         ueaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8lFr4ZwIttjBYV2ogrlwO0w9q8AMXRri5mgGEzyZHU=;
        b=aZ2Hyr1oSHcsK8IUG33BOsq28pq7nuJ65V3V78RFLhBQ2kh3TJ59F1pTfEGQtDgBFr
         D24BbArqFhqLXqrMkfDLNWu5iP68T+Bb/VlFkrvC/gBh7htNOi3avD/F+DCYhWKnXC/r
         A/QGEJfySQAd47Y8OjLemgdbt4xmqCeklkMb0rEdFiIDIxWzS2Gq5bwfrSVfnBgYodtt
         Vr+5imSdcAtFyQHGmqQdaEnSLA4uridaAb6YXtwSbPcVxXmD3VwON3yWHIdD9bSFliPE
         FxUN5uEtTndnIvwzZGhw1ubciHsQ0Jvds5RTjlMrBzPMcpzbxj6ec8UKolLJxMj0jLuP
         GYqw==
X-Gm-Message-State: APjAAAW/A71YrMpiSHj1pLGGIRjrhaTxbUXh8zF91tV6yX+cASfNRSK2
        pKRE7P+AoFey9H/wxzdAfKk=
X-Google-Smtp-Source: APXvYqyNZQ+NFxGJlIuTy9GGMXbzRUrp+BtFMLg/fjKVcqPQfcSleY5YFbiX1ptOjnoNXfne+DYefw==
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr13937510wma.6.1569247133526;
        Mon, 23 Sep 2019 06:58:53 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h17sm25266184wme.6.2019.09.23.06.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 06:58:53 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Oleg Ivanov <balbes-150@yandex.ru>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: amlogic: Add support for the Ugoos AM6
Date:   Mon, 23 Sep 2019 17:57:56 +0400
Message-Id: <1569247077-5212-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569247077-5212-1-git-send-email-christianshewitt@gmail.com>
References: <1569247077-5212-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ugoos AM6 is based on the Amlogic W400 (G12B) reference design using the
S922X chipset.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..2ded61d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,7 @@ properties:
         items:
           - enum:
               - hardkernel,odroid-n2
+              - ugoos,am6
           - const: amlogic,g12b
 
 ...
-- 
2.7.4

