Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56652E1192
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 07:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbfJWF2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 01:28:15 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44790 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730622AbfJWF2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:14 -0400
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5SDDN019954
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:13 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5S8c5006755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:13 -0400
Received: by mail-qk1-f199.google.com with SMTP id x77so19067722qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+w/YtafmCjkVTaV1t79Q7P7YHkL5rcu2d28rELl4BA0=;
        b=GLWSm49vesq16frCvoDJG0B8ezZAtee9JMZrzJ9RpX4XAPL0b7lvQLgxxpVJvqjM+R
         JVBLWBojctjhRm7cvoVrTJdHnIKny9bgTWQ2fx5eMfHhvs67Ga+p6qJJ6e3ZC7N1Nleu
         yVxOa0BA+fNjoVBJgJyLcFfGdwvN9Nk15ESnHshtBp286XgA8j6K+gnT6R5cnJT/09Oj
         LBEicsFtF2abYzFP34lawUGKCs+dAM6YXwcUtsBuylehwaJ4Ky/ViXqNtGhhVXpx6CCU
         KXG6sN4ng7dgK1hRamH8YVka5aqigblu2d+/1zeNirDoSKECscKls/5AfFPljmUw7RQ2
         E/Xg==
X-Gm-Message-State: APjAAAUVhBGhismlxRGzTiLx/sSWNMOxJaBzqWUhhNGuYBBOhlKf3Dqz
        JGVIdu+S4DkQwlg7z9yjDs/0EjiU1PqkGBx20IfdPQzcy/5qB41R+I/NTrLt+TDW0hycAHJf+GM
        5SBSkqfwAoarmf4OmHJtdop5hB76sg09YK3o=
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr7528636qtm.294.1571808488368;
        Tue, 22 Oct 2019 22:28:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDqHBy9d1YKwCS40iPK8tZA+H6zvvizqpSJgYTel6JiwsGP45ceVjDnEdShCt44bWn7FAAaw==
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr7528625qtm.294.1571808488144;
        Tue, 22 Oct 2019 22:28:08 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:07 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: exfat: Code cleanups
Date:   Wed, 23 Oct 2019 01:27:43 -0400
Message-Id: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two main goals here - remove the code to mount FAT and VFAT filesystes,
and make a lot of functions static to reduce namespace pollution.

Valdis Kletnieks (8):
  staging: exfat: Clean up namespace pollution, part 1
  staging: exfat: Remove FAT/VFAT mount support, part 1
  staging: exfat: Remove FAT/VFAT mount support, part 2
  staging: exfat: Cleanup static entries in exfat.h
  staging: exfat: Clean up static definitions in exfat_cache.c
  staging: exfat: More static cleanups for exfat_core.c
  staging: exfat: Finished code movement for static cleanups in exfat_core.c
  staging: exfat: Update TODO

 drivers/staging/exfat/Kconfig       |    9 -
 drivers/staging/exfat/TODO          |   20 +-
 drivers/staging/exfat/exfat.h       |  122 +-
 drivers/staging/exfat/exfat_cache.c |   94 +-
 drivers/staging/exfat/exfat_core.c  | 2162 ++++++++-------------------
 drivers/staging/exfat/exfat_super.c |    8 +-
 6 files changed, 690 insertions(+), 1725 deletions(-)

-- 
2.23.0

