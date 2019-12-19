Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504AD126F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 22:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfLSVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 16:10:02 -0500
Received: from node.akkea.ca ([192.155.83.177]:35410 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfLSVKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:10:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 856564E2010;
        Thu, 19 Dec 2019 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576789801; bh=TDb2mIF0Kmrb+qb9673eOhT31g+D8vn8VUifumGYZy4=;
        h=From:To:Cc:Subject:Date;
        b=baRoBN8YsGPPc6Z+lXJVr/GhZ2lsmwlxGzGXOiQDN+DM6K4C+3pUE0GRPq2AHh/Zg
         NIaliwO947aZXcUjx2EG23XmIuCzt2IpcMDEeVRFvTLEzDnUK+GE+fhOVPUAhcISP9
         EtJwMQ3v1QLKzuIH33sBWs0mLDEsGcrnZ8pYR7OM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gJ-Fhp2u47C0; Thu, 19 Dec 2019 21:10:01 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id CFC9D4E2003;
        Thu, 19 Dec 2019 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1576789801; bh=TDb2mIF0Kmrb+qb9673eOhT31g+D8vn8VUifumGYZy4=;
        h=From:To:Cc:Subject:Date;
        b=baRoBN8YsGPPc6Z+lXJVr/GhZ2lsmwlxGzGXOiQDN+DM6K4C+3pUE0GRPq2AHh/Zg
         NIaliwO947aZXcUjx2EG23XmIuCzt2IpcMDEeVRFvTLEzDnUK+GE+fhOVPUAhcISP9
         EtJwMQ3v1QLKzuIH33sBWs0mLDEsGcrnZ8pYR7OM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     broonie@kernel.org
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH v3 0/2] Add the broadmobi BM818
Date:   Thu, 19 Dec 2019 13:09:42 -0800
Message-Id: <20191219210944.18256-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Changes since v2:

Use of_device_get_match_data to get the dai data.
Updated subject styles.

Changes since v1:

Cut back the CC list.
Use data from compatible match instead of explicit compatible match.


Angus Ainslie (Purism) (2):
  ASoC: gtm601: add Broadmobi bm818 sound profile
  dt-bindings: sound: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 ++++--
 sound/soc/codecs/gtm601.c                     | 31 ++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.17.1

