Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214F41964D3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgC1JkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 05:40:05 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:32487
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbgC1JkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:40:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvz+NEnual14Ke6zgWe0SEOvECXdPc0yoblyy5pI5PX1Oj9AfnZ/chAFxRY5EprNqamFjW3U0rlAxj1O1Hw41DYXjoLKaY+jNixsqKThDrlDbbzOVGYOrGpLXwWXbXjAM2yiVhLDQQUbn64Hi2KZDbUvm6EtoF+s8DUy4UJMIWmHhvqAVJEpP2CO3ltCoAYSbk9zpkUWJYjEuTBHSqBHissmclSdIRC/hBG64+nhZUdZcocsZ/dPvZwcT5rM//ctn/ipFJTv4KwEDXksh+WNPBQPmHzjauU7qXk+JGXHALQ9Aw7hRrZZ2uMdNETy17CZhTNPZN9MTH+5iR1b+nkfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDgUc1rgGdo3DsiiTihP4wA0Tjhf3ICW2zGC216wAw=;
 b=end7YXQ1l3evoFD/JaLhJz7kCZBzGUNmhcCvXrGPVhr2q2OwQZ7+/o+9F2YYJT0Dw9S02uQI/k9vHvUWmIPfvbQrzbJHB+a15uvIfXeYo3vfNsH186NR/xO9Ch9T+DlPBWb0lD6yMTss+PBw9H0g8CClfkv8MpRfbPjC47IswEJhvPPSLEy5Cp9pwlOm4acIlR/TCcAWeTTm24CGLf2NcqLF4P923QSk0FGIT35Yleq4sC/9Rvx4568k7DbYqhWnX7I0UQfuSSIy2oTMmJCqgBhA+0xU1Bp0cLK1xYOnMMao1EYookxKJzIwDmfM3xnMhE0WuURrA7nLIzkmokfd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDDgUc1rgGdo3DsiiTihP4wA0Tjhf3ICW2zGC216wAw=;
 b=xcw2RTXUiAsOKjpypFGZYaWew+6p0QH4K/LJSPgUfR2sOjc8JyWsm5hMoYHVdTrAR/HAF8O+7Zi0h21IZXIRUNRTiA/7aJqrWVRhfaJ3WOb6QAtahYyyiKlymvOUvt8ziz3TD0mhhlrKxQdqhZlAmVM5v19ZzqLIjhT7cc0DTqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from MWHPR12MB1855.namprd12.prod.outlook.com (10.175.53.23) by
 MWHPR12MB1407.namprd12.prod.outlook.com (10.169.207.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Sat, 28 Mar 2020 09:39:59 +0000
Received: from MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::e438:e4ff:ef0f:27d5]) by MWHPR12MB1855.namprd12.prod.outlook.com
 ([fe80::e438:e4ff:ef0f:27d5%12]) with mapi id 15.20.2856.019; Sat, 28 Mar
 2020 09:39:59 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ASoC: AMD: Clear format bits before setting them
Date:   Sat, 28 Mar 2020 03:39:16 -0600
Message-Id: <20200328093921.32211-1-akshu.agrawal@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To MWHPR12MB1855.namprd12.prod.outlook.com
 (2603:10b6:300:10e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Elitebook.dlink.router (122.172.181.222) by MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Sat, 28 Mar 2020 09:39:49 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [122.172.181.222]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d12cf7e-b0b5-46a7-30f1-08d7d2fbfb1b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1407:|MWHPR12MB1407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14076281FFD321AF1A1333CEF8CD0@MWHPR12MB1407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:309;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1855.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(6506007)(55236004)(66556008)(316002)(86362001)(66946007)(52116002)(1076003)(66476007)(54906003)(5660300002)(478600001)(2906002)(109986005)(6512007)(956004)(2616005)(26005)(6486002)(44832011)(186003)(6666004)(8936002)(81156014)(4326008)(81166006)(16526019)(36756003)(8676002)(266003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6MoiCRBjvt0s+IeurEI7PE4dRYZpML1S+0IXFpQegYvmLFmmKNZRH2N/xtFlRJ4/x+pZJ9HxWeWX8PaVEZ8RP+ja0KjabaCyxWYUcke57KKPTPV96xrTq8nF5Bzyugj9ykhuHURpf+TFUWrXr6uSKxXYnK6q7FiM4Gk3q06rEGiUN1VUxX7zp1vhuMzQOM7b3B8wX6lFPanREcN5FPer+BueADmwhC0x8S/uvmirA7+BgJ4/zUykki0cBa3VD2ewbPQJBMqmqjryfur5nrAginEl1NQ+GA7pgjLjRcm8QLXAqie70Up8Nq6asGnyrsCZFucu4SvYjeTfeZIyKu3ZWc+GdTsG/QCZHPdGoDUC9npDHYK32IHo0pl5tYSlV43SUhPYFxamLkupVF14zNNqqYxdu9M+5dMey2YOzdw6EBx0gntoqgylcrpj+NjkvrglIFp8yzsPJ6Z+WAjdJwv66w6QWFzJUKutDOWAzu+ujE=
X-MS-Exchange-AntiSpam-MessageData: GtEyaAyg0JqJlaID3COi5CJC5n8rSzhobgHl9CyPg+3gRiUrgKJUdTPmlOkFuE6Enapbd9MTU5o2kFgH20I34ZLFP/62rY2/cEVQ01ODcuqDGUE7UsZF2zzK4FO+vVrDk71jiIc066SCRT96H2Vk3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d12cf7e-b0b5-46a7-30f1-08d7d2fbfb1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2020 09:39:59.1850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT12AjLkaZy/6IZ6tdOUKFRW0gcarSZvzluYrejPCGu5Mh7ZijOfsm3g+/nUe3FRzoQxzoflwTCdXccYaHMvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1407
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids residual bit form previous format when the format is changed.
Hence, the resultant format is not an invalid one.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-i2s.c | 1 +
 sound/soc/amd/raven/acp3x.h     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index 3a3c47e820ab..f160d35a6832 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -139,6 +139,7 @@ static int acp3x_i2s_hwparams(struct snd_pcm_substream *substream,
 		rv_writel(adata->tdm_fmt, rtd->acp3x_base + frmt_reg);
 	}
 	val = rv_readl(rtd->acp3x_base + reg_val);
+	val &= ~ACP3x_ITER_IRER_SAMP_LEN_MASK;
 	val = val | (rtd->xfer_resolution  << 3);
 	rv_writel(val, rtd->acp3x_base + reg_val);
 	return 0;
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 21e7ac017f2b..03fe93913e12 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -76,6 +76,8 @@
 #define ACP_POWERED_OFF			0x02
 #define ACP_POWER_OFF_IN_PROGRESS	0x03
 
+#define ACP3x_ITER_IRER_SAMP_LEN_MASK	0x38
+
 struct acp3x_platform_info {
 	u16 play_i2s_instance;
 	u16 cap_i2s_instance;
-- 
2.20.1

