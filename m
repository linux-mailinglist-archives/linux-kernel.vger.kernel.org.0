Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C63E169701
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBWJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 04:27:06 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41137 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWJ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:27:06 -0500
Received: by mail-wr1-f49.google.com with SMTP id c9so6839114wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Eoj1WWBvHAMevh82SA2BMbvGwhTBz4nzvMq2zL8QG0=;
        b=GObOWQYhmnOOK92Ug9YaPH7Feriu9vN8UzcCTvz0jtU7md1mr0WriPS+SYGR/QGEuH
         273aLtzWIVP1NehWQAzQRKDXBoo3Bur78lt/607bGXxvXPJtsb6WZiNKWZgyjf9gKJYY
         faPhmYtnhiWdK84r/7Sd/tipP90aYif74XDD8cQGeExiDuR/zO0vzEOukiPEVxogM2qM
         Sf8j0ipezUL9BDSw3fc8TtErvR9WHfrnuSfSb2EIBEoFMZiBON3w8mqRNzKg9QeCfNuz
         m7GAfWIix2c14ZCfDIk4f5N/M2aeEaAp43+8fsQks8khMy9p3SXHwWX0V8doCum70YD4
         kaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Eoj1WWBvHAMevh82SA2BMbvGwhTBz4nzvMq2zL8QG0=;
        b=XenVwC8QYK4uauH4wnLsuQIkdAH/v7/ygxIJscfP5BbdAZgQ7V1Q8HCOTC+2B4BhjX
         I/VMYmIoc1BvuT76RvZ8nLvPeX7j+YA7NHqtxv6omC0xS042XhkFD2sZYtwNj816qFCe
         LmMMV6j7H+c3VDvEHVfPv4ITBy2ljiqHS4OD1NTeRWRZAQ4yTqQOaqHGFsjareaZaynq
         adAQSNoDlH/eoxWRa/5J2AnjIzT8wqs0rY72hx32Ik4sWti/ai/l76sXLHXbCstQRRvd
         GWlT1n4Ua/dOHEaM7Zo0Odpw08PBmL+U48ifukPM/v6WhYErbqq87KulM1tgoF08Sf7e
         UqRA==
X-Gm-Message-State: APjAAAVGzLkMGhI8hNkf0kiQ6LwFMLvRI1Xm9a7sRO/h/LLvhctLz8hR
        0UaL44Buh53q9PHUWTV4xPc=
X-Google-Smtp-Source: APXvYqyrl02CyuWGoME71ycsn9szsTZRLZLZc3jOYPSj4pzwzDpEU8y1NsQS/kCbWmV2nrtIyJYCkw==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr3270634wrr.112.1582450022518;
        Sun, 23 Feb 2020 01:27:02 -0800 (PST)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id w7sm11849276wmi.9.2020.02.23.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 01:27:01 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 0/1] Fix silent output on Gigabyte X570 Aorus Master
Date:   Sun, 23 Feb 2020 10:24:15 +0100
Message-Id: <20200223092416.15016-1-gladiac@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. This patch sets up a quirk entry for
that. It was tested by myself on my own hardware for some time
and it works just fine. We should probably rename
ALC1220_FIXUP_CLEVO_P950 at some point as the amount of
non-Clevo hardware needing this workaround is growing.

Christian Lachner (1):
  ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master

 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.25.1

