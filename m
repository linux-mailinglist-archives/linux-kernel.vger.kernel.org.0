Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50236F700D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 10:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfKKJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 04:03:17 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:40126 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726768AbfKKJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:03:16 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id xAB92QK1059110
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 11 Nov 2019 17:02:27 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.88) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 11 Nov 2019 17:02:44
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 0/5] Add Unisoc's SC9863A support
Date:   Mon, 11 Nov 2019 17:02:25 +0800
Message-ID: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.88]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com xAB92QK1059110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


SC9863A has Octa-core ARM Cortex A55 application processor. Find more
details about it on the website: http://www.unisoc.com/sc9863a

This patch-set also convert sprd.txt and sprd-uart.txt to json-schema.

Changes from V1: 
- Convert DT bindings to json-schema.

Chunyan Zhang (5):
  dt-bindings: arm: Convert sprd board/soc bindings to json-schema
  dt-bindings: serial: Convert sprd-uart to json-schema
  dt-bindings: arm: Add bindings for Unisoc SC9863A
  dt-bindings: serial: Add a new compatible string for SC9863A
  arm64: dts: Add Unisoc's SC9863A SoC support

 .../devicetree/bindings/arm/sprd.txt          |  14 -
 .../devicetree/bindings/arm/sprd.yaml         |  33 ++
 .../devicetree/bindings/serial/sprd-uart.txt  |  32 --
 .../devicetree/bindings/serial/sprd-uart.yaml |  70 +++
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         | 536 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi         | 188 ++++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts     |  40 ++
 8 files changed, 869 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts

-- 
2.20.1


