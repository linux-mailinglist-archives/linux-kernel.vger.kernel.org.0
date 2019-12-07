Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2A115A14
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2019 01:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLGAYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 19:24:33 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40097 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfLGAYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:24:32 -0500
Received: by mail-pj1-f73.google.com with SMTP id x16so4475567pjq.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 16:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t/DVJ0mhY4OY2TWA/vdfuk+GWdXq6Kiwb0UmMVH0gpI=;
        b=bYSAiSYKDu4ERcSkfVZ+l8+jpWOtQ+s5bofEgPY+pKejypGhEnX6NK/M8pUc6AwcWa
         eN8TKaBDYOVVsaudPCIwKIMgofceRBJ8X3/TvzLzkrniROqEu++WTp69ch3/0kVKx3L3
         Su83ADGEUpTSF5udUsbWdZE9uFsYjc/tg72TBip72DpiwycMWk6HFbrEUaFBTsYivpBh
         4IPRImdHJn9Shpo61BERYBMkZqNhbIyBwOg88W2MA2Eg6e8N3Kev+o+Vkftcfdi+x0Fr
         VQZk3ycPIKyS6FB+bcBY5GgOnSfNbV3BO27h/KyhksK17rNacDd2yJEb7iFPhg6canpg
         TXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t/DVJ0mhY4OY2TWA/vdfuk+GWdXq6Kiwb0UmMVH0gpI=;
        b=WJ0CDTgVkK+s5YtG4CZ0rB+aU5YKeKpPJRCQIkaplLq9z0ND2LxX4a+VLe0qZi/f2c
         im8yc9jY4TUCnZigdVzyAQYYy4VIK7+wbxFHVeJrdI8V7kRvWmKepqiR/ogOaluP26/+
         bY3r0bQgTcMSg0+GP5Ox57vBpMNiS+LRzvErzDx2jwiMktikqOZqNmhLGC5Hy/616U6k
         W1d9PSH/oc4/PeNdJnYhdzjhFfGe9d1gNi8llqC4V351OJAsLhbKXiXKdmHmTvu2H5aB
         0Ds6n/cAUD8lIP4onEAsYiUT8P1lcleJyzU9h/qHjTafuK/vuT99fv1dFd9b788PRW83
         qc3g==
X-Gm-Message-State: APjAAAXEB/oUTg/wCQTAoWXAhCgXdoo2sPQiZMDYGFa4AinHVhBLWX5I
        HLv1hoKPLt82cQTgUIqybyfUyjGUtBwruJY=
X-Google-Smtp-Source: APXvYqylZQVLkOpfER8t/yZZCmSULmwiBhOYyCnd/zwW3zgp94dvh+qSpoiDQrfXfG3g6tHz9kd3kPAHqWauttk=
X-Received: by 2002:a63:d108:: with SMTP id k8mr6468524pgg.434.1575678271932;
 Fri, 06 Dec 2019 16:24:31 -0800 (PST)
Date:   Fri,  6 Dec 2019 16:24:22 -0800
In-Reply-To: <20191207002424.201796-1-saravanak@google.com>
Message-Id: <20191207002424.201796-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191207002424.201796-1-saravanak@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interconnects often quantify their performance points in terms of
bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
allow specifying Bandwidth OPP tables in DT.

opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
tables.

opp-avg-kBps is an optional property that can be used in Bandwidth OPP
tables.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
 .../devicetree/bindings/property-units.txt        |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 68592271461f..dbad8eb6c746 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -83,9 +83,14 @@ properties.
 
 Required properties:
 - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
-  required property for all device nodes but devices like power domains. The
-  power domain nodes must have another (implementation dependent) property which
-  uniquely identifies the OPP nodes.
+  required property for all device nodes except for devices like power domains
+  or bandwidth opp tables. The power domain nodes must have another
+  (implementation dependent) property which uniquely identifies the OPP nodes.
+  The interconnect opps are required to have the opp-peak-kBps property.
+
+- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
+  big-endian integer. This is a required property for all devices that don't
+  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -132,6 +137,10 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as a
+  32-bit big-endian integer. This property is only meaningful in OPP tables
+  where opp-peak-kBps is present.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..c80a110c1e26 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kilopascal
+
+Throughput
+----------------------------------------
+-kBps		: kilobytes per second
-- 
2.24.0.393.g34dc348eaf-goog

