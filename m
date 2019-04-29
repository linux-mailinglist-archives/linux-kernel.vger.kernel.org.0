Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6DEC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfD2WKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 18:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbfD2WKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:10:04 -0400
Subject: Re: [GIT PULL] seccomp fixes for v5.1-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556575804;
        bh=YKMsjr2Pl5ZVWI+GFbJC6l3R7niMMQuNDS9f+IO50hI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QSisNpw9nbUtIfrgvLv7YAAEFBvBb7uUjmoVflHkX8KoBXxcabcpKWdhoB16Z7eg2
         z4t74e6uH/E6cSVMzYWDm/BDGHzfm84rgSkDWLr8kkMQqgpbELcDiV71CJOo493k9h
         IS0XlzVUVOAI9nh8YfH8xPxbIQ4xHG4gI7AQcPXE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190429195836.GA30688@beast>
References: <20190429195836.GA30688@beast>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190429195836.GA30688@beast>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.1-rc8
X-PR-Tracked-Commit-Id: 7a0df7fbc14505e2e2be19ed08654a09e1ed5bf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83a50840e72a5a964b4704fcdc2fbb2d771015ab
Message-Id: <155657580394.929.13197122571033546186.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Apr 2019 22:10:03 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>,
        syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com,
        Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Apr 2019 12:58:36 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83a50840e72a5a964b4704fcdc2fbb2d771015ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
