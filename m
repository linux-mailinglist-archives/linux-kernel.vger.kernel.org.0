Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2ED677F0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 05:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGMDsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 23:48:32 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:56436 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfGMDsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 23:48:30 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 96F1C5590DB330C4950E;
        Sat, 13 Jul 2019 11:48:23 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6D3m9H7088082;
        Sat, 13 Jul 2019 11:48:09 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071311485168-2322079 ;
          Sat, 13 Jul 2019 11:48:51 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     krzk@kernel.org
Cc:     sbkim73@samsung.com, s.nawrocki@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/2] ASoC: samsung: odroid: fix err handling of odroid_audio_probe
Date:   Sat, 13 Jul 2019 11:46:13 +0800
Message-Id: <1562989575-33785-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-13 11:48:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-13 11:48:15,
        Serialize complete at 2019-07-13 11:48:15
X-MAIL: mse-fl2.zte.com.cn x6D3m9H7088082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We developed a coccinelle SmPL to detect sound/soc/samsung/odroid.c and
found some use-after-free problems.
This patch series fixes those problems.

Wen Yang (2):
  ASoC: samsung: odroid: fix an use-after-free issue for codec
  ASoC: samsung: odroid: fix a double-free issue for cpu_dai

 sound/soc/samsung/odroid.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org

-- 
2.9.5

