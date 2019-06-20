Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D74C90B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfFTILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 04:11:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34392 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:11:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so6337570wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5roHDre638itG12NQdDXFHOocb2KrIJHgQ4zNYdyII=;
        b=UNZlkafnRBqWVg1+7FkIiOlXDjyuaktQv+Rkmv1aqjdSi2hxmSlQ1kSnGYK2Yu3fqg
         8fRx9HHy3mqkOiYxQ7mJDr4PoKVKvog5hHARQzTPa0JJe6u7ZKIJKk0dvR41CqwBuV2j
         sVulIaIbV8fB4PQFGP303Oq0kYbkqYHiRSPWgjUooGyGEW5uN0IrqePdLe3fxb1njtw7
         bY9QRex0uSKB3uoTzFRZCWI9VdV7727iOKVZa3+N55WnUvT54k6ABvdxqjgfkIq9UE/J
         QK22XVMbas6V3k2YXJOSrUtO/UmP4ZS/SW/O8CanKsOA2780dTz981U468Bg2KrnZk/y
         4ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5roHDre638itG12NQdDXFHOocb2KrIJHgQ4zNYdyII=;
        b=QY/fq5apKH33IioOvARlgrtu70zZFL06ed8z2eD8rPE35jUCmSra7GQvxyjChpyGyp
         f/TCfr7o6B8m0rIgFnv6aXvR3ivUl12M0zk0GizYdOXiX7NTRuCWVLj9s2xyhytu/PBM
         5zJxvhiNC+vP6YdjeFu9QAPPTFlgy7Iiv2ba+Y/p9W6QNHMm552sfL12RBIGeEAti7pk
         /p8fgtNUcfjOMBWbwnMJ3B/UilGwOrFH5e99yefNNlt5oGdURaMtZhvfbBCKymfyWjCf
         Cqtab61+bSxUu3KcH2kUJe+6AYf+AVtqu55FnPXsaih/7KNxRqLsZY/KdCYVS+cgCSez
         Ttsw==
X-Gm-Message-State: APjAAAWvYe14W/jCsY+UD7F61MBoZzGUKHA1bLGU1svmL7t3IT12vqy7
        Ijs/1M4Zwq3iNFZ8f/roFJxBHfdGzvQ=
X-Google-Smtp-Source: APXvYqzmIpIFIkYvfhAFydkfxKUjuf5zeSq/M5xtIZ4z66gPVB6U9ReHUGItAZclQkMDM7e1ZvvZ9w==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr1532437wmj.87.1561018291286;
        Thu, 20 Jun 2019 01:11:31 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q12sm17559174wrp.50.2019.06.20.01.11.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:11:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drivers: slimbus: patches for 5.3
Date:   Thu, 20 Jun 2019 09:11:26 +0100
Message-Id: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 
Here are some slimbus patches that are good to go in 5.3

One of them is doc fix and other one is redundant message
and the last one is fix for module autoloading which have dt entry.

Thanks,
srini

Ding Xiang (1):
  slimbus: remove redundant dev_err message

Jonathan Corbet (1):
  slimbus: fix kerneldoc comments

Srinivas Kandagatla (1):
  slimbus: core: generate uevent for non-dt only

 drivers/slimbus/core.c      |  5 -----
 drivers/slimbus/qcom-ctrl.c |  4 +---
 drivers/slimbus/stream.c    | 12 ++++++------
 3 files changed, 7 insertions(+), 14 deletions(-)

-- 
2.21.0

