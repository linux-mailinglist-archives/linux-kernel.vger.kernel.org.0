Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C472E1101B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLCQBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 11:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLCQBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:01:21 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021322068E;
        Tue,  3 Dec 2019 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575388880;
        bh=jkBUQrSgUgGuYi2/x35a9RIQ6ObfXrVeYYv/CvzsuXU=;
        h=From:To:Cc:Subject:Date:From;
        b=y7DFqDxbcjFqmQ0XKsnTaUo3pAot11Na+FXL9eM/vNox2nuaXCqJV8FgTQRlNVzhV
         W5l0TunIaIZwEkIurI97Ca4B14WkvKW0TGRDNpoyChXdBUuMSZEpygbuX3a/HN0UUL
         rwvXMBfeH+VUFdqq01kWVOmQIhGpjpkyzWD7lMKk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 0/2] sched: Spare IPI on single task renice
Date:   Tue,  3 Dec 2019 17:01:04 +0100
Message-Id: <20191203160106.18806-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches to avoid disturbing nohz_full CPUs when a single
fair task get its priority changed. I should probably check other sched
policies as well...

Frederic Weisbecker (2):
  sched: Spare resched IPI when prio changes on a single fair task
  sched: Use fair:prio_changed() instead of ad-hoc implementation

 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.23.0

