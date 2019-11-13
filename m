Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2FFA468
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 03:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfKMCRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 21:17:00 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17146 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfKMCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:16:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb67610000>; Tue, 12 Nov 2019 18:16:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 18:16:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 18:16:57 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 02:16:56 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 02:16:56 +0000
Received: from henryl-tu10x.nvidia.com (Not Verified[10.19.109.97]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcb67970000>; Tue, 12 Nov 2019 18:16:56 -0800
From:   Henry Lin <henryl@nvidia.com>
CC:     Henry Lin <henryl@nvidia.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb-audio: not submit urb for stopped endpoint
Date:   Wed, 13 Nov 2019 10:14:19 +0800
Message-ID: <20191113021420.13377-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112065108.7766-1-henryl@nvidia.com>
References: <20191112065108.7766-1-henryl@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573611361; bh=Tujpg7WZBoOThKGX8MEAml/VB3Yc83jertZP/WdKXl0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=C/6sf+uZj2gOMh/+HER/DbH5WOlnwdrXdu1S2kYhz3Kqc89ZAAQhoOb5k85XqhhvC
         zWY60Wd/cdyrsszASUdpJmdmOJSLpmnCE0HOHB6Ld1KH2aa40KJPP+kqE/9dgPOy4M
         S3B0nML7ZS27bkJ0DiQjuH0X+ohSrp6o5a/aOScVdxj5xK4NMzlFpOdliYYVriki45
         pMn76QfDjqIX+6NGPq5rlRl69ZjxGym+QgaAoslIKGQAK6zrDvr44DA311pJqXoPQc
         I3iyVcxdgyj0hRlIq0JD7pk+NawUf0zX1SsrG/rsrXCN5+KCPP3kXCwn8/4eACPeZ8
         XMwUJvgDueUEQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While output urb's snd_complete_urb() is executing, calling
prepare_outbound_urb() may cause endpoint stopped before
prepare_outbound_urb() returns and result in next urb submitted
to stopped endpoint. usb-audio driver cannot re-use it afterwards as
the urb is still hold by usb stack.

This change checks EP_FLAG_RUNNING flag after prepare_outbound_urb() again
to let snd_complete_urb() know the endpoint already stopped and does not
submit next urb. Below kind of error will be fixed:

[  213.153103] usb 1-2: timeout: still 1 active urbs on EP #1
[  213.164121] usb 1-2: cannot submit urb 0, error -16: unknown error

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 sound/usb/endpoint.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a2ab8e8d3a93..4a9a2f6ef5a4 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -388,6 +388,9 @@ static void snd_complete_urb(struct urb *urb)
 		}
 
 		prepare_outbound_urb(ep, ctx);
+		/* can be stopped during prepare callback */
+		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
+			goto exit_clear;
 	} else {
 		retire_inbound_urb(ep, ctx);
 		/* can be stopped during retire callback */
-- 
2.17.1

