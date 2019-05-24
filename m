Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F6E29DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbfEXSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:17:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36686 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:17:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id z1so3996424ljb.3;
        Fri, 24 May 2019 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZLJylrKPY9cIPHU1KLx/+Qa13CwoeXrjMSis4aiXyQ=;
        b=q73TMsSrItUyBJV1N2QyvAJoX7fAF13rJWWq3easmo9d37yyaUudaE8S8D1WYmmR9p
         2g9VYM08K9SuuDnunqKrVLMRwSOMgjuKjw+xryXe8nwZfQfLWb8OkgMyct5h3EojlPQH
         cteKo3KAuozVrVQO9hzVCaTmXDdNAPATbyACYfrKUWqH+RzZ0TzY7UKm5QTy+TvFM+Lg
         tuSk1MXWRCTJ9HAisTixIus1NViaGPYFI6bPMxLl07sScj41w0ySWKq/BM8/xr/hPXL8
         VIs38SXaik28mZfTFtCkKkGoXZ0Z+qHsqFG3ilY9NBHq0Iz+nQJpsk1JOhkT8JopXYPT
         Muhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ZLJylrKPY9cIPHU1KLx/+Qa13CwoeXrjMSis4aiXyQ=;
        b=OEQ040X4xiMMxRtFZMoKYN5p2iUGN0f75VWgJhDabUmKzHyKRWePf3vWl38mBGxZqK
         nrwX9KBY6k63mg305OGa+q8T3c+DGguSJZ9Z7MSTQgibpJGyYeJ5qINhaHJJ+O/MOdZj
         gV43caW8aeS8b7RqL1qWPLFIzLY9axTmMXdwnkLIveRS61GVZKbtlyGGHlFTMgu1pJl2
         mGECZI3ZXbO5tQ/aZPCK8O1r2DO9yCI0aTctZ1OgNQgeMJup4K2MfGx4zsplHe9OTi59
         NSCXROmNQG7mGmjtn6tCXLJY/zpvTO07bHqdhwZBd/6Z6B/pNpYqGTgXERXXMMLbF/eh
         sNjQ==
X-Gm-Message-State: APjAAAUBjXjm8qna+OssEMe5+0cNv8Sk8QgTzAnpsUQBv6bDptrUskXO
        bNvPGILv30bQ/Ka9f1K1BVd1YDxw
X-Google-Smtp-Source: APXvYqzQDpQf4taQPQ0+N0zlhXKjhzSExlxGCn7TIRKcSHyOzlRbAbBNabgP/sDaWPgca0JNeGDAIw==
X-Received: by 2002:a2e:8741:: with SMTP id q1mr30887422ljj.97.1558721856334;
        Fri, 24 May 2019 11:17:36 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id h10sm810376ljm.9.2019.05.24.11.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:17:35 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Tegra DRM: Support memory bandwidth management for display
Date:   Fri, 24 May 2019 21:16:24 +0300
Message-Id: <20190524181627.16490-1-digetx@gmail.com>
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

Changelog:

v2: The total size of framebuffer is now calculated more accurately for
    planar formats, taking into account chroma sub-sampling.

Dmitry Osipenko (3):
  drm/tegra: dc: Tune up high priority request controls on Tegra20
  drm/tegra: dc: Extend debug stats with total number of events
  drm/tegra: Support PM QoS memory bandwidth management

 drivers/gpu/drm/tegra/dc.c    | 250 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |  13 ++
 drivers/gpu/drm/tegra/drm.c   |  18 +++
 drivers/gpu/drm/tegra/plane.c |   1 +
 drivers/gpu/drm/tegra/plane.h |   4 +-
 5 files changed, 280 insertions(+), 6 deletions(-)

-- 
2.21.0

