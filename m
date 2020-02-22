Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB8168B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2020 02:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBVBko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 20:40:44 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44379 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgBVBkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:40:43 -0500
Received: by mail-pj1-f74.google.com with SMTP id c31so2005315pje.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 17:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0Alq4aXp7YzXN+AKMP8eBqRG3yPiXOJvC1/VEWq2Syo=;
        b=e7OPKG2KhyChpWNNR4nLuUXy4ylVfjqLMB0INuqTgORVMt4c48EOCa1hX7f0vVumGV
         Fl12/3GISHBbAZ97RhHkmzUnwcBemFYtUitr0VJcMtjeqpFxtUVOKyNmvgs7bmfVKCbC
         9KOa3O/uxq9/bSScNcxqwFUIBpU2Dk0Nevxnjbwq9NYDFPNPFYF82PBcwjVPtHAObGCy
         sX4eERpRAQDnlpBKSFC417QE5MtuCxGl+zr+heynrIeikegYLZAfZTNmhbZ6hDclGTgx
         8TJ0QSLqeS/71knXjOGDITkEFZxZSlCB7KHiB1MAYy/cR/WtHU8JCG1hUSQ9PupLWjLG
         63IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0Alq4aXp7YzXN+AKMP8eBqRG3yPiXOJvC1/VEWq2Syo=;
        b=Jv4sSWBkNIvmg16/JqdjcQaJ0KKysjlkdISoIxGqYG7PuV9iFlx/iMtaJm29brmWKK
         JRZbACJMo0UeLpZbg2yGDQSJVMjVJXHjFEKCfZ4Uv0CnkzfOAwAZFqBGcvFPSjqU/3c+
         3AfgsfECLOufzD67TuVgBUhan+I/4T0+IFjvjCktkes1mU0HGjmphC4sQhW9bGn8RPP0
         lWxqDRW+yj3VfkM3ks/DPGnwLLxXwfgrPjJyts5oyWFU93LhKjUZUDUJPoIi48vrvI8J
         kXUBSVFTp49LSLFps1ighpURFbPvRvVvWF1GUEwmiRwMknaqnJRioDSQpGkVF4qc9h+R
         tWKg==
X-Gm-Message-State: APjAAAVUY/2iEx23RS24HPbFhgdRLLU/gFby/UtsFY7scZZM7Ikl4nzo
        Ne3XoUmNi7iFSP9+h8OtyDcAPdB2GdiT/og=
X-Google-Smtp-Source: APXvYqxW9MycS0KQIN3NTm0UDrGeNfKtCCiDECg2Y+zwfxgcfOoFsWcvFC2gpjKZaciSFlbJG9dbBDG/OdhB4VY=
X-Received: by 2002:a63:2a13:: with SMTP id q19mr22138542pgq.82.1582335642711;
 Fri, 21 Feb 2020 17:40:42 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:40:33 -0800
Message-Id: <20200222014038.180923-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 0/5] Add fw_devlink kernel commandline option
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1/5 isn't really related to adding fw_devlink, but I'm just rolling it
into this series.

The rest of the series is about adding fw_devlink kernel commandline
that can be set to off|permissive|on|rpm which are in increasing order
of enforcement by device links.

2/5 is the most "interesting" part.

The hope is that once this series merges, we'll consider enabling
fw_devlink=permissive by default and at a later point in time ideally
"on".

Thanks,
Saravana

Saravana Kannan (5):
  driver core: Reevaluate dev->links.need_for_probe as suppliers are
    added
  driver core: Add fw_devlink kernel commandline option
  efi/arm: Start using fw_devlink_get_flags()
  of: property: Start using fw_devlink_get_flags()
  of: property: Delete of_devlink kernel commandline option

 .../admin-guide/kernel-parameters.txt         | 24 +++++++++----
 drivers/base/core.c                           | 35 +++++++++++++++++--
 drivers/firmware/efi/arm-init.c               |  2 +-
 drivers/of/property.c                         |  8 +----
 include/linux/fwnode.h                        |  2 ++
 5 files changed, 54 insertions(+), 17 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

