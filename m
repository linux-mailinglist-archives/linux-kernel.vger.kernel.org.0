Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6061AABB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 21:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfIETEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 15:04:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46561 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfIETEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:04:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so2901083lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0X0neFSzhuU4nKeVW55wrsCexXnGfAFzrsvBOwk+6g4=;
        b=NqwNQcGzZieDYorRRnirEowNPE133HeDTZIG9gf9ZavEpMcLuYSz7K4ovB5kB7uh2Y
         VFHUgW1FTd1kz8C7gTTzkGxtgGlg9l7Cgj/pKas0u9hdLA+8f07ueuoeo5ZMx9yb1ypj
         4IN0U/62BFZksxsJ29+ap1J2pbQlRCS8AlMdwMhW2siDx36Jmzo8DOLcrh/564iivp1c
         psmi+UmHDqwYBCAObtSq5zw1PhoJTIMsRNK2nwqsyMKw6kf70ADB/+Bgh+OJWTQrI7fa
         v2LFuf3XoNWrJN157dT7hFtm+LJ2a1WDkmTYTQfOdf+M5A+QtH0wE3GSiedf6I2MhfrB
         zJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0X0neFSzhuU4nKeVW55wrsCexXnGfAFzrsvBOwk+6g4=;
        b=de6DXhchpfWZUaH65Jp9IpVDSWR9XRitvXxdAAQyMIzJi1kwJhtqmM5uH1TexuAen2
         3ZvA3U7Hi56H8v+lp8F/65ZbnEsoeZDU39OeZIhx1tEO4XUN/OZnwToYDMeLwXLhzs69
         D58aehdL0LRg4VRi//Xyn2h1dcMCfSR0dlM5/hfQC6Y2LN7p22s2QeaSOVaZCanSlHHd
         IRM7dIX6c0IBFOffZyILwBL/Y2vKyMvb+5DGe2rLZZ69J6Gl+ZZQE6cuNm8PCcPk7rEk
         DUhjXXnvY1xVM4VCcwEM1DfUYWgj2Jb2Vytq0cOijivrrloG9mkDRMOu2czgGadb16Ve
         GxQw==
X-Gm-Message-State: APjAAAXaWq3+/JhME2dfWwtD9T8hcYtwj2Qa6HQwlCjvsiVWqaVwNSng
        b0oQDK7q9t5lAB3fUCpEGfW0ew==
X-Google-Smtp-Source: APXvYqz6hpVqjB/kh1DpDc9oocq29hm053qCI8Ia4Ais3yvuwuGtk53gJroo21JJkcfrN8Xuzt0L0A==
X-Received: by 2002:ac2:4835:: with SMTP id 21mr3383015lft.121.1567710286087;
        Thu, 05 Sep 2019 12:04:46 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id 6sm599037ljr.63.2019.09.05.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 12:04:45 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 0/2] lightnvm updates for 5.4
Date:   Thu,  5 Sep 2019 21:04:31 +0200
Message-Id: <20190905190433.8247-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

Two small patches for the 5.4 window. Can you please pick them up?

Thank you,
Matias

Minwoo Im (2):
  lightnvm: introduce pr_fmt for the prefix nvm
  lightnvm: print error when target is not found

 drivers/lightnvm/core.c | 54 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

-- 
2.19.1

