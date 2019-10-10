Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56014D1F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 05:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbfJJDo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 23:44:59 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:44237 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfJJDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:44:59 -0400
Received: by mail-pg1-f175.google.com with SMTP id u12so2736976pgb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=550gxSeJhzNkTjxw5FC1sTsyheSIffBNoMopfL6z+Dk=;
        b=GfxZN8ortzSHSNfxUhOtPMjuFL/CTvxwNx+VPDnoc6oGZLCiMhRgAECiq2htIf4otk
         zusotZ5kRz0cUqEffT+NLc+PcIytr1PQcXa6zYkZPI0Xtfz92TxkoGp9LyUX7PG7RCJ6
         YYSE89o8L9ivup+eBkqasUpeChZoy+BkZpOofi5k7sVQFZV4KY0yZkfvNxXwYkwB7+9K
         mw9cXdsXS3caHN65SZxI6H3MeWiA5QLI3Z54J/d4aXGNy3RjQvHtnDhjFDhb661/juiB
         CUHteso05PO32p3+f+Ma0CpXWHcoVtnI9m2bi6Zl3twTK/V4/WQVyARQMGd8xCalQUk/
         FBJw==
X-Gm-Message-State: APjAAAWkkn8kYkBDRJFf7uNep43eEWD/O4KfJKVCu4iq2laCNvq8+skv
        k2Dethzqjz+CDg9hQmi56EY=
X-Google-Smtp-Source: APXvYqyhwc9uPwrA9hTdDDMnfRt6Xj0TDI+CGUJ3ZOFD4r3TR+s2KL0z8X0HW/f8P7FsK5lk0ktDXQ==
X-Received: by 2002:a62:38d5:: with SMTP id f204mr7933796pfa.100.1570679098883;
        Wed, 09 Oct 2019 20:44:58 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id z13sm4552188pfq.121.2019.10.09.20.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:44:58 -0700 (PDT)
From:   Nickey Yang <nickey.yang@rock-chips.com>
To:     heiko@sntech.de, hjc@rock-chips.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, nickey.yang@rock-chips.com,
        seanpaul@chromium.org, laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/1] drm/rockchip: vop: add the definition of dclk_pol
Date:   Thu, 10 Oct 2019 11:44:51 +0800
Message-Id: <20191010034452.20260-1-nickey.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nickey Yang (1):
  drm/rockchip: vop: add the definition of dclk_pol

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 12 +++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  8 +++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 45 ++++++++++++++-------
 3 files changed, 43 insertions(+), 22 deletions(-)

-- 
2.17.1

