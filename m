Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB44C19F82
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfEJOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 10:47:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfEJOrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC0C8AFC3;
        Fri, 10 May 2019 14:47:18 +0000 (UTC)
Date:   Fri, 10 May 2019 16:47:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixup for 5.2
Message-ID: <20190510144718.riyy72g4cy5nkggx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull one vsprintf fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.2-fixes

=============

- Replace the problematic probe_kernel_read() with original simple
  pointer checks in vsprintf().

----------------------------------------------------------------
Petr Mladek (1):
      vsprintf: Do not break early boot with probing addresses

 lib/vsprintf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)
