Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE716FF38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 13:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgBZMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 07:45:59 -0500
Received: from foss.arm.com ([217.140.110.172]:35310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZMp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:45:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF651FB;
        Wed, 26 Feb 2020 04:45:58 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFA2E3FA00;
        Wed, 26 Feb 2020 04:45:56 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, t1zhou@aliyun.com
Subject: [PATCH v2 0/3] sched/debug: Add uclamp values to procfs
Date:   Wed, 26 Feb 2020 12:45:40 +0000
Message-Id: <20200226124543.31986-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a small debug series I've been sitting on. It's been helpful in
testing and reviewing some uclamp stuff, for instance the issue Qais fixed
at [1] was really easy to observe with those debug prints.

[1]: https://lore.kernel.org/lkml/20191224115405.30622-1-qais.yousef@arm.com/

Cheers,
Valentin

Revisions
=========

v1 -> v2
--------
o Added parentheses for the casting part of the macros (Tao)

Valentin Schneider (3):
  sched/debug: Remove redundant macro define
  sched/debug: Bunch up printing formats in common macros
  sched/debug: Add task uclamp values to SCHED_DEBUG procfs

 kernel/sched/debug.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

--
2.24.0

