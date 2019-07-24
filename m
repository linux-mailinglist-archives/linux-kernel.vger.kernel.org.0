Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97D741AF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 00:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfGXWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 18:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388286AbfGXWsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05F86302246D;
        Wed, 24 Jul 2019 22:48:52 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-90.rdu2.redhat.com [10.10.122.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C11CD1001B04;
        Wed, 24 Jul 2019 22:48:50 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] uaccess fixes
Date:   Wed, 24 Jul 2019 17:47:24 -0500
Message-Id: <cover.1564007838.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 24 Jul 2019 22:48:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An i915 redundant CLAC fix, and an objtool fix which would have caught
it earlier.

Josh Poimboeuf (1):
  drm/i915: Remove redundant user_access_end() from __copy_from_user()
    error path

Peter Zijlstra (1):
  objtool: Improve UACCESS coverage

 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    | 20 +++++++++----------
 tools/objtool/check.c                         |  7 ++++---
 tools/objtool/check.h                         |  3 ++-
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.20.1

