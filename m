Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB9120564
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 13:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfLPMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 07:20:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36677 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfLPMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:20:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so4396244pll.3;
        Mon, 16 Dec 2019 04:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=IrpQwAz93KZmeSxLub8Zihm+XDMSBrymSgxPC2ZNJdhVGQuIIMEs5Py8SnRv4C6iIg
         Ol4akHx8mpkkNCvsjL/jDBcsydtIqbOkQe5Rn3Fzk+jdSwj7mZzWaj914/idSfh2oNP3
         FYQMXy113eSsClVmnngClHV1LkD/z9DtTpj3t7GWpah1F+uXyglIvx5pM3Kbk6H6IfX+
         TNFRsGN7yNcQYgsfcsNKPOhdOIjPaa6RquG3zWdWRxOcVLcKGH/nTvo24q2rwsum7tCN
         zrawfXfdHwxRZ+W6DcESuBD8eO6HHfWToT+ZoQglPACq43e8if09hwRu5DLk1U8tvlUN
         6kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Gs8xOV9REFN752Csx9CR2qaFoIT578nSg5oH4PWWVU=;
        b=DQWq4X2D8ylvGF8mLxmJe9ne/0Hoo7CXrAnvpfC6occeN69rMkVBs9kPy1qM4MeAqB
         krMJ5zcsKyYpQjftQ90QjnBl4agL7m6HFVRgVv2hFcUV5CoLtS4u5UdX6yoJe71c38AB
         KDWSNBEwZ/rFA7A2VX7dKR8Ome9abSMgYZOB/gflAqrd4tZvOdySQRNfV0qir02p+goq
         gKltE4r8wvXJGxAiFQX4QJiqM6OZEJckr92sQgDwQUxXp9waIDoextRRYdmEZfVBAy1b
         dVyLn4dI82YCfeZdV8RO27AuzwQ2P78qtPoMisEsZIG+UoEkgtCue+QaDGhQfZXnKggd
         kVBA==
X-Gm-Message-State: APjAAAXq+UaKT8d7e2BQXWjLPDsSm1SezM8DcLGI5u+qalCUcjkhIpWt
        wwsyGbb0r1Qd9N0VC5hpPjs=
X-Google-Smtp-Source: APXvYqxtUcACMZN/lEcBGw/eVBQ5+PCdg3R95xC/iDSPPx3dzGdvL/y0tRtXqUm23GXD4jc9PzyNoQ==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr17809673pjq.118.1576498840509;
        Mon, 16 Dec 2019 04:20:40 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o17sm18633910pjq.1.2019.12.16.04.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 04:20:39 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V2 2/6] dt-bindings: clk: sprd: rename the common file name sprd.txt to SoC specific
Date:   Mon, 16 Dec 2019 20:19:28 +0800
Message-Id: <20191216121932.22967-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216121932.22967-1-zhang.lyra@gmail.com>
References: <20191216121932.22967-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Only SC9860 clocks were described in sprd.txt, rename it with a SoC
specific name, so that we can add more SoC support.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{sprd.txt => sprd,sc9860-clk.txt} (98%)

diff --git a/Documentation/devicetree/bindings/clock/sprd.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
similarity index 98%
rename from Documentation/devicetree/bindings/clock/sprd.txt
rename to Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
index e9d179e882d9..aaaf02ca2a6a 100644
--- a/Documentation/devicetree/bindings/clock/sprd.txt
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
@@ -1,4 +1,4 @@
-Spreadtrum Clock Binding
+Spreadtrum SC9860 Clock Binding
 ------------------------
 
 Required properties:
-- 
2.20.1

