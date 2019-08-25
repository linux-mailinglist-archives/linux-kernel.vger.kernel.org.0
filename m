Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5E9C5A2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfHYSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 14:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfHYSuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:50:07 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566759006;
        bh=Q6b0H5oj+Ye0iIl2w4Qd29KO8nu6QLDBp/A8jsydm+g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gvHT4a3V8W//+PDIbDqbulfq9WFKEgm2SP7YMqkr84CfCZMQGNpClHUCkiiJ3uDvI
         ZRoRdj953L6n7QpmBjFf//rD9OuEDWdVEyRGMGRA00cJgVZm6S7YOCWsbuSuqnXjnD
         2vOUXcMfLGH7dwhIej+5l6O/HsZwI3x1mJ22FOt0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190825173755.GA19827@gmail.com>
References: <20190825173755.GA19827@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190825173755.GA19827@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.3-rc7
X-PR-Tracked-Commit-Id: a180d023ec7ba0e43b2385876950d9ce7ab618f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c749088f254303c57cb3eaed2b29beaae145cef3
Message-Id: <156675900687.30569.6092160910425491056.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 18:50:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 19:37:55 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c749088f254303c57cb3eaed2b29beaae145cef3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
