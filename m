Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0469012F2B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 02:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgACBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 20:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgACBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 20:25:06 -0500
Subject: Re: [GIT PULL] seccomp fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578014705;
        bh=zNbPi2PuJbBdVAveB7KK4k7YCBbzBzu4nIE5X20EKH4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2SUIR9KChgcx61tbpf3VNeeqLFb82QvczBL8nTCcL7bkoqSuon9N1hAo3NA9Xa1aX
         vQkNnBycmmUGDqNLq7ZJDi8DXqZEmvl0ey6PPJP9Pa5sNuvya/7Nxrs+NyD6zfKFG6
         p4we30P448xwIXGQ2nI/dJ2K+UQyP3uZ+UC06wvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202001021325.8D02D326B2@keescook>
References: <202001021325.8D02D326B2@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202001021325.8D02D326B2@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/seccomp-v5.5-rc5
X-PR-Tracked-Commit-Id: e4ab5ccc357b978999328fadae164e098c26fa40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf6dd9a58ebaba2608d2aebd2a7a704014121f16
Message-Id: <157801470566.30243.18378798403018784687.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 01:25:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Jan 2020 13:28:30 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf6dd9a58ebaba2608d2aebd2a7a704014121f16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
