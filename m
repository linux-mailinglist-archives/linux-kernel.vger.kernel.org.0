Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920CA1534B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBEPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 10:54:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36757 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:54:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so1171524pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=i0tu/hN5nPRoBqhYtWsd7kOpTFJDnB/EYcTe2/ffTnk=;
        b=PAhbp4frFtPO4EcejiywOGYJLOdJYRZ93Sn7mtqxPgpWWVM8GdVmrPMUBUeqW3qxPk
         KOmH1lFXPIvWq3GETYAJGLBeRIpjcKNWAtXnu7AYjdq6NLTx7flJ/3QEx+9LgCjVPZ9Z
         K35MI4uw22Z1GnFob5wDhDzGbOfSjVmmDEeTCaj5F4M1KCXXih/auGv3291uj4E2DwyJ
         Q7aLPktqiCK0JRiVWdn/1LCfJg+y1JNnu3AkMIhISrT/81arqIagsBenLhIQ2pD35tWe
         xJafAorSX+kUzQQQ41eWMERKgKBKw8tSSpHgJu1yf+R8qg6g4KNJeBXLZl6VbcUiXt1F
         tAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=i0tu/hN5nPRoBqhYtWsd7kOpTFJDnB/EYcTe2/ffTnk=;
        b=gpHgtXrOz9A9/mQ+v2lmY1d9qSBEuqh71kT7FoQI/YFQ2fk/mq9lHYnmocfginFJOd
         Uf7UkePtSP7rCECGOd67ggRgNPJO0zYQwCNvDwJMpg+SnB8QUw73znhppg0eKpLaZv18
         Ff2ZIAkFwcJv5HZ0RD8TUS77sViDBgEk0wGOJKWg29DQ2J352hNI4X5YWE7I4sNA4kr7
         OtDFwwD3XoJXWtCc4FE6/Qep6qxZLIbsdUTKqi8Az6iRvdWCf5r9Xve0A6tEhiCa6stM
         cdyxoqRrVdGf007UNhr4mxPUiMNWGRuRPZS9hAhn13Kzh4+WTm218LRDIHbaH0HZPqs5
         h27A==
X-Gm-Message-State: APjAAAVdCvY3cXQxpXW3nJAsX+4Edq7dhOp+eEjOTAsIKCUs2iduoyTO
        ZfY7OYDJjo2PJj6+2Z3+2x8=
X-Google-Smtp-Source: APXvYqzv/cyl/PP0YheZLkTY4tfQAPft5kWWaGlKtPs6G2umfBsO4QccLRhSV6cavPFvn5hoQY59lg==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr36308895plp.144.1580918088401;
        Wed, 05 Feb 2020 07:54:48 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:54:47 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 00/15] AMD ntb driver fixes and improvements
Date:   Wed,  5 Feb 2020 21:24:17 +0530
Message-Id: <cover.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes some bugs in the existing
AMD NTB driver, cleans-up code, and modifies the
code to handle NTB link-up/down events. The series
is based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Arindam Nath (15):
  NTB: Fix access to link status and control register
  NTB: clear interrupt status register
  NTB: Enable link up and down event notification
  NTB: define a new function to get link status
  NTB: return the side info status from amd_poll_link
  NTB: set peer_sta within event handler itself
  NTB: remove handling of peer_sta from amd_link_is_up
  NTB: handle link down event correctly
  NTB: handle link up, D0 and D3 events correctly
  NTB: move ntb_ctrl handling to init and deinit
  NTB: add helper functions to set and clear sideinfo
  NTB: return link up status correctly for PRI and SEC
  NTB: remove redundant setting of DB valid mask
  NTB: send DB event when driver is loaded or un-loaded
  NTB: add pci shutdown handler for AMD NTB

 drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
 2 files changed, 247 insertions(+), 51 deletions(-)

-- 
2.17.1

