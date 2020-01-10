Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC3136783
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 07:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbgAJGiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 01:38:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34819 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:38:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so473492plt.2;
        Thu, 09 Jan 2020 22:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzSVhJbBkfsdAFpiPcDHodKbSp7cGOHmTB0FXORy/UQ=;
        b=WQogdfYX8EoyRIeQRsfBo1hrXvhwduv2MCN8Hq/VxYtyHfbHuQDooDFwfi5+d6yq/H
         ES8lgFQZ2OE9Lad4/5fqWpIqbmj+X9nniX8KOD3RqD+0lOaYXdbG45d0/0Wnx+8AMCAk
         mcQh4a02LFafaZnrc2q3i21932DQA5s53d2lJtRcCCVBCEQp/u8UIRRrGYycAo/0dl7f
         xctReJt5Ivslf6wIpl5/bmeyYKjn4UML2WmYYMf/Rr1L6cxDjahV59d0Sb35zrfpnc+k
         5QIgsm0ffdxYoALEkuRosyngYSK0XPqEXJ80iDcx4g9YAXleUGQ6kio/ah6YFaY0dwC5
         ZLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzSVhJbBkfsdAFpiPcDHodKbSp7cGOHmTB0FXORy/UQ=;
        b=T2J9lNc7EBDYQX0K59QQec1/PcJyvMQMA7dL9m0M4DlUpZC297+uQpXFIrATXKO0xU
         5IWRz2KNDKQ/pd3eJPG67xRj8F2eYu45xZUEZYEQ+j3bY20/YvoRMng9qmTdmNmuRiiv
         ItYpiTrg+jlCMHKoRGmRmlGi4J/C2HMbL1Xx4koZYd4ynFzxYBe+/BhvKqyH603arV0b
         /uTlqhYXjpgvdhsP+IyG+FKbBBrP18GL1HxWPGTswOiUsrMtFeZMZgIL0BMXD5ISSXlr
         8syqk/oPxyztjhoODe3ehdo+Ps6Pg0wk+EJjbqYdCQFUtXW9shgZfq0ZTjJS6FpFR7SA
         pBsw==
X-Gm-Message-State: APjAAAVq5+IhlCJpTXbMFN9+mj49nLdoYByiXlxnmQFWlo1Isuk4oCqH
        XbdV8E6LIxYDKX6kQeieESc=
X-Google-Smtp-Source: APXvYqxqu2HL0oxeGEdWjvbSmrZsOd3K0PLzJecLgh6qqC+JEdXeh92VfKR6ASaQmJSsQP6XAdnpZQ==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr2382882plo.126.1578638295291;
        Thu, 09 Jan 2020 22:38:15 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m19sm1102021pjv.10.2020.01.09.22.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 22:38:14 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v6 0/2] Add Unisoc's SC9863A support
Date:   Fri, 10 Jan 2020 14:37:53 +0800
Message-Id: <20200110063755.19804-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about it on the website: http://www.unisoc.com/sc9863a

Changes from v5:
* Discarded .../bindings/arm/sprd/global-regs.yaml which will be added back
  when adding syscon into sc9863a devicetree.

Changes from v4:
* Removed syscon nodes which should be added when used.
* Added Acked-by from Rob Herring.

Changes from v3:
* Rebased on v5.5-rc1;
* Fix the cpu-map to put all cpus into the single cluster;
* Fixed a bindings error.

Changes from v2:
* Discard some dt-bindings patches which have been applied by Rob Herring.
* Added a new dt-binding file for sprd global-regs, also added a vendor directory for sprd.
* Moved sprd.yaml to the vendor directory.
* Addressed comments from Rob:
- fixed dtbs_check errors;
- move gic under to the bus node;
- removed msi-controller from gic, sinceSC9863A doesn't provide ITS;
- added specific compatible string for syscon nodes;
- cut down registers range of syscon nodes;
- removed unnecessary property "sprd,sc-id";
- added earlycon support in devicetree.

Changes from v1: 
- Convert DT bindings to json-schema.

Chunyan Zhang (2):
  dt-bindings: arm: move sprd board file to vendor directory
  arm64: dts: Add Unisoc's SC9863A SoC support

 .../bindings/arm/{ => sprd}/sprd.yaml         |   2 +-
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         | 523 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         |  78 +++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  39 ++
 5 files changed, 643 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

-- 
2.20.1

