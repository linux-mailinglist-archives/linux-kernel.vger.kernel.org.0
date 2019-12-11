Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E011ABA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 14:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfLKNJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 08:09:56 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60192 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729504AbfLKNJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:50 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48ZO020455;
        Wed, 11 Dec 2019 05:09:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=BbD+9sSBwg1SonOqzIWHLbLR/X/vStAHdiFy5mj4Eyzf0UN/FNM9PjhleUsTdYJY4G0p
 bdmtEyuclkaLThV5FqsFjNIv8GM4BORL4aebNA2VmoshBeeb8IaV5v19uHPI2YiHXoq6
 1NtSE2l6FBmWg8S4ZcbGqVBReOAW5WMjBl4yjz/7j+/6Fef3cssvpjNkojZj1zRw/bie
 V4xuMSs3W0W8k3qhLz7ZQHxyi+FsEElGrJOi3Mw11zF4Se4N3AmgTVPJwY1QvrshMwz7
 4wuPMLlquJttI+SCasREoVLezNUMsVzystRNmHSsVONDKErN/tclV3CCQa1AXVuAPHnA NA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp68w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5HaoSAhH1OSKKWqvvFmFOq/qik06DdQdEvkjji7Tn3zfOMvyaBVUMmg0IV5376Q5mb6XLonoY+dWY2WSofqLBXVTW9JhLH06B61LoMNTttS96PVH/UeTJgsa67pZIdrLQjLIYWdH/yncz1Mhoaqhi9vpNXyCJ6EhXQa7m7smnMNHn9oeNePQNyD8Y3BqWiTLvs9JXbIRv8BAizKeJ1goQnRnBv6EpOkcblLkWGVUcW1nYqiF/QYEm1I7W7mP9nxjHO381P6iNQi0OeyW4VzPKofPId0KDUuiJgknychnfQ72Ow+/a4TrXdFXbNyljJ19U0xfQICOfHxfbrdtk7YxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=RAYkydnacvBc+YsdIiIE9if3bf4GKAKjF+Umy+807DUcANutYTjMM75z9jmcLpRpoTfnBjn/2aVgXXw9OW5rhS3ZdwrOGbD6Ty0oRkE27ZwRGqFheAkgxunUX0hzkMA9xAla+EoLe5ar8Z1uaFQXJ1M1Ir3HpDo5yWvTPt9sF4vkowhgHtYfKDTwJ+2X7oGpKepKHNrGVMtpNIzuhXyMuXSBEd5g/kTuxCwK1xhtK6CgqN46+KbrIliPerbcoDTLBK8BTgTWMwOG1jsxMW0MA1p/zkkzGPnrwNRZdh/JnHkgNg6BWd3PQVND0CBblmb+f2bSfpPnRGVfEpGF90LH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMwYk7Vbk+GcfyXCnGEzljsLjF9Ya23s2syjQo+6bT8=;
 b=wMVaBkcANczmZxTnLbn/r/GfDhywy3VJZ0ub+2Jjhmx+H111Ia7E7T+Tb41byKNx2Dm5GmugeRXcKU71xtkxaodEfXAOuetuGWFNmjkhWk5/pE1Pa0CRZDtlkXcVtyZi9nyg+6CY08L9fjA9Rjg571HyPoCY66Rn2yfqK9ZQbac=
Received: from BYAPR07CA0031.namprd07.prod.outlook.com (2603:10b6:a02:bc::44)
 by DM6PR07MB6012.namprd07.prod.outlook.com (2603:10b6:5:185::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Wed, 11 Dec
 2019 13:09:42 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by BYAPR07CA0031.outlook.office365.com
 (2603:10b6:a02:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:42 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5o006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:39 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9Oug011717;
        Wed, 11 Dec 2019 14:09:24 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9OhE011716;
        Wed, 11 Dec 2019 14:09:24 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 15/15] phy: cadence-torrent: Add platform dependent initialization structure
Date:   Wed, 11 Dec 2019 14:09:20 +0100
Message-ID: <1576069760-11473-16-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36092001)(8676002)(478600001)(81156014)(26826003)(86362001)(2906002)(70586007)(81166006)(70206006)(107886003)(8936002)(36756003)(4744005)(4326008)(2616005)(336012)(186003)(26005)(426003)(54906003)(110136005)(356004)(42186006)(316002)(76130400001)(5660300002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6012;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88414cc-5d83-4c71-8cbc-08d77e3b6281
X-MS-TrafficTypeDiagnostic: DM6PR07MB6012:
X-Microsoft-Antispam-PRVS: <DM6PR07MB60125B443052969577897AC7D25A0@DM6PR07MB6012.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WynLurFZEBlD7EBUeGXeTZ5czIXO89Mscf0iWT9m7JLDuhQPE2NcA7BwDsvx2uGVEifDRd55C9ImI3Q1nprYewrFRSQ76v/Jrd7Yd69/GIprpj66c3TCxQCDBShrZVean4qo5+Yr2sDtqBQSmntRxbkXetquyT1O2mUDAnVbNz/V8HJTWCND+DnpkAF/UGqYDtbpWs+76HFFyr5lJqa3QGtgXGCciokAFO0whVv6W/FQUyA4a0QcMVkNb409J66zpspKeGEHIXi7dVlJsRfn0bFyvMqNdFDVt6QtUHqvjjlkaFSzJjx2WCAhrEsF9WHG8PNSb8uKGdwUvbKAHl5XySHnm33cmdB1h/3ODsDXwVlNKbIadQT2RHk16V3PrnK3ym9FuAPUuT+0kb7UawJNveIxQ9vbw8gjGliJRk0hkdbY3FTl+22MJH5nHynMy6r7IcIDezz1vmrk8ro4AvuHxJ5kHegWZ4PUIzYGc6D8RqqGmmiTo012yPo22xwaPS/u
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:41.5581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a88414cc-5d83-4c71-8cbc-08d77e3b6281
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6012
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform dependent initialization data for Torrent PHY used in TI's
J721E SoC.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a64ed4b..29e125b 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1792,11 +1792,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 };
 
+static const struct cdns_torrent_data ti_j721e_map_torrent = {
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy",
 		.data = &cdns_map_torrent,
 	},
+	{
+		.compatible = "ti,j721e-serdes-10g",
+		.data = &ti_j721e_map_torrent,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
-- 
2.7.4

