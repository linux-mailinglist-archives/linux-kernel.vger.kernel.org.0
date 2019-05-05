Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892201418F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 19:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfEERjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 13:39:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46161 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEERjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:39:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so9120215ljk.13;
        Sun, 05 May 2019 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3qZZ7ZZQl8fJvpX3EEcO4LoQ4Uz3pz1vAeLF9xgXcY=;
        b=CKLNfZWtblLlw04L2dHz2j5I+ollT0Nhr7IwI1sWGxkHq9+tREv26DVAbAQvrxqfkF
         T07jtaf78nNT6eNLQVBmgV1vESgyD4+e3Szd9Dao6ODMilZCUfx03tmTuMMMOIgpV2mn
         E9g1l7CPH7XXhbkx66NghzHQRQ/uQWoCJcwuHhKUmYMERrrRALWNBgKAoFcJYIAKvW4P
         Sj/FkMpST7QKCgKnRDExtG6Fkk/z2CDZGJAwjjQ5pWEAveWKlofTgnoIEnh8n/shvXzL
         FbScpImF0R75BC9fVm+xHXRDJW5KSaw10G59FwmjhAhy3U4Mnj/mdk4iPjG7+932nAWx
         7IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3qZZ7ZZQl8fJvpX3EEcO4LoQ4Uz3pz1vAeLF9xgXcY=;
        b=cjs8tyOBp7+6Ue7eJytdq982ir5xgf6k2veVovGjNxtlm+BTFICPYWXk4OwSCMpGab
         vAyLfKo+/xwYFmdskw6NBdIfPO1xwLA9b2EEh25qJ0pR+M/QxZdu03r/MgcUoTfNXYEM
         dSE8DWqiQXgVu52+xEw/U3jMVHYngmeoqwAIJmupF8kXI0pzstR+67AY2Ab0C1kJqYxs
         uaY1QmLDr7N9fU0H0WxpKXlG8NtUvF+n/evYT7/lxmgeGp3MXdwEXzuBu643w7y4Bsbf
         ikN+aG/kO+1uff39AAfMBoPDBTjR9AgCPuJouUf3nCkyaAPCFebtOBAsDi6hLLzUJJua
         LTEA==
X-Gm-Message-State: APjAAAVJ7G5r+a2yimNdOvLxxz9ytQwZQunXAanD3UPGZthdCci0sLMd
        jmT5g0EBa6ectqMOYlo8wuM=
X-Google-Smtp-Source: APXvYqyoVJ2csql4znGGg+oO1CL0Ntj6WRZze+OQ3Q7xJ0CCD2QHMcBpG2epnScOVORjx2hDBLkG8w==
X-Received: by 2002:a2e:2b89:: with SMTP id r9mr6160125ljr.7.1557077987169;
        Sun, 05 May 2019 10:39:47 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id z17sm1626938lja.26.2019.05.05.10.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 10:39:46 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Tegra DRM: Support memory bandwidth management for display
Date:   Sun,  5 May 2019 20:37:04 +0300
Message-Id: <20190505173707.29282-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Display controllers have a need for minimum memory bandwidth in order to
maintain data-stream to output at a required rate. There is a visual
corruption once the requirement is violated and CRTC reset may be required
in order to recover. This series adds preliminary support for the memory
bandwidth management, it will become active once Memory Controller drivers
will get support for the PM memory bandwidth QoS.

Dmitry Osipenko (3):
  drm/tegra: dc: Tune up high priority request controls on Tegra20
  drm/tegra: dc: Extend debug stats with total number of events
  drm/tegra: Support PM QoS memory bandwidth management

 drivers/gpu/drm/tegra/dc.c    | 234 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |  13 ++
 drivers/gpu/drm/tegra/drm.c   |  18 +++
 drivers/gpu/drm/tegra/plane.c |   1 +
 drivers/gpu/drm/tegra/plane.h |   4 +-
 5 files changed, 264 insertions(+), 6 deletions(-)

-- 
2.21.0

