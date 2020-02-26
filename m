Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3907B17049C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBZQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 11:42:26 -0500
Received: from foss.arm.com ([217.140.110.172]:38918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBZQm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:42:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86DC230E;
        Wed, 26 Feb 2020 08:42:25 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E94713F819;
        Wed, 26 Feb 2020 08:42:23 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] sched, arm64: enable CONFIG_SCHED_SMT for arm64
Date:   Wed, 26 Feb 2020 16:41:16 +0000
Message-Id: <20200226164118.6405-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Strictly speaking those two patches are independent, but I figured it would
make sense to send them together (since one led to the other).

Patch 1 adds a sanity check against EAS + SMT.
Patch 2 enables CONFIG_SCHED_SMT in the arm64 defconfig.

Cheers,
Valentin

Valentin Schneider (2):
  sched/topology: Don't enable EAS on SMT systems
  arm64: defconfig: enable CONFIG_SCHED_SMT

 arch/arm64/configs/defconfig | 1 +
 kernel/sched/topology.c      | 4 ++++
 2 files changed, 5 insertions(+)

--
2.24.0

