Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F65FC6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 07:54:58 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:33584 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfKNMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:54:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5E4AE42F10;
        Thu, 14 Nov 2019 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1573736095; x=
        1575550496; bh=1/0Qq+Pqgb4cXnVt9/BiuEK56501fDFv5qyLnmzGrmI=; b=g
        sYR//M5dLQ50dw7ob/6JBxGwYq8Snd8dY/OhCsorE8P7T/Gp9hp780lNehGiEO6n
        GXqgeaZjOY9u3S4jsuHE3UEIhJz9qCS7GlHvsbyq64vnURwthcpq0621saCIFepu
        rXLtOnt3lFYyMDAwGzM7HQstnkYODcgYO79nvE4dcQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jq82iZ7X5c2u; Thu, 14 Nov 2019 15:54:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 085C3411D9;
        Thu, 14 Nov 2019 15:54:53 +0300 (MSK)
Received: from localhost.dev.yadro.com (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 14 Nov 2019 15:54:53 +0300
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
Subject: [PATCH v2 0/2] add inversion signal presence support
Date:   Thu, 14 Nov 2019 15:54:33 +0300
Message-ID: <20191114125435.27756-1-i.mikhaylov@yadro.com>
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
schematics. Change the .get_cd callback to detect 'cd-inverted' option
in dts. There is no WP switch, due to this 'disable-wp' also was added
into vesnin dts for sdhci.

Ivan Mikhaylov (2):
  aspeed: dts: add sd card for vesnin
  mmc: sdhci-of-aspeed: add inversion signal presence

 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 13 +++++++++++++
 drivers/mmc/host/sdhci-of-aspeed.c          | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.20.1

