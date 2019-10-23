Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5251EE2041
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407099AbfJWQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 12:12:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407041AbfJWQMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:12:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so20241040wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5N0IJFJExNFmNBBJWrgzz5LRbQ4JRTZ0BkV4z06vqY0=;
        b=chwLkcmOiUAEQsrWzVQkh32ufJ0dzqhyj+TT5Mvf0JSZNyRKjOsR0F9hP5JPFyUQFV
         KRwWLt6frNQT8guB1ypjCT7BpaNXJvDi6lH4Zs2M1gAamNGSTFUyQ+kssb7CGp3rALvM
         uQINpDSRi+U++BEkW0LAJgFYy3dDW8SZxbX4fTU71Q3d3+CdpcW9nFWDA83f9zFxZ46G
         fOkin3sSD9S9SRRBj0xWA9TWs8eWtMuBJmp75/NQ2ntlOhwCaQV9Mbr+ggF2Eu3twNro
         loH5LKjj4ltNfSuuonVe+Z58243UfsaH4cSEp1+RRmE6hE0Gg9OS9ppljrlFFP6x51en
         q+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5N0IJFJExNFmNBBJWrgzz5LRbQ4JRTZ0BkV4z06vqY0=;
        b=gQABSwkdkp5YfcnfSEGHY47Jp2TIByHRaoA9SWjnCwNV3Sn6Ltad8ScH3LykrpjYJu
         VK7LKDNz1hu00fOtA+ZvHmCw0NP2S7Kmj9QW+EyznZnF7wHTAWoflyRHgAjF8wBPXZ90
         gejk12vWr+SaKLIKGnw7FwMRlGc9d/j1VGiPFOBSfBzxyZbpCjRlhXDd1Ynf+vlfrXdP
         +xGcppBIe9/yhpN0ydECFIsud6bDyKALeEayikXrKXEunty6rR2+rVCnBi6y0Ft2Pr0n
         EOeEBx6y8ihXt/zOGf33i948xe1fTTX0ZBevOxcrPSKWcX4ZdnslI5FMqxix+N84nUAs
         JhlQ==
X-Gm-Message-State: APjAAAUfol3aK+lneO8gFyeRc0j5df/hBIBXj5qFTpFFNLg2WoOeuGEM
        NTt5r7PHjMdjh2iFkpjD4cd4Aw==
X-Google-Smtp-Source: APXvYqx89Kr3sR4iD4jsrmNIXNbya2seam5xpxOI6dwozV14X11HSAwDiI7NAjy7VNTee/WFj3dZEA==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr609774wmb.149.1571847131097;
        Wed, 23 Oct 2019 09:12:11 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x7sm30240578wrg.63.2019.10.23.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:12:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 0/2] ASoC: hdmi-codec: fix locking issue
Date:   Wed, 23 Oct 2019 18:12:01 +0200
Message-Id: <20191023161203.28955-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the locking issue reported by Russell.

As explained a mutex was used as flag and held while returning to
userspace.

Patch 2 is entirely optional and switches from bit atomic operation
to mutex again. I tend to prefer bit atomic operation in this
particular case but either way should be fine.

Jerome Brunet (2):
  Revert "ASoC: hdmi-codec: re-introduce mutex locking"
  ASoC: hdmi-codec: re-introduce mutex locking again

 sound/soc/codecs/hdmi-codec.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
2.21.0

