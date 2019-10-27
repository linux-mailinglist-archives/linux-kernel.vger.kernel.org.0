Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF67E61BD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2019 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfJ0JJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 05:09:48 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:47354 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbfJ0JJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 05:09:47 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9R99NMq087402
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Oct 2019 17:09:23 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 27 Oct 2019 17:09:30
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 0/2] Add SC9863A emmc and sd card support in devicetree
Date:   Sun, 27 Oct 2019 17:09:01 +0800
Message-ID: <20191027090904.14349-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9R99NMq087402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset added all sc9863a clock nodes, and also added emmc and sd
card which would use the clocks added in the patch 1/2.

Chunyan Zhang (2):
  arm64: dts: Add SC9863A clock nodes
  arm64: dts: Add SC9863A emmc and sd card nodes

 arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 125 ++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi     |  21 ++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts |  16 +++
 3 files changed, 162 insertions(+)

-- 
2.20.1


