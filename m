Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF2DC4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407905AbfJRM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 08:29:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40239 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbfJRM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:29:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so6064538wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yVZsL1k6xiwxuV3Dn1WgaEOAdbpoPkfatJaTm2/Mp3w=;
        b=nJzaiiNURnwmCDzi+HEDjAoCrZm2BiaHVd4DbjtibweAWdBba7y8Cm5Cul1GhvS884
         b9Z3DWTZI36Wslys6q1QlPw4r9V+tUfrUVdoszjEWrajnwwOWFegyFTKWXDROe7lRL2l
         zUMF+Dv6XlZvr1G6c8vnGIgtSQ8QSXY94A6vAdt5kBNKUlAq+PFSWVrzeMQFazNuw4V+
         mAob2CIzkAm8Orq/2RYhFQ8y0hMXHRHrWS1q24L5UpsH+Uwvx5FjchpwkYNt1AdffcRU
         QH2/nuCdP5UU8SxmV2LtpfD2NJSpo22IPRoMKpoywjR3Iw9mOlE8wmeh/rzvokYeRvpK
         Mwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yVZsL1k6xiwxuV3Dn1WgaEOAdbpoPkfatJaTm2/Mp3w=;
        b=XbUeNoMzz1hT0vo0RVp5AydjiHOf1TMlVmEwxSP6zmgoKoqopmHBfwe8Vn6RlQoKTz
         a7HWGxoX2bIofLUbX9myV009s1FrUw6b2haAr7bbwlYR/Re7E4oKvEnwuV9oLKBIgWTQ
         FuburokgVHOLAjrDVO7tnjl9W/WscF70Om1vRN9W9LFFZPzJf14pLTiHgAddOeyZQ88A
         TKiAHDYOJd0RwPuwmPGgGecNmLOgZ/ciKodH3MhViSCMGvXruf3YxCNExOkU33292UMi
         y9I6hiHqVXuCRL/gLvsovneTYYaZfVwURcKcaqdW+sUVV78ZvIjslxUfDhXdB04BvROK
         BWlQ==
X-Gm-Message-State: APjAAAWfBa3wl2H2m4kKaQ3i/Ax2I8FtQRiGOUEYgu3lCCUTwPedH8I7
        nUprBKFsEPd17U5nCnslHmaHZA==
X-Google-Smtp-Source: APXvYqyGTv4W7YZ+dBPzILPhJC0MpqlESvgAkV0FwdTo8BGAUnbZ+ATDcZpR+y3qVcTvWL0yH7hg9A==
X-Received: by 2002:a5d:6992:: with SMTP id g18mr8044446wru.237.1571401737135;
        Fri, 18 Oct 2019 05:28:57 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id e3sm5033820wme.39.2019.10.18.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:28:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/2] mfd: mfd-core: Honour disabled devices 
Date:   Fri, 18 Oct 2019 13:26:45 +0100
Message-Id: <20191018122647.3849-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set ensures that devices set to 'disabled' in DT are not registered.

It comes about after 2 seperate reports.

 https://www.spinics.net/lists/arm-kernel/msg366309.html
 https://lkml.org/lkml/2019/8/22/1350

Lee Jones (2):
  mfd: mfd-core: Allocate reference counting memory directly to the
    platform device
  mfd: mfd-core: Honour Device Tree's request to disable a child-device

 drivers/mfd/mfd-core.c | 47 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

-- 
2.17.1

