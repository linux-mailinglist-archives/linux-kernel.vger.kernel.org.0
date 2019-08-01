Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC97E114
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfHAR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 13:28:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35599 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfHAR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:28:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so74456304wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ez2uNoorgg89Z+k0wTuuFostbbYDhCll54eZOAXg+7g=;
        b=fNiupn1ibxQdpOEAIyhFq0PSB6/QCYYCkTeFZnlYW++FrB2h/h2Djl4SLFZK3Gey+E
         2CJ6PIBnACA6eTno0sOWkMlmT8QwskUbaV9J9GydkAQ4ZCOjg44Kow2tdFoezdiUYvS+
         gmhqCY9Dh74nutGvUSwfJvNzeTEE3XBK5XZ8v7p1m3WKHGQZ0aQpuTJ19fk+54rockTw
         lfmww9QMGYMtXehHTuszRDPZD2E35EdS8EX8mKQ92ZJCzulzHWFXDC3dJuJGA9pvVlJE
         YdObMuRaS5YBnA+hm4+jyY73aLqFteN1a27ViM7FtufIzdYTDnyGMwXyuVx10n/+LoW5
         EOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ez2uNoorgg89Z+k0wTuuFostbbYDhCll54eZOAXg+7g=;
        b=WiF8Zmgjg0ojB8DFzyFq6IoySZk/+0Qn/850Ql89lAeRnlXwQFDauTCovLeqXiAqLG
         EfHEQQITZ8FFndo4cI36nlzprMmoK7S+2SM32FZTMwD/vCAOvmSIeM1J4lKiWQILpVnh
         mPlpMJV+ZVCFamrn6WWVeB9D5lF/f88kkd55d87GKruki2W1EhY8tWvVnrBltrQhahOF
         b02NesropC88H3WoTB5Bu2IsB/9Nu46TozlOH0mmkIz2HmodY34fz+4J7O6grlL+paWV
         ATop8b8p1xt1eHVqAGmC7YFowupkPWPkwOPuPg+aItAVf+WwDkZU9l4HbjExht2KSm+V
         n95w==
X-Gm-Message-State: APjAAAVXWlVFGhuSvrh+LxrwzOZg7Ad/tH5uM7aHoNjjEBT8G/eJjyYD
        ZhHaNxjgOxy/kn4DVzAUvBZZ6pTwMPdnIQ==
X-Google-Smtp-Source: APXvYqw7YnuP/T3Qlvzq4Ptfq0zbUUmK0Z5AqWn64UQymyu+NL5Eb/pLvC348FtAVVPttQQzAe940A==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr1626318wrm.55.1564680494579;
        Thu, 01 Aug 2019 10:28:14 -0700 (PDT)
Received: from localhost.localdomain ([78.90.15.211])
        by smtp.gmail.com with ESMTPSA id r123sm65931573wme.7.2019.08.01.10.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:28:13 -0700 (PDT)
From:   Todor Tomov <todor.too@gmail.com>
To:     will@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     Todor Tomov <todor.too@gmail.com>
Subject: [PATCH] mailmap: Add an entry for my email address
Date:   Thu,  1 Aug 2019 20:26:03 +0300
Message-Id: <20190801172603.14177-1-todor.too@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My @linaro.org email address doesn't exist anymore so add a
mailmap entry to map it to my @gmail.com address.

Signed-off-by: Todor Tomov <todor.too@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 45d358534ac5..9ad06d88190c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -228,6 +228,7 @@ Sumit Semwal <sumit.semwal@ti.com>
 Tejun Heo <htejun@gmail.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Pedersen <twp@codeaurora.org>
+Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
 Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
-- 
2.11.0

