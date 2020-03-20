Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84918D581
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTRPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 13:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgCTRPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:15:09 -0400
Subject: Re: [GIT PULL] sound fixes for 5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584724508;
        bh=rZAo5O+lN3GPqMvU5RktRv74nMxT/GT+Y45YO/aK2bU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JZtm2ZXpL3HPNNdjG+lSdz2cFoX/JkgZgzDrlUI1WmV5RO/EWdccKRXBT7AybXuNb
         8ScxwJwkOXG6ROLJJ2FIAqQQAbkHCGVl2TMOttdwIRI9/BmPHOaQQfjDmx8NJlMdUB
         oVnCEttBjFMQ2fVuiy1RZvORee4kLqMFaH5fCRS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9mzs2k5.wl-tiwai@suse.de>
References: <s5hv9mzs2k5.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9mzs2k5.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.6-rc7
X-PR-Tracked-Commit-Id: a124458a127ccd7629e20cd7bae3e1f758ed32aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12bf19c9268263cf8fc6653966813ff9d5ceef17
Message-Id: <158472450863.23492.261015574928411887.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Mar 2020 17:15:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Mar 2020 12:12:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12bf19c9268263cf8fc6653966813ff9d5ceef17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
