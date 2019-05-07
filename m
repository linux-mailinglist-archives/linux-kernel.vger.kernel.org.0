Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996AE16BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfEGTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 15:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfEGTzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:55:14 -0400
Subject: Re: [GIT PULL] Wimplicit-fallthrough patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557258914;
        bh=oGddtjJv+ITElMVnkfbN7CuIkFotXoTbAFX+BeQy75o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t06UFE0mUoCvjg2blF4vIBLSiAgcviqlYQHbuN5UQ1qQxqryXrS0M1VsPkcLz/srG
         tVqDm2rFXUcIW+lcHQ2FOk+xRLZ3khga1M9y+daSLNDeX5HsMrPLNCav8NPw40q4kA
         0yyPyJQiVSLVr7e4/kEXCy1VhzAV5BO5p4XYhQGk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506180521.GA30749@embeddedor>
References: <20190506180521.GA30749@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506180521.GA30749@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/Wimplicit-fallthrough-5.2-rc1
X-PR-Tracked-Commit-Id: ccaa75187a5f1d8131b424160eb90a8a94be287f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4b52b881cf08e13d110eac811d4becc0775abbf
Message-Id: <155725891412.4809.11579272937203075937.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 19:55:14 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:05:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4b52b881cf08e13d110eac811d4becc0775abbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
