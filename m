Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D519327F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfFCFVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 01:21:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52634 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfFCFVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:21:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 086FD1340D53C;
        Sun,  2 Jun 2019 22:21:08 -0700 (PDT)
Date:   Sun, 02 Jun 2019 22:21:07 -0700 (PDT)
Message-Id: <20190602.222107.923223011133534329.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 22:21:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get these three bug fixes, and TLB flushing one is of
particular brown paper bag quality...

Thanks.

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 56cd0aefa475079e9613085b14a0f05037518fed:

  sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD (2019-06-02 22:16:33 -0700)

----------------------------------------------------------------
Gen Zhang (1):
      mdesc: fix a missing-check bug in get_vdev_port_node_info()

James Clarke (1):
      sparc64: Fix regression in non-hypervisor TLB flush xcall

Young Xiao (1):
      sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD

 arch/sparc/kernel/mdesc.c      | 2 ++
 arch/sparc/kernel/perf_event.c | 4 ++++
 arch/sparc/mm/ultra.S          | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)
