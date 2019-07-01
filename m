Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123FD14B6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEFOCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 10:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfEFOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:02:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF3F2054F;
        Mon,  6 May 2019 14:02:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hNeCO-0006xr-Le; Mon, 06 May 2019 10:02:32 -0400
Message-Id: <20190506140206.573397982@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 May 2019 10:02:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/3] ktest: Updates for this merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 37e1677330bdc2e96e70f18701e589876f054c67


Masayoshi Mizuma (2):
      ktest: Add support for meta characters in GRUB_MENU
      ktest: introduce REBOOT_RETURN_CODE to confirm the result of REBOOT

Steven Rostedt (VMware) (1):
      ktest: Show name and iteration on errors

----
 tools/testing/ktest/ktest.pl    | 41 +++++++++++++++++++++++++++++++++--------
 tools/testing/ktest/sample.conf |  4 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)
