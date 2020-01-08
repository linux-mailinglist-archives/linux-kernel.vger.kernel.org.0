Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21C1344FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 15:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgAHObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 09:31:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52266 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgAHObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:31:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008EVU1W045107;
        Wed, 8 Jan 2020 08:31:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578493890;
        bh=7qypsg5FkYz9i8UxR7GC2+Bf+JTmvCPh5C62wFh3T6I=;
        h=From:To:CC:Subject:Date;
        b=wQSvzxblwslAi3Tu23rRlp4IZRY4A5U+Y7FX/gSjpJ9GmaKuzBHQpuNwEY0KY1gf0
         JJjyBLuBX2qKUkd+huhoWZZ+Zj1sYkmsk1n1ZN/6S34UILs5EmqCQtpxdJeQ4D2wH1
         +xqpjUZKF8rx0cUo/jAjN9y12GdjfmiUlSQItIH0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVUJS049214;
        Wed, 8 Jan 2020 08:31:30 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 08:31:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 08:31:30 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008EVS9U112013;
        Wed, 8 Jan 2020 08:31:28 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Fixes for Am65x controllers
Date:   Wed, 8 Jan 2020 20:02:58 +0530
Message-ID: <20200108143301.1929-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following are some fixes for sdhci_am654 driver.

Patch 3 depends on patch 2.

v1 of patch 2 was posted:
https://patchwork.kernel.org/project/linux-mmc/list/?series=222279

Faiz Abbas (3):
  mmc: sdhci_am654: Remove Inverted Write Protect flag
  mmc: sdhci_am654: Reset Command and Data line after tuning
  mmc: sdhci_am654: Fix Command Queuing in AM65x

 drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 19 deletions(-)

-- 
2.19.2

