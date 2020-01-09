Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1112135020
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgAHXyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 18:54:52 -0500
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:11448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbgAHXyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:54:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhC9kJNthpFkKAZGmncAlfb7f2pGX5I1NtiTYSGC6oYs4NrcVlyg1XqlMRqXEDJ0jPHMg8nUTBHneR2Ooigea6fOI7T2ouLbnBwRpafZwIgfe8MebFis0RAJNjpDpXPxASOKRDtRxbJAJVPoOzlTtd3QZeAGnAwWML6tK2kbxN5bER5RwQyh2ZawzQDUWiRpWqUTs5IW8S7vevNK5CyOcpF7ZGIaKMbtCdbO8SX8oZak2DbXNqJcO8tGuVl7jIuPqwtsb3jRFCyoM6H/PhgR/e4ME4b4Mr6shKMryljZXxf8yl+ZGggcy8D+AXk8JlVT3RpEAScysiqdf6Rh6h8A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N64uWFrytHW+OU/7Ez1on4A5D52e8waC62XguFC9tE=;
 b=jII9z5rCkG3BS8Op2oXNrcaCi5LMluf3fGDUyjYUxZr2GNuHX6dobu04Dnfs6llGtnNlFshkFpD+bO7Ay4Izv37WyjyZ2424uJtuX7v8GpjoYXmzaJMR6ypP1j5AgXFayABitiarKi3NITjs8DzgHgy7Ud0TjG9XliC3Xy4Rn4cZgfgcz9B2XAonJEtWK7HYwkEOm7e8aLUqcROS89Xv2V0WpNkgwxlEVgYf3BnLA61NtVTwVZXiHB3GBfmJK8IWwHzLNnNSH8/cfZHa3Xft4FBiz8N+cmKD74wm+Ol4uKN4u4Df0urr8Imt6Zc+0dwgY8dWEP7H0QKp3tNObcgyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N64uWFrytHW+OU/7Ez1on4A5D52e8waC62XguFC9tE=;
 b=kjdPOi1FX8rdIwHWPJqDra0cHI30TEbHVxLXtaCQEdqvXt07Px5tt9Sl33b0EgQASXIV5PhvaGSgRN3L7DUttGe9HyQXH6Vq2b17hnBhwX2gKfucc3VEvRQtqvjn0p3A9ZEfQzx6y4AWLkRXhaLZci0W+4wsjO65c4San33xLQ4=
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by DM6PR02MB5641.namprd02.prod.outlook.com (2603:10b6:5:77::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Wed, 8 Jan
 2020 23:54:48 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 23:54:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Wed, 8 Jan 2020 23:54:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9z-0003pw-9T; Wed, 08 Jan 2020 15:54:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9u-0002BN-57; Wed, 08 Jan 2020 15:54:42 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ipL9l-0002A4-HV; Wed, 08 Jan 2020 15:54:33 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: [PATCH v2 0/4] firmware: xilinx: Add xilinx specific sysfs interface
Date:   Wed,  8 Jan 2020 15:54:19 -0800
Message-Id: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(199004)(189003)(426003)(7696005)(498600001)(8936002)(336012)(8676002)(356004)(6666004)(7416002)(2616005)(81166006)(44832011)(5660300002)(81156014)(186003)(26005)(6636002)(2906002)(70586007)(9786002)(107886003)(4326008)(36756003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5641;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae9cc7df-42cb-406d-1f5e-08d7949624eb
X-MS-TrafficTypeDiagnostic: DM6PR02MB5641:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5641CD6975F7A377BFCD2D14B83E0@DM6PR02MB5641.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrhrU4MZfFPDQEX6QI2RUk7/TO8ta3haoMqBC4l3xAu8Z/ijI3I7KZnhwFATJN8N+NxX+zOoNNpj5BAHD/pKt5emTWFke5XsrYVZWC6as3AXYDEpHF49e73pmuCkCnWVk29B5yNaANkLP1cT1cnGrDWm+JDBg+RIAdou8VLhDS06Eq8x+New1K6LDR9KQWIXXgRpQCjXd1pJpe5LZEs0Hw+94sFJ/sNkPvs/yfeNhbDhw5dck0Eu5HxpwKyC2CBczSUO/XU/I9vi9u95HWnSmkmAJypk0piRRKjXmZUtWdWDQ18/muToJk+CTjJz6T1pga6x4vnXKjh8NBN5CaJZsI9KGgr2Hy1kynzkBgD+QavUfMpifmXcnyKdOgdOnjdYjMHdMmr+LuIzqGt3272KnaAZCNi1cSFP3YyYUwoxBs1kONyZoM6/jGsf1yC0RJQ2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 23:54:47.9607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9cc7df-42cb-406d-1f5e-08d7949624eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

This patch series adds xilinx specific sysfs interface for below
purposes:
- Register access
- Set shutdown scope
- Set boot health status bit

Rajan Vaja (4):
  firmware: xilinx: Add sysfs interface
  firmware: xilinx: Add system shutdown API interface
  firmware: xilinx: Add sysfs to set shutdown scope
  firmware: xilinx: Add sysfs and IOCTL to set boot health status

 Documentation/ABI/stable/sysfs-firmware-zynqmp | 103 +++++++++
 drivers/firmware/xilinx/Makefile               |   2 +-
 drivers/firmware/xilinx/zynqmp-ggs.c           | 284 +++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c               | 242 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h           |  28 ++-
 5 files changed, 657 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-firmware-zynqmp
 create mode 100644 drivers/firmware/xilinx/zynqmp-ggs.c

--
Changes in v2:
 - Removed patch #1 for register access sysfs.
 - Updated kernel version in documentation.
 - Used DEVICE_ATTR_* and ATTRIBUTE_GROUPS macros.
 - Correct typo
 - Free Kobject structure in case of error.
 - Resolved smatch errors.
 - Updated Signed-off-by sequence.
-- 
2.7.4

