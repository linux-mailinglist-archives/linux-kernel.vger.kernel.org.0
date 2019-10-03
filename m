Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7994C9CEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJCLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:12:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbfJCLMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:12:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667F61000;
        Thu,  3 Oct 2019 04:12:16 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D223F706;
        Thu,  3 Oct 2019 04:12:15 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/4] arm64/cpufeature: Fix + doc update
Date:   Thu,  3 Oct 2019 12:12:07 +0100
Message-Id: <20191003111211.483-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch fix an issue related to exposing the FRINT capability to
userspace (see patch #1). The rest is documentation update.

Cheers,

Julien Grall (4):
  arm64: cpufeature: Effectively expose FRINT capability to userspace
  docs/arm64: elf_hwcaps: sort the HWCAP{,2} documentation by ascending
    value
  docs/arm64: elf_hwcaps: Document HWCAP_SB
  docs/arm64: cpu-feature-registers: Documents missing visible fields

 Documentation/arm64/cpu-feature-registers.rst |  4 ++
 Documentation/arm64/elf_hwcaps.rst            | 67 ++++++++++++++-------------
 arch/arm64/kernel/cpufeature.c                |  1 +
 3 files changed, 40 insertions(+), 32 deletions(-)

-- 
2.11.0

