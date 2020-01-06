Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905CF13180A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAFS7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 13:59:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32784 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:59:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id z16so27373762pfk.0;
        Mon, 06 Jan 2020 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yuKcwd4KrNa9rtLutSuAmTGJfnwaF6J8Fm5oKI6kNYg=;
        b=NhUlkwXWHDnT9Ee7YQzIdS0l0yN0Fp51RP1Wyujpo2gEw1HQoIlY/cB7Iumgap0XEf
         GSD8q0anWELFYMXuTSPSvkn5qxwU7w0P9wzoW6gpGRBG3WwRcRr7n9stsrvnGD4wlSo1
         PMlRCC41B9LCal4obGprJDYT6l9ymqmRLnIX4nF+xiCGASQj+VKJRMCRKkYVBmAyVwNJ
         E2tSqVhcMVYYvfnTDCpcoFKjI+cO7G4vJ0aQVlvMquyFkVjGKHWLxg9yr22PZTQ26vTs
         Y7nGLNhBKNR+L82yLboyAirUQqD9EQ8/FsUqsrS0jkfrp8eUxsqqX6yWoUfW002VSFDk
         K5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yuKcwd4KrNa9rtLutSuAmTGJfnwaF6J8Fm5oKI6kNYg=;
        b=cvGG1gix/eF5z5pSwctsRSih3wsno2TcI2VIP5Ka0V6GoThpVk16B4vqIRvVcHHAW5
         eKbxXiiIpc0UC6qWNe9HXlxhy9rxg/NggOFpQ4GbCCwUyaFgTwkjR6RYLHEOHM1y9LhN
         tQVOMPughnwwPy85z8YgztWODXsY5G5kfsewW9Zn+qOdSOrEiFE0NVwJDSkxUOU3QHrL
         cViNMs9Nsw8S0Mmy44T/uqCPAm4iO0mzgfjCN3bas/UEZyXLhA++iyMhnZ1Od2yUISFU
         eHig7Mm8wj+fCSEWRZySBg+/QVanmvr8mcSt/8Coj5WikgWPLYIXU1r3yS6Ll4kY8vn4
         w0eg==
X-Gm-Message-State: APjAAAU1NM4LsoqZTWVxKEojDUtV5TVQ1xgsJBNc/kG1PN6TKCsejs51
        YVjJqtpHuHRPTZDJTg7rQB3Ah43B
X-Google-Smtp-Source: APXvYqyM0Vkr6F4WPszfaw/wRE7e0DfBFVIslFFUeCauxUMZXaEM3yfKutPJb5NJe5yX3K3YUFGCfg==
X-Received: by 2002:a65:4142:: with SMTP id x2mr109431013pgp.393.1578337143645;
        Mon, 06 Jan 2020 10:59:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 18sm71758718pfj.3.2020.01.06.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:59:03 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 0/2] ata: ahci_brcm: Follow-up changes for BCM7216
Date:   Mon,  6 Jan 2020 10:58:55 -0800
Message-Id: <20200106185857.11128-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

These two patches are a follow-up to my previous series titled: ata:
ahci_brcm: Fixes and new device support.

After submitting the BCM7216 RESCAL reset driver, Philipp the reset
controller maintained indicated that the reset line should be self
de-asserting and so reset_control_reset() should be used instead.

These two patches update the driver in that regard. It would be great if
you could apply those and get them queued up for 5.6 since they are
directly related to the previous series.

Thanks!

Florian Fainelli (2):
  ata: ahci_brcm: Perform reset after obtaining resources
  ata: ahci_brcm: BCM7216 reset is self de-asserting

 drivers/ata/ahci_brcm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

-- 
2.17.1

