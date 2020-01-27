Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18014ACD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgA0XzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 18:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgA0XzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:05 -0500
Subject: Re: [GIT PULL] SELinux patches for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580169305;
        bh=/RHbzCKM561zYe8Wjo0KSVUZ77qX9Vyf1BOcLlnjz/Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QBSWodMLhwQyJ6CUCjO0ksG0WuSjc1emxTEFfmkt2BILXwhNXOO7qxJOe3ZZ78zhi
         tFDYdf5MOeVLAJObvZQjkMN6v86xyJcHh1XBY7BwMId80gl0GgjnerMndGLWMiTcXL
         fJjAP1XUrk+M98FqR7XuXAoMnHXcf1QdNbqucBMg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
References: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhR_5564up7u1V-PRXOz_RRfTLj16m508qgNvdWC8gcRTA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20200127
X-PR-Tracked-Commit-Id: 98aa00345de54b8340dc2ddcd87f446d33387b5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1dba2473114588be3df916bf629a61bdcc83737
Message-Id: <158016930519.17044.11033207196664253320.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 23:55:05 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:26:18 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20200127

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1dba2473114588be3df916bf629a61bdcc83737

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
