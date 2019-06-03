Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89933BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFCXT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 19:19:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45842 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCXT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:19:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id x7so6563412plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wUZaTX20lO5SbHm8MIXLE78PHSIeTBs27Rwb+WEEumQ=;
        b=QzjQulAQyEyEou1aENfn0yzV7aUxGvQgHJ7WtEZ3CbkQKC6PgWZCf/1lZCKScrlCXM
         TM7Lt2zPzyPrjJ/xEAmG8aTeu2IwDl9S6vh5RUCt9mZc4sXh6kqz6wpbiGue/zxm58jn
         mAbOOJLJIvyDmXWu6XBh98gcv7GFUVG/NHNRTgQemKIw/qxA5EhhzxTUDJZuCixQaHSO
         HijrRFJkpf3R0dBo+BC0M6wEv6GzsRfnOzwwyDXOcOl5xvm37Mz288SoxXmdmy/Bv7TP
         ZLzhzdd2VNg1p7TqmkSUK3sZQDGH7bB3UO9R6xUREs7tUYKr/X/05X9RGyr7kQQ059F2
         mGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wUZaTX20lO5SbHm8MIXLE78PHSIeTBs27Rwb+WEEumQ=;
        b=okN4m2RnupJVF0KOAn1SwkaW9mm2fQ5n+aW8G98GvGy9yAotiS7Ah4QjGI3Eb0cYAV
         Z2m2A/UfOXC+i2w1zD43+8yPDmtS8gy8e8opzHzvqwolzRwcfUMuBxWHy1QNwGZk0gjr
         nqKO5UYxfFaGCbwXz0htMY5Uesv+ytmrbdsWkYZeoQ/RkRnwU6BnNsLArCRYNSVSoJcn
         oJe41O0M/amMH2dARieKq8ei1ohzSX2U4KjueF5bz1zIIiUbOUV3gj9R/SQ0EuUycOzt
         kOFF5zvSkS4qz1yPSypkdlsi2eEQGMmFrS1OgKbzBnJLSeKQMif0mUvVXD9EqdVDtIDy
         ZPnA==
X-Gm-Message-State: APjAAAUUq6h8yeyfDcPt2ux4Z0X+KeOx52LcU02LQc3iPv1PUsTEa/rB
        0V8V/vyR1kCOCfgQnLtHfjQ=
X-Google-Smtp-Source: APXvYqxF6SmFOQ6tt0UoToS74s/iqAalOxlfLDzhjZ8BPPoW/A45I6J1WKUxChGNQ8jSEbgJd0bXiw==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr24543317plm.237.1559603997494;
        Mon, 03 Jun 2019 16:19:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a64sm12666564pgc.53.2019.06.03.16.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 16:19:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/2] ARM/ARM64: Move cpu_logical_map[] to smp.h
Date:   Mon,  3 Jun 2019 16:18:28 -0700
Message-Id: <20190603231830.24129-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These two patches make ARM and ARM64 consistent with other
architectures: sh, sparc, xtensa, mips, etc. to define cpu_logical_map
under asm/smp.h, which is included by linux/smp.h. This allows other
pieces of code like irqchip drivers to get access to cpu_logical_map[]
using linux/smp.h.

Changes in v2:

- just move __cpu_logical_map[]/cpu_logical_map[] to smp.h

Florian Fainelli (2):
  arm64: smp: Moved cpu_logical_map[] to smp.h
  ARM: smp: Moved cpu_logical_map[] to smp.h

 arch/arm/include/asm/smp.h        | 6 ++++++
 arch/arm/include/asm/smp_plat.h   | 5 -----
 arch/arm64/include/asm/smp.h      | 6 ++++++
 arch/arm64/include/asm/smp_plat.h | 5 -----
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.17.1

