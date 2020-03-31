Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36997199B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 18:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgCaQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 12:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCaQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:30:11 -0400
Subject: Re: [GIT PULL] m68k updates for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585672211;
        bh=xHlxOVNqRjLM+m3oL3eU9x1hbH/cObk/9Ml0wjz+M/U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=09wvPVi+LQXZw/Bf8f+3Nar9TM1aJwWR8j/cDyVJKelrgdozQiPbTdUnnzehPv+eu
         PfWPBs40g40olOj1rAruwTjEYKmQa0qLTs/UoIwsbmxP+R/DAdwMjIpfSlqlqWmYL5
         ju6k/3eV3W1RVgaJ3kNloKZ2WmIZE9XNvMdIrwcc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200330100535.4967-1-geert@linux-m68k.org>
References: <20200330100535.4967-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200330100535.4967-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 m68k-for-v5.7-tag1
X-PR-Tracked-Commit-Id: 86cded5fc52567774b596827544874499532b8ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58233ccf94607c1df2c545b689c52c0b002f054e
Message-Id: <158567221098.1514.9172777259183005240.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Mar 2020 16:30:10 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 12:05:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v5.7-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58233ccf94607c1df2c545b689c52c0b002f054e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
