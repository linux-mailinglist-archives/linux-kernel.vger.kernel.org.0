Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC817177473
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 11:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgCCKpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 05:45:52 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:47599 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbgCCKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:45:52 -0500
Received: from [100.113.1.168] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 57/9F-43233-D553E5E5; Tue, 03 Mar 2020 10:45:49 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRWlGSWpSXmKPExsVy8IPnUd1Y07g
  4g08rtSzufz3KaHF51xw2ByaPO9f2sHl83iQXwBTFmpmXlF+RwJrx/e5v1oI9rBW/u7tYGhg3
  sHQxcnEICaxjlPh16C1TFyMnkFMhsXLBTnYQm1fATeLbwdPMIDabgIXE5BMP2LoYOThYBFQkn
  p0NAgkLCwRI7D4wiREkLAIUPvfGHMRkFoiQ+HOKGWKIoMTJmU9YQGxmAQmJgy9eMEMsMpA4va
  CRZQIj9ywkZbOQlC1gZFrFaJlUlJmeUZKbmJmja2hgoGtoaKwLJI3M9RKrdBP1Ukt1k1PzSoo
  SgbJ6ieXFesWVuck5KXp5qSWbGIHBk1LIUL+DcfPa93qHGCU5mJREeTOF4uKE+JLyUyozEosz
  4otKc1KLDzHKcHAoSfDOMQbKCRalpqdWpGXmAAMZJi3BwaMkwpsOkuYtLkjMLc5Mh0idYtTl2
  Hl03iJmIZa8/LxUKXHeqSBFAiBFGaV5cCNgUXWJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkj
  BvMMgUnsy8ErhNr4COYAI6oud5NMgRJYkIKakGJgFZ5gUPF2h8dxLnPtRtc8681n9hQJTfx4p
  DiY/OdwXHtGQlbF4h/mfy77k7uY9KVR5WEVXzkZJ6vvVS6dxG/e+vdrK9zoixCTw9+7Io16FL
  KVt4mTJTw/I/8f2YLyAvwbnKbocQv3Kks++MP/N8vWa0b64NTltoL3sw8P0BE1Uhu8MLW1Mk5
  v6R6t13vtLsjGrFzI3bFyx4/MJWO/e3yY5dU2MaApcxrHp0+Anbsf8fQ+oz92/5mttttOu+4/
  sL3zMLZkju2fjsxNc92ctuHd66g/2nxIUtrBEqDoa7Axl150jstZp/iOvsS5cEttZDfn01nxQ
  bcvYsKU1yPfjztGjalW/Lm54LHHjyd8XWf/OUWIozEg21mIuKEwHz2GFeJQMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-233.messagelabs.com!1583232349!325232!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19376 invoked from network); 3 Mar 2020 10:45:49 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-3.tower-233.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 3 Mar 2020 10:45:49 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Mar 2020 10:45:48 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 5C7883FB8D; Tue,  3 Mar 2020 10:45:48 +0000 (GMT)
Message-ID: <cover.1583231441.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 3 Mar 2020 10:45:48 +0000
Subject: [PATCH v2 0/2] Resolve revision handling and add support for DA silicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set fixes the currently broken revision handling in the driver's
i2c_probe() function and then adds DA support to existing permitted revisions.

v2:
 - Use raw I2C read access instead of a temporary regmap to interrogate chip and
   variant id registers

Adam Thomson (2):
  mfd: da9063: Fix revision handling to correctly select reg tables
  mfd: da9063: Add support for latest DA silicon revision

 drivers/mfd/da9063-core.c            |  31 -----
 drivers/mfd/da9063-i2c.c             | 249 +++++++++++++++++++++++++++++++----
 include/linux/mfd/da9063/core.h      |   1 +
 include/linux/mfd/da9063/registers.h |  15 ++-
 4 files changed, 235 insertions(+), 61 deletions(-)

-- 
1.9.1

