Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9579C8B82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfJBOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:42:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJBOmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:42:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 459FA15A2;
        Wed,  2 Oct 2019 07:42:12 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D2B73F706;
        Wed,  2 Oct 2019 07:42:10 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v4 3/6] arm64: Remove gettimeofday.S
Date:   Wed,  2 Oct 2019 15:41:53 +0100
Message-Id: <20191002144156.2174-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144156.2174-1-vincenzo.frascino@arm.com>
References: <20191002144156.2174-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gettimeofday.S was originally removed with the introduction of the
support for Unified vDSOs in arm64 and replaced with the C
implementation.

The file seems again present in the repository due to a side effect of
rebase.

Remove the file again.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/vdso/gettimeofday.S | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.23.0

