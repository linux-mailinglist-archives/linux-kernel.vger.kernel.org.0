Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123A4323C5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfFBP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 11:59:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37044 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so6842940qtk.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6wrK07m18vBz92aFXgDpxBS8gA3r3xl4zuOhpCZv1M=;
        b=Lbn9N2Yty87IYvzN0tY37lEGmAFLUcK+8DqmDX5/TGrpMbwsiofJ70DQyrIm1rahr1
         6hIIC8Ws9xjn32ppsWcRYeOdg4pNGB+vkjC2tSvijfyclLtwOirqP+ihI/tijJwEqc4f
         5M/jREEnpB/7d36agucSOZxILNL+QtXQ0AgjNLJJ+pt+VLO6QvjB1Ka8TddhE/+UMUdi
         xSQkOYMvtg4eAeFEs9LWxmrgBXPu4gKhvfrCsRAwe8dqY1LjY7/kP5g76W3R++CBgu8t
         hRrUtiZ9QKgOSUbRMY4qRgAfNeqt4fJhElWChlTKlR+OvpSELAOvkFOVvC/KDE12dH23
         CixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6wrK07m18vBz92aFXgDpxBS8gA3r3xl4zuOhpCZv1M=;
        b=HUtfojO9LcvC6e3ReHWAZmF9tfKL00E4DuaGSEZBPIPjIm6Fi06IHPr10nvRQEXWfM
         q55QOfupwEyJLYGjpBN9aF4VCQquAbZLn0z89ZFvYA1TqxY9swcwKFeA1omdMGKKJj5M
         YyOsNxCB+y/jL+fEjTpaotjMHIQ926koQnPfyWzvyTOyKnqsU7QfgeUo26Q+anm8DhvS
         jzl5qbjtC92QMvfJTVUn9iYsab+Eau+P2sKy86FC75S2rUZsssR+Gu6xta2Hi9TdQ+SK
         1hm2VYUnrxtWf3SS/Ou3rbaf2sA7U2hILY5KzIsnxvTH9KiddQ0ZzD304nJtxAORwkXS
         2eEA==
X-Gm-Message-State: APjAAAW3dYOeQJBmM8lvtCmAr4B7akGNVU9Mrzj0zSX2wCnVQXjgAmpX
        ZZGAo56H995JKnVVnRrq6jg=
X-Google-Smtp-Source: APXvYqzVsPrvMha2ALY8t+t1yy/JX9yurW+MLgtDuk6hbCDgUbZis2lMZDlRK9hxuQv6Aaolg7kmjQ==
X-Received: by 2002:ac8:2bb3:: with SMTP id m48mr18901947qtm.218.1559491155744;
        Sun, 02 Jun 2019 08:59:15 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:15 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: kpc2000: kpc_spi: Assorted small fixes
Date:   Sun,  2 Jun 2019 15:58:32 +0000
Message-Id: <cover.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains a few small fixups to the kpc_spi driver. There
is certainly nothing groundbreaking in this patch set. It is limited to
style fixups, removing unused things, and using the managed resource API
for mapping I/O space.

Geordan Neukum (5):
  staging: kpc2000: kpc_spi: Remove unnecessary consecutive newlines
  staging: kpc2000: kpc_spi: column-align switch and subordinate cases
  staging: kpc2000: kpc_spi: remove fifo_depth from kp_spi struct
  staging: kpc2000: kpc_spi: remove function kp_spi_bytes_per_word()
  staging: kpc2000: kpc_spi: use devm_* API to manage mapped I/O space

 drivers/staging/kpc2000/kpc2000_spi.c | 45 ++++++---------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

-- 
2.21.0

