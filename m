Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3395D78B81
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 14:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfG2MPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 08:15:04 -0400
Received: from mail-eopbgr750070.outbound.protection.outlook.com ([40.107.75.70]:46499
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726972AbfG2MPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpHGuDUfDEWIUUPrrGbzSQpbQ3n2iRt6Wh1WdZQXgvX49HJo1UZKL4nxY4pox2OlYmqMp4e313aiW9BFGgqzreXqVJjItj4oApkfyZ4FhvyIGVxUPEW4a01labxdRsOA6S9p0uRbmgConY9yEo7PFHaH3X0ZjDode/bMH37jGfMs2EG6OiX2ARsRqZcRSfFcbWVIXZQ45Lh1lBen/sZw9eOl9ofDxUpbfnoYM76SkGs1rs2L2nl0R2VJAWFaev3K0V5X2P7igfxBPe2uTHhDYnGJF6lD0X8RCKCJRkhiu2b50VwWZLOmLwA1Az5GGygcSCPTVB6Dxmdf6tGVDNxyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KibZTa7Um5IMVqKAdGaQYg7CocA3KVf7PrsxgWR+1M=;
 b=dvEwkyuL1Sc1KParvCZW4vBRAMZxAzVBETSFe3iejlSR8tVc0HkbSYSdFCLLv//e5+iWXIkZkQWhKZIssF5k86bSWPQ+kHWdVwpW/Wzg2N4hQ4xfczUPw4fm320IsmgUEcM36Mzhzo38FqMZfiaZ7GokpYEQfNCazTkYIoMWu0c85z6VjG8nWqiOsmj+rf15cmn52GYDFYhxc/XxxCmKNV5QeCJprGMvC/Z0pmEXYHhiWwx707LEUKLjCT7Kt3vxNp9276TcpfoGUYmIiGCg7dTgc5SvzqeRkDaU6sBm9luM6kHgR4aojBhAkdhSCp4SO8mn+vN4MHNpLtKZ5+J5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=embeddedor.com
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KibZTa7Um5IMVqKAdGaQYg7CocA3KVf7PrsxgWR+1M=;
 b=WCjMhcqUO6wK7chYprGTtZ36QAJ8MY9ALNq+OgZyJcAJ+rykV1iwTI66S02uBiZ3K0hOv7zBTjY5hAgvet4hhFAJd91xIcQ1Yw71nnNLpcSvQEht5DPsu1apxD5IJjA26uPjCPMXxjNobaVjqdxxoGiHJ7+JesYtQTFJWjCS+D4=
Received: from BN6PR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:405:4c::33) by DM5PR12MB2533.namprd12.prod.outlook.com
 (2603:10b6:4:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Mon, 29 Jul
 2019 12:15:01 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by BN6PR1201CA0023.outlook.office365.com
 (2603:10b6:405:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Mon, 29 Jul 2019 12:15:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; embeddedor.com; dkim=none (message not signed)
 header.d=none;embeddedor.com; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Mon, 29 Jul 2019 12:15:00 +0000
Received: from vishnu-All-Series.amd.com (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server id 14.3.389.1; Mon, 29 Jul 2019
 07:14:58 -0500
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Maruthi Bayyavarapu" <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: amd: use dma_ops of parent device for acp3x dma driver
Date:   Mon, 29 Jul 2019 17:38:30 +0530
Message-ID: <1564402115-5043-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
References: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(428003)(199004)(189003)(76176011)(70586007)(109986005)(81166006)(5660300002)(486006)(50226002)(186003)(53416004)(26005)(4326008)(53936002)(86362001)(70206006)(8936002)(81156014)(36756003)(2906002)(1671002)(48376002)(356004)(68736007)(316002)(6666004)(54906003)(478600001)(8676002)(11346002)(126002)(47776003)(305945005)(446003)(476003)(7696005)(426003)(2616005)(16586007)(336012)(51416003)(50466002)(42413003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2533;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b703bfa-16dc-436a-7b59-08d7141e6168
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5PR12MB2533;
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2533CE219EB4D3F23A6ECB80E7DD0@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 01136D2D90
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yVIkozL0GQtpIxzSGYqqmtzdTclEbIuA1pJ6xvFe1h5YYO2hgve5ANCdoIovR0jK+x8BGjgpL+N+ckLWyY0kv84HUtzwMlpxlOt/sw2lUKdv1anuh0bNpfbHaSbP5GyMgl1X+yomPMpdcexO4YCPdrwXV/w/Qnc+0xYB5hY7Hmcvh3gcuhfaHDhUzLWkO0PjMrYOamcMTM7/2exhRJS+vRzrB60kGAU8jeDNBW13xFH5SYkgJxWWywdzVq/A5iGz4yUP2Pd9Ulfyn0RvXCHTZ7/HE2lwyXmllel+V8Au9AFzQsij6ESmg0LQ+6v9ty7J8QT4hsEKQJQoYmQynpuB2RSxI9b96bu44Uw7U4lBtjiPlQqWSPMBM8wO1bq8uvAs1/8RmPngAtcGTDIKnYXqYE1uP75tVDeKVmai76Uuet8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2019 12:15:00.8653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b703bfa-16dc-436a-7b59-08d7141e6168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD platform device acp_audio_dma can only be created by parent PCI
device driver. Pass struct device of the parent
to snd_pcm_lib_preallocate_pages() so dma_alloc_coherent()
can use correct dma_ops. Otherwise, it will
use default dma_ops which is nommu_dma_ops on x86_64 even when
IOMMU is enabled and set to non passthrough mode.

Though platform device inherits some dma related fields during its
creation, we can't simply pass its struct device
to snd_pcm_lib_preallocate_pages() because dma_ops is not among the
inherited fields. Even it were, drivers/iommu/amd_iommu.c would
ignore it because get_device_id() doesn't handle platform device.

This change shouldn't give us any trouble even struct device of the
parent becomes null or represents some non PCI device in the future,
because get_dma_ops() correctly handles null struct device or uses
the default dma_ops if struct device doesn't have it set.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: Ravulapati, Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 49c4872..c74b094b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -384,9 +384,14 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
-	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      rtd->pcm->card->dev,
-					      MIN_BUFFER, MAX_BUFFER);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	struct device *parent = component->dev->parent;
+
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+							SNDRV_DMA_TYPE_DEV,
+							parent, MIN_BUFFER,
+							MAX_BUFFER);
 	return 0;
 }
 
-- 
2.7.4

