Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00ECB1FD73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 03:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEPBqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 21:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfEOXyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:54:21 -0400
Subject: Re: [GIT PULL] tracing: Updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557964215;
        bh=mQ3Fo55wJJGFQVP/8FsvP0aIRrhv6YJl4QIFLfcwRk4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ih5oQr+UaMnhjEm0wZWNSQ6Sw3aiztWtAQZp525PKysB/A+UZucnEkxGHNnp0fu0g
         koVQU8XWQTOS+LJxH5dB4HJxeSzlXXKn3IsNOZgHm/vK43japUgCzX14IfqCMY6HwT
         BWeYZbl2zO2szwOAKNe580v8DMZNGlHddc1KkdLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515133614.31dcbbe0@oasis.local.home>
References: <20190515133614.31dcbbe0@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515133614.31dcbbe0@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 trace-v5.2
X-PR-Tracked-Commit-Id: 693713cbdb3a4bda5a8a678c31f06560bbb14657
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2d8b146043ae7e250aef1fb312971f6f479d487
Message-Id: <155796421516.28278.8898095131927032779.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 23:50:15 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 13:36:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2d8b146043ae7e250aef1fb312971f6f479d487

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
