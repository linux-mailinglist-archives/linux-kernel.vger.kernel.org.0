Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0106157778
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgBJNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 08:00:41 -0500
Received: from foss.arm.com ([217.140.110.172]:60716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbgBJNAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:00:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF771FB;
        Mon, 10 Feb 2020 05:00:20 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67CB93F68E;
        Mon, 10 Feb 2020 05:00:19 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        richard.henderson@linaro.org, tytso@mit.edu, will@kernel.org
Subject: [PATCH 0/4] random/arm64: enable RANDOM_TRUST_CPU for arm64
Date:   Mon, 10 Feb 2020 13:00:11 +0000
Message-Id: <20200210130015.17664-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 systems some CPUs may have RNG instructions while others do
not, and consequently we cannot generally enable the use of RNG
instructions until all CPUs have been booted (as otherwise we'd have
problems with preemption, etc). This prevents us from seeding the
primary CRNG using the RNG, as this occurs before secondary CPUs are
onlined.

These patches rework the core CRNG intialization code so that the arch
code can (optionally) distinguish boot-time usage from runtime usage of
the arch_get_random_*() functions. This allows arm64 to use the boot
CPU's RNG to seed the primary CRNG, regardless of whether secondary CPUs
support the RNG instructions. Other architectures should see no
functional change as a result of this patches.

Thanks,
Mark.

Mark Rutland (3):
  random: split primary/secondary crng init paths
  random: add arch_get_random_*long_early()
  arm64: add credited/trusted RNG support

Richard Henderson (1):
  random: Make RANDOM_TRUST_CPU depend on ARCH_RANDOM

 arch/arm64/include/asm/archrandom.h | 14 ++++++++++
 drivers/char/Kconfig                |  2 +-
 drivers/char/random.c               | 52 ++++++++++++++++++++++++++++---------
 include/linux/random.h              | 22 ++++++++++++++++
 4 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.11.0

