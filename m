Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABC1133706
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 00:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgAGXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 18:06:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAGXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:06:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so1338967wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k53sXXKoetFWE8GEEtNytoJYTuHWX23InQV8Qtu4GW8=;
        b=dENCSx36Ej5yYSporQHM0EZQIerJ0te/h42mTZ93EZeOg3JsA0ESBCTSif6qckRHaK
         rxYMyDM0wGr41OJ2wQeUr7uJj/nCJ8ALhT6f97PH0oGrtASQk3eYzqvQOtRH3qQWWWwx
         Ho396dQoJvVeasv15P595WzKK8uGDMOS1Gb7xy1PCzg5rStuXm783K0aXg8PvyEsqwcc
         0Kv2PcFCaSI0VcA/G9ZJ0gRUOB1v2TJnFP2eDUKvRyDpbozAEjmrT1BmVFLBNrGXTkxO
         khCbSxJQEspIlT9GtOklM+pRR9sEXoxc6beW7uWvF23m/lxNCBKzBu4R931JQ2k4H5DN
         O2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k53sXXKoetFWE8GEEtNytoJYTuHWX23InQV8Qtu4GW8=;
        b=t5mJyPDl6VfIaGl4UphKFPHu5FQM+C1EL3bb83T20VF3JGLmhYEf29GkOD/Acg/JD7
         RJI/FXVD3zfkovBmurqFVyiwW2XZYeXXLo3/wgRBIuOowD7qANyQeVS8k7mr/y3u6iXj
         3lCW91+qG8uAaTDylelQtaHi2nhZwlmucuHvJ0kv37Z5hBaMK4cyfmhj1BAvfDAubHr5
         R0Hql5jNZkh442uNAK2FbX9Oa3fs3sLOO7FLE1aTpiupZLvYU+TIcxmZs3OUmxtmbRoq
         nsVBVvtpUE7H1oEWO0ouLTdjkgwwuwt+4ovFKZxGqA3hYlNtNPvjYGGy35SLP10R/ji/
         Rzng==
X-Gm-Message-State: APjAAAVggFYZL9ZOn3ijg5W+r/LdDp7agfNDYdqBGyHgoqPh74II5U0h
        yhnygPg82FF9A3CiYPANdlU=
X-Google-Smtp-Source: APXvYqyl3Me0mVoi+rzI0uDTtUjURQ5KbxgWv7vhF2OviRpzvAMJ9EZQEFf+m7UCcWGXNpC/5ZwHsw==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr1270198wru.173.1578438408111;
        Tue, 07 Jan 2020 15:06:48 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g21sm1335912wmh.17.2020.01.07.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:06:47 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v1 0/3] devfreq fixes for panfrost
Date:   Wed,  8 Jan 2020 00:06:23 +0100
Message-Id: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a bunch of devfreq fixes for panfrost that came up in a
discussion with Robin Murphy during the code-review of the lima
devfreq patches: [0]

I am only able to test patch #1 properly because the only boards with
panfrost GPU that I have are using an Amlogic SoC. We don't have
support for the OPP tables or dynamic clock changes there yet.
So patches #2 and #3 are compile-tested only.


[0] https://patchwork.freedesktop.org/patch/346898/

Martin Blumenstingl (3):
  drm/panfrost: enable devfreq based the "operating-points-v2" property
  drm/panfrost: call dev_pm_opp_of_remove_table() in all error-paths
  drm/panfrost: Use the mali-supply regulator for control again

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 33 ++++++++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_device.h  |  1 +
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.24.1

