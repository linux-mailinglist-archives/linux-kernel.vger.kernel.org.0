Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3758FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF1Bvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1Bvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0B673DDBE;
        Fri, 28 Jun 2019 01:51:32 +0000 (UTC)
Received: from treble.redhat.com (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65439196F6;
        Fri, 28 Jun 2019 01:51:30 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 0/2] x86: bpf unwinder fixes
Date:   Thu, 27 Jun 2019 20:50:45 -0500
Message-Id: <cover.1561685471.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 28 Jun 2019 01:51:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the last fix along with its objtool dependency.

For testing I verified that a WARN() in ___bpf_prog_run() now gives a
clean stack trace.

v4: 
- Redesigned the jump table detection mechanism.  Instead of requiring
  the jump table to have a magic name, place it in a special section.

- The other two fixes from v3 have been merged into -tip.

Josh Poimboeuf (2):
  objtool: Add support for C jump tables
  bpf: Fix ORC unwinding in non-JIT BPF code

 include/linux/compiler.h |  5 +++++
 kernel/bpf/core.c        |  3 +--
 tools/objtool/check.c    | 27 ++++++++++++++++++++-------
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.20.1

