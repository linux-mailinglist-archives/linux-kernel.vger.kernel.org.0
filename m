Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF22DA91
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfE2K0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 06:26:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2K0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:26:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so1320101pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJTL67gH9xPtYyMqvCkT0yEzd1FL39jXNF6HUA35ERA=;
        b=XZmEt/OOIdZyii8nBgo1yRd792hZgheTgotTZYs35weSjW2UgrlscLr8K8uZVXdqPC
         wjMTLrFRr7dFI+eNNyHZ3W50dHgdjhSbXuqOsmzCTHKob+R4NLkva0/xHzQFut5G1vB3
         /Xa+6mwNyPTx7T0mE0amSv+SQqf+IlzMIifJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJTL67gH9xPtYyMqvCkT0yEzd1FL39jXNF6HUA35ERA=;
        b=K31MHiiQJTp1x4NurU7ow3pmsWsVPqHVAzCeGkhyIuvfCn39ja6dg17oMjM4w9TjTA
         sy3PY947txrQv6ku0wX7GBQX1mKc0plhBoLTDMyPIedbPFMUbxMXs1o7QgLV5rBRgN6B
         FFMOmqcCFENbi6eOTMk+5/l3h6uI5Z08sBTj3rteYIcQVq1sCYU84IklBt+1V09vQIG/
         YrEHZeOo3pCUlTjzNQ+Sb20/AiiILQLmqw0DibMQ/wTyJWn596h/yoOjvrgRQj6mc3ej
         dunPZEIStIVEVHM1Xlw5YSp05JGDI1eU8J90ibE1K2reHPrm9xA4T8eejLsrBneLEGqt
         52DQ==
X-Gm-Message-State: APjAAAVQ3wlYsnlQalIigOjmKu25WBK3hcn97NT7zGUlgiUwcMr6vpAX
        UHd/huWurMNSYe/fVuORj+OCrw==
X-Google-Smtp-Source: APXvYqxd31GalQHglufXhJap16lK/DzJU5TFe0799jhvV8zXWwrroNs5HUHJZR1S0kMiTp9HOfNbhw==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr148943107pfu.4.1559125597639;
        Wed, 29 May 2019 03:26:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e12sm18992183pfl.122.2019.05.29.03.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 03:26:36 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] fix mediatek drm, dis, and disp-* unbind/bind
Date:   Wed, 29 May 2019 18:25:51 +0800
Message-Id: <20190529102555.251579-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some errors when unbinding and rebinding mediatek drm, dsi,
and disp-* drivers. This series is to fix those errors and warnings.

Hsin-Yi Wang (4):
  drm: mediatek: fix unbind functions
  drm: mediatek: unbind components in mtk_drm_unbind()
  drm: mediatek: call drm_atomic_helper_shutdown() when unbinding driver
  drm: mediatek: clear num_pipes when unbind driver

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 8 +++-----
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 2 ++
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.20.1

