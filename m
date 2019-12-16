Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB75120479
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 12:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfLPLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 06:55:55 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:38362 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbfLPLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:55:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576497351; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=yr368A1U8+Ymzyj50vnz3Ib8PJaaegeu+ZGhjpsOx28=; b=G7qQCZKggwXAiXK/nTXAhXT1MAEduplKfYMFHfpYp6Ahmn1lSEXESGbh8ifyLejlcOPtM/ti
 okSkz1aJBWxcmSiiR/qNpVtIM+fVmz1qRjmTI64ohjd7vPurxFR0fAObogD/O9js0ETA8mfj
 f4z/qBcU9kUC3OV/nRMKlMfOg7M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df770c6.7fc4b062c768-smtp-out-n01;
 Mon, 16 Dec 2019 11:55:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0648C4479D; Mon, 16 Dec 2019 11:55:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F76DC447A2;
        Mon, 16 Dec 2019 11:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F76DC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        rnayak@codeaurora.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, swboyd@chromium.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: power: rpmpd: Convert rpmpd bindings to yaml
Date:   Mon, 16 Dec 2019 17:25:30 +0530
Message-Id: <20191216115531.17573-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191216115531.17573-1-sibis@codeaurora.org>
References: <20191216115531.17573-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RPM/RPMH power-domain bindings to yaml.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt  | 150 ----------------
 .../devicetree/bindings/power/qcom,rpmpd.yaml | 170 ++++++++++++++++++
 2 files changed, 170 insertions(+), 150 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
deleted file mode 100644
index 6346d00b1b400..0000000000000
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ /dev/null
@@ -1,150 +0,0 @@
-Qualcomm RPM/RPMh Power domains
-
-For RPM/RPMh Power domains, we communicate a performance state to RPM/RPMh
-which then translates it into a corresponding voltage on a rail
-
-Required Properties:
- - compatible: Should be one of the following
-	* qcom,msm8976-rpmpd: RPM Power domain for the msm8976 family of SoC
-	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
-	* qcom,msm8998-rpmpd: RPM Power domain for the msm8998 family of SoC
-	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404 family of SoC
-	* qcom,sc7180-rpmhpd: RPMh Power domain for the sc7180 family of SoC
-	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
-	* qcom,sm8150-rpmhpd: RPMh Power domain for the sm8150 family of SoC
- - #power-domain-cells: number of cells in Power domain specifier
-	must be 1.
- - operating-points-v2: Phandle to the OPP table for the Power domain.
-	Refer to Documentation/devicetree/bindings/power/power_domain.txt
-	and Documentation/devicetree/bindings/opp/opp.txt for more details
-
-Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
-various OPPs for different platforms as well as Power domain indexes
-
-Example: rpmh power domain controller and OPP table
-
-#include <dt-bindings/power/qcom-rpmhpd.h>
-
-opp-level values specified in the OPP tables for RPMh power domains
-should use the RPMH_REGULATOR_LEVEL_* constants from
-<dt-bindings/power/qcom-rpmhpd.h>
-
-	rpmhpd: power-controller {
-		compatible = "qcom,sdm845-rpmhpd";
-		#power-domain-cells = <1>;
-		operating-points-v2 = <&rpmhpd_opp_table>;
-
-		rpmhpd_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			rpmhpd_opp_ret: opp1 {
-				opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
-			};
-
-			rpmhpd_opp_min_svs: opp2 {
-				opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
-			};
-
-			rpmhpd_opp_low_svs: opp3 {
-				opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
-			};
-
-			rpmhpd_opp_svs: opp4 {
-				opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
-			};
-
-			rpmhpd_opp_svs_l1: opp5 {
-				opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
-			};
-
-			rpmhpd_opp_nom: opp6 {
-				opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
-			};
-
-			rpmhpd_opp_nom_l1: opp7 {
-				opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
-			};
-
-			rpmhpd_opp_nom_l2: opp8 {
-				opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
-			};
-
-			rpmhpd_opp_turbo: opp9 {
-				opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
-			};
-
-			rpmhpd_opp_turbo_l1: opp10 {
-				opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
-			};
-		};
-	};
-
-Example: rpm power domain controller and OPP table
-
-	rpmpd: power-controller {
-		compatible = "qcom,msm8996-rpmpd";
-		#power-domain-cells = <1>;
-		operating-points-v2 = <&rpmpd_opp_table>;
-
-		rpmpd_opp_table: opp-table {
-			compatible = "operating-points-v2";
-
-			rpmpd_opp_low: opp1 {
-				opp-level = <1>;
-			};
-
-			rpmpd_opp_ret: opp2 {
-				opp-level = <2>;
-			};
-
-			rpmpd_opp_svs: opp3 {
-				opp-level = <3>;
-			};
-
-			rpmpd_opp_normal: opp4 {
-				opp-level = <4>;
-			};
-
-			rpmpd_opp_high: opp5 {
-				opp-level = <5>;
-			};
-
-			rpmpd_opp_turbo: opp6 {
-				opp-level = <6>;
-			};
-		};
-	};
-
-Example: Client/Consumer device using OPP table
-
-	leaky-device0@12350000 {
-		compatible = "foo,i-leak-current";
-		reg = <0x12350000 0x1000>;
-		power-domains = <&rpmhpd SDM845_MX>;
-		operating-points-v2 = <&leaky_opp_table>;
-	};
-
-
-	leaky_opp_table: opp-table {
-		compatible = "operating-points-v2";
-
-		opp1 {
-			opp-hz = /bits/ 64 <144000>;
-			required-opps = <&rpmhpd_opp_low>;
-		};
-
-		opp2 {
-			opp-hz = /bits/ 64 <400000>;
-			required-opps = <&rpmhpd_opp_ret>;
-		};
-
-		opp3 {
-			opp-hz = /bits/ 64 <20000000>;
-			required-opps = <&rpmpd_opp_svs>;
-		};
-
-		opp4 {
-			opp-hz = /bits/ 64 <25000000>;
-			required-opps = <&rpmpd_opp_normal>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
new file mode 100644
index 0000000000000..4aebf024e4427
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/qcom,rpmpd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPM/RPMh Power domains
+
+maintainers:
+  - Rajendra Nayak <rnayak@codeaurora.org>
+
+description:
+  For RPM/RPMh Power domains, we communicate a performance state to RPM/RPMh
+  which then translates it into a corresponding voltage on a rail
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8976-rpmpd
+      - qcom,msm8996-rpmpd
+      - qcom,msm8998-rpmpd
+      - qcom,qcs404-rpmpd
+      - qcom,sc7180-rpmhpd
+      - qcom,sdm845-rpmhpd
+      - qcom,sm8150-rpmhpd
+
+  '#power-domain-cells':
+    const: 1
+
+  operating-points-v2: true
+
+  opp-table:
+    type: object
+
+required:
+  - compatible
+  - '#power-domain-cells'
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+
+    // Example 1 (rpmh power domain controller and OPP table):
+
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    rpmhpd: power-controller {
+      compatible = "qcom,sdm845-rpmhpd";
+      #power-domain-cells = <1>;
+      operating-points-v2 = <&rpmhpd_opp_table>;
+
+      rpmhpd_opp_table: opp-table {
+        compatible = "operating-points-v2";
+
+        rpmhpd_opp_ret: opp1 {
+          opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+        };
+
+        rpmhpd_opp_min_svs: opp2 {
+          opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+        };
+
+        rpmhpd_opp_low_svs: opp3 {
+          opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+        };
+
+        rpmhpd_opp_svs: opp4 {
+          opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+        };
+
+        rpmhpd_opp_svs_l1: opp5 {
+          opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+        };
+
+        rpmhpd_opp_nom: opp6 {
+          opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+        };
+
+        rpmhpd_opp_nom_l1: opp7 {
+          opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+        };
+
+        rpmhpd_opp_nom_l2: opp8 {
+          opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+        };
+
+        rpmhpd_opp_turbo: opp9 {
+          opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+        };
+
+        rpmhpd_opp_turbo_l1: opp10 {
+          opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+        };
+      };
+    };
+
+  - |
+
+    // Example 2 (rpm power domain controller and OPP table):
+
+    rpmpd: power-controller {
+      compatible = "qcom,msm8996-rpmpd";
+      #power-domain-cells = <1>;
+      operating-points-v2 = <&rpmpd_opp_table>;
+
+      rpmpd_opp_table: opp-table {
+        compatible = "operating-points-v2";
+
+        rpmpd_opp_low: opp1 {
+          opp-level = <1>;
+        };
+
+        rpmpd_opp_ret: opp2 {
+          opp-level = <2>;
+        };
+
+        rpmpd_opp_svs: opp3 {
+          opp-level = <3>;
+        };
+
+        rpmpd_opp_normal: opp4 {
+          opp-level = <4>;
+        };
+
+        rpmpd_opp_high: opp5 {
+          opp-level = <5>;
+        };
+
+        rpmpd_opp_turbo: opp6 {
+          opp-level = <6>;
+        };
+      };
+    };
+
+  - |
+
+    // Example 3 (Client/Consumer device using OPP table):
+
+    leaky-device0@12350000 {
+      compatible = "foo,i-leak-current";
+      reg = <0x12350000 0x1000>;
+      power-domains = <&rpmhpd 0>;
+      operating-points-v2 = <&leaky_opp_table>;
+    };
+
+    leaky_opp_table: opp-table {
+      compatible = "operating-points-v2";
+      opp1 {
+        opp-hz = /bits/ 64 <144000>;
+        required-opps = <&rpmhpd_opp_low>;
+      };
+
+      opp2 {
+        opp-hz = /bits/ 64 <400000>;
+        required-opps = <&rpmhpd_opp_ret>;
+      };
+
+      opp3 {
+        opp-hz = /bits/ 64 <20000000>;
+        required-opps = <&rpmpd_opp_svs>;
+      };
+
+      opp4 {
+        opp-hz = /bits/ 64 <25000000>;
+        required-opps = <&rpmpd_opp_normal>;
+      };
+    };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
