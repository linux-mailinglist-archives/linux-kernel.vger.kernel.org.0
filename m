Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3815A41C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgBLI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 03:58:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38236 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgBLI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so1222624wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3yrvW1QnDdvO63in3dRUZs4rJOwYNpH9/tgF+hnzj7A=;
        b=oP3fH6O+4ITPoX9/Zi/S3apt/zZIU9P7OQnfv2RTQG2UQlro4x1SAXbLd/UJJvtQBd
         0HjbcLt+hjzcp/hI9kPu+l8EKNCLYyVFujCf/SxUHI6OVTFNx6hKj9UJ8dKCq27Jtfjv
         iNeP8pS18UUxN6ilxG8KsQLiVhfmIwoCM1+nSTy3FeyD/L6MpZeJxfK6fS5Bx7YKOEuA
         d2MziozttVmnbtCHoTMnG4hyuzqjIWiZ6KD7D2bH0btWJFKoPiSz7PIaxxAZnczj07Ew
         RgzTGrzMXVsznewMYJTfAAh7Wuh25ptXuJGpShHsz1tjpRYgTMQmYPr4oCa+0VTrdSIS
         IvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3yrvW1QnDdvO63in3dRUZs4rJOwYNpH9/tgF+hnzj7A=;
        b=LyVgYC0MBZSGaXpTk5TUus84JUsbCn7NWqWELp3mOajGT2oxn9Fqxlyt653EwBTjHw
         EqqjMcOxtFtLEAZPSPpMotd28pL3i+rMTa91ZkEYvB15oyvoxpMp1NkxESgum7ZOzmmf
         no1cL+dcPLy1SsuKfSsQm5UFCRhA/6xUQW3O3ukdSoRbOzANFdbUery5mUuILA38mU09
         l3Gx6iv5IbN5Y2yUBHEoueO6WnBaqLEoJKYAsajUHzAxfKJQVVm6R7ymXg4KepJBaa0L
         dLJ1BCyVNWr3nYdYqa7ZHlV7jIAwPhQc8ClD9HnvTANVjSxi4MaIWokvi2DzM/DdeYMb
         4lOQ==
X-Gm-Message-State: APjAAAWbFMAFkDyffRtcP5r2Dc9fW/lUh/Ysnrw7NRCrIMTsmJpgfnZS
        xbs4S8Izf+PrJXgA622JYehZl9DKbvbMRw==
X-Google-Smtp-Source: APXvYqxl6EMFnQECsh0qHrFjZYiGEKhyjBd0znZaDnf8uRTRKLuTXujl4JXhh+JdsdZCmAeJrEVcYw==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr12036781wmg.13.1581497901298;
        Wed, 12 Feb 2020 00:58:21 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g25sm9352693wmh.3.2020.02.12.00.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:20 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH 07/10] microblaze: Add missing irqflags.h header
Date:   Wed, 12 Feb 2020 09:58:04 +0100
Message-Id: <bb096275c875973d5cd56271d27cbbede5d324d6.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Asserhall <stefan.asserhall@xilinx.com>

Without this header local_save_flags() is not defined.

Signed-off-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/cpu/pvr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/microblaze/kernel/cpu/pvr.c b/arch/microblaze/kernel/cpu/pvr.c
index 8d0dc6db48cf..f139052a39bd 100644
--- a/arch/microblaze/kernel/cpu/pvr.c
+++ b/arch/microblaze/kernel/cpu/pvr.c
@@ -14,6 +14,7 @@
 #include <linux/compiler.h>
 #include <asm/exceptions.h>
 #include <asm/pvr.h>
+#include <linux/irqflags.h>
 
 /*
  * Until we get an assembler that knows about the pvr registers,
-- 
2.25.0

