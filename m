Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDA1CE49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfENRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfENRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:50:18 -0400
Subject: Re: [GIT PULL] Backlight for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557856217;
        bh=ekdsKgf6vb4yWaZGzMHVU6cmwiDeEtGXgOWr+9O9SFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M51I9Rv9bUOhYYlNwWzGsdEwOS0SwSf7IpbSHXkWJegkgjmGf4DWvFQgbb5DyC99K
         EU7rlxRzOHnoKe7Sd0M504J6qAc8Fa9HyylY07LK549JCGXPmYAkveNRTrF9Y766ly
         MBeEgZmkX2ojQfffqXTYTNNaMRwAEg6iiX9Y5cwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514104133.GN4319@dell>
References: <20190514104133.GN4319@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514104133.GN4319@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.2
X-PR-Tracked-Commit-Id: 8fbce8efe15cd2ca7a4947bc814f890dbe4e43d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0654264c4806dc436b291294a0fbf9be7571ab6
Message-Id: <155785621772.23900.3860716418450619063.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:50:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 11:41:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0654264c4806dc436b291294a0fbf9be7571ab6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
