Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782AB7CEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfGaUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 16:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfGaUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:35:16 -0400
Subject: Re: [GIT PULL] tracing: Minor fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564605315;
        bh=Q/sIV9523h3i8lCTiYNbY5Y9xmNac/O1XoFaujU1Xn4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ixpEfEB08vouyxP/f3XxZyprYD3AUd1N0LEb0a77jDITrqwML3JtApRAVY/XSCNy/
         QpnqYNrKo5eZ/6lv1G9VIZvHU08887k8+hgG9+3mh+K/zJkhKMlpAap2rf/REPacQN
         R2en8uMjdsjl0lwUTKvV8EHoLzoM/fJGZZ2oFo14=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190731110517.4e065b29@gandalf.local.home>
References: <20190731110517.4e065b29@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190731110517.4e065b29@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.3-rc2
X-PR-Tracked-Commit-Id: 6c77221df96177da0520847ce91e33f539fb8b2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2eee9fca172d0d010ef3060cdc971e0b079b87f
Message-Id: <156460531584.15680.4846519904319741266.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Jul 2019 20:35:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Changbin Du <changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 31 Jul 2019 11:05:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2eee9fca172d0d010ef3060cdc971e0b079b87f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
