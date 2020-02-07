Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A2B1560E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 22:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgBGVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 16:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgBGVzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:21 -0500
Subject: Re: [GIT PULL] Documentation fixes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112520;
        bh=MIvv6CaYu0zTE0GTb/zh7bqZ4dno+909vzroeWAssOA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XsMl9dCghAlTcIkZlSEZPhwrwGir4GtXMbVYJwmy/KKhXIAyEKo5bDjqmKqz9cvB6
         c110rhJHyHqt33k7gZ9VoNbIqTmiAALDZW44wdoxvZrp2vHplCvFkHmjpfVRfxVJjl
         zgzogQEjdE8iCdHx06E7MJhXTSrBcOI+t/nW1g6E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200207101614.4b5d6bc0@lwn.net>
References: <20200207101614.4b5d6bc0@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200207101614.4b5d6bc0@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.6-2
X-PR-Tracked-Commit-Id: d1c9038ab5c1c96c0fd9d13ec56f2d650fe4c59f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41dcd67e88688afbeb3b2bd23960eed5daec74e7
Message-Id: <158111252088.9631.9448670431680002920.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:20 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 10:16:14 -0700:

> git://git.lwn.net/linux.git tags/docs-5.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41dcd67e88688afbeb3b2bd23960eed5daec74e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
