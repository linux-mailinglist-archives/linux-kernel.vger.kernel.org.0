Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556051827DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 05:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgCLEjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 00:39:02 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:42268 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLEjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:39:02 -0400
Received: by mail-lj1-f175.google.com with SMTP id q19so4805092ljp.9;
        Wed, 11 Mar 2020 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CQ5GKeXvkGqParOGBbk3REWEzXGx6iRtxkKUwPdofu8=;
        b=PwGzluP0WgYEtjxd6slxjBTCQ2MCXElCaw1aAJM7OdeBX9Y62hglyUeK1LszMY+bD1
         v7uFtw5T76pg40v3E9xj0x9MZlUalHZGlqKUyw/JbUpi8Z7/7+9OWbWe6GbFZMkFvjxx
         FUYU2516f9coJD1EzSC46OepIfcp95Ziqde7sxBCCxiwj4lQAfyRiVcb7Cwo5f/ia0gC
         7vrmllqUbZEpF81R+ugmFFUwM+Ty4hu4T0wGckJtMOa/2Oc4NgSBFWEIhkjcHoomO9Qf
         4iHz2tXzPdjPffg1XuIOilgBTfA7pFtEcaq7KttUX7KuNr/zCOowaAcMyDT5Wwu60TiC
         B2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CQ5GKeXvkGqParOGBbk3REWEzXGx6iRtxkKUwPdofu8=;
        b=YueLx3NxQ8GRPcg2g5LR5yuqlACyZncOvVyRrjC0gRrqXbH1g7KGF8GSe0C0/7aoPG
         ed2oP03yjfIpOXPK2cHDvIq8ZzRGy0HOga9mtd2ofOkdrE6axAh3j5xivwkVsgCykoMD
         I/qTYOO+TewJLq0gN4rgHj9wr+LqGWUe8QH3npHSYAuvKFnZburtiyV08cZRr04Vj/XH
         yHXLrJOawknyb1i4WTmicD9g16hm+AkIOCT3opVji/9DqNeKV3I9oNx68Zyty7HjRX6f
         Ub6zPF1FZq1VQCHcUc3QM3UVVuzEy5q9skrRm8/0NC8Ucq6BFqYA+cqV4AvVx/NJlvDL
         pSPQ==
X-Gm-Message-State: ANhLgQ2eDS3Sy/x6Ofd+rl2zkFDxaevLPDeKtXgFSEGYx2Tc+w9bqMw2
        sYYsxJ1eXzRMfOUnQcphcVU=
X-Google-Smtp-Source: ADFU+vsFSBXwiw010EUlpXZARd0uRs7BApQJI23fC7SCtptQOH7Z11vbSZqTSLxTOovEFUo57s0srA==
X-Received: by 2002:a2e:9b90:: with SMTP id z16mr4054714lji.254.1583987940236;
        Wed, 11 Mar 2020 21:39:00 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u2sm8872866lfu.3.2020.03.11.21.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 21:38:59 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v7 1/3] dt-bindings: add vendor prefix for SmartLabs LLC
Date:   Thu, 12 Mar 2020 08:38:04 +0400
Message-Id: <1583987886-6288-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583987886-6288-1-git-send-email-christianshewitt@gmail.com>
References: <1583987886-6288-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmartLabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices [1].

[1] https://www.smartlabs.tv/en/about/

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944..a34ed82 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -901,6 +901,8 @@ patternProperties:
     description: Sitronix Technology Corporation
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartlabs,.*":
+    description: SmartLabs LLC
   "^smsc,.*":
     description: Standard Microsystems Corporation
   "^snps,.*":
-- 
2.7.4

