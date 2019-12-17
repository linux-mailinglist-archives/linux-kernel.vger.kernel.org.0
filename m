Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3F122079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfLQAzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 19:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfLQAzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:55:10 -0500
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576544110;
        bh=m6hVQe8WURdeNVv8WpGJ6FgnxA+hW/x7FkFdnmQoEy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AT51RbhfddUZAFLHZne1purg3rhYWDIHGFKZN2IDgMc7tRto6UOhmloKyQh52P4PB
         Z0mX7UzYKxuULmttiOIdne2rluum2V2lbYSBQwvIdiAG/r8EvX63zEDK3mNN+GoJfo
         bBp0itxfZqhP5glGvWauPa3jBgtgnduhXlyGTJXA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191216215320.li7x45fhkrkolvbk@localhost>
References: <20191216215320.li7x45fhkrkolvbk@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191216215320.li7x45fhkrkolvbk@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: e3992af1256a4fe0b83ac790d4caa58ff731609d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea200dec51285c82655e50ddb774fdb6b97e784d
Message-Id: <157654411012.23539.5840718912186133096.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 00:55:10 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Dec 2019 13:53:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea200dec51285c82655e50ddb774fdb6b97e784d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
