Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1918BC51
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 17:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgCSQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 12:23:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42146 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCSQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:23:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNPju025486;
        Thu, 19 Mar 2020 11:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584635005;
        bh=20n0HqjF+ewAj1VUUqVCvm1rvpktMCiyDIRZDR5M10g=;
        h=From:To:CC:Subject:Date;
        b=Ad2uAC7VTvgpLX8t3mGTfXxndxyqmauSj7IQYwPIXqpZ1AgYwnGAZnyrDgWITEAKM
         iq4Vy6+VWO+ziHyaNQ+OL5xbDRZitpG4AxS6EpS9EIhd6bvj1CriT32vRcOsNztsUC
         gjntWRk8nw+vPm/CfFP5+4kOLwR2uzV/dikOKQ60=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JGNPII096778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 11:23:25 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 11:23:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 11:23:25 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNPCL043207;
        Thu, 19 Mar 2020 11:23:25 -0500
Received: from localhost ([10.250.86.212])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02JGNOFN066541;
        Thu, 19 Mar 2020 11:23:24 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/2] Misc. rproc fixes around fixed memory region support
Date:   Thu, 19 Mar 2020 11:23:19 -0500
Message-ID: <20200319162321.20632-1-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a minor revised version of the fixes around fixed memory region
support [1]. Patch 1 is updated to address Arnaud's review comments about 
the hard-coded memory region.

Please see the v1 cover-letter [1] for the details on the issues.

regards
Suman

[1] https://patchwork.kernel.org/cover/11422723/

Suman Anna (1):
  remoteproc: Fix and restore the parenting hierarchy for vdev

Tero Kristo (1):
  remoteproc: fall back to using parent memory pool if no dedicated
    available

 drivers/remoteproc/remoteproc_core.c   |  2 +-
 drivers/remoteproc/remoteproc_virtio.c | 15 +++++++++++++++
 include/linux/remoteproc.h             |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.23.0

