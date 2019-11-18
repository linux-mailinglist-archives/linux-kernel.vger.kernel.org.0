Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B471002D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 11:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfKRKrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 05:47:04 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:41094 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRKrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:47:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3D39F43597;
        Mon, 18 Nov 2019 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1574074021; x=
        1575888422; bh=WSfhOJmQyfFAWkKlccMB2tHDhi2Hlxmn98sJpTThN/k=; b=b
        gu+9u0iI67pDCnf5ECJzVpYatLNW7cJPntbEfkA5SbBfLx+OYm0NRQ+dcaK9e5yC
        QxsTm9W85+k8cLH75HhQ+jyvK5ysRNGHCxSTN831UUQcPyC0Fag/DGgC/Q3dLVBI
        5oRIWl0j6Dj3zVTYp5uAcFnKuOhONrWERlOrHKO4X0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tc8DqeEH5YAN; Mon, 18 Nov 2019 13:47:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1BEB042009;
        Mon, 18 Nov 2019 13:47:00 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 18 Nov 2019 13:46:59 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 0/3] add inversion signal presence support
Date:   Mon, 18 Nov 2019 13:46:43 +0300
Message-ID: <20191118104646.3838-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vesnin BMC uses microSD with card presence signal inversion in the
schematics. Add the .read_l callback to detect 'cd-inverted' option
in dts. There is no WP switch, due to this 'disable-wp' also was added
into vesnin dts for sdhci.

Ivan Mikhaylov (3):
  aspeed: dts: add sd card for vesnin
  mmc: sdhci-of-aspeed: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-of-aspeed: add inversion signal presence

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 +++++++++++++
 drivers/mmc/host/Kconfig                    |  1 +
 drivers/mmc/host/sdhci-of-aspeed.c          | 12 ++++++++++++
 3 files changed, 26 insertions(+)

-- 
2.20.1

