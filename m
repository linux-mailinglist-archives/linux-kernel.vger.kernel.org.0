Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00884AADB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391773AbfIEVPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 17:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbfIEVPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 17:15:06 -0400
Subject: Re: [GIT PULL] clang-format for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567718106;
        bh=PKEnLntocNbyXP/dyHSTSAKjREdQCTKrP5cSIRS53rM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CJiWqQXctnnM8Ym150/YD8UIpO8Or/CTxFcPvqqEiwOnK4Yt6ucgudOu95M0LlRbX
         Fhgmh18Af4fuQu1VBBryK0mQa/lzZvD9sTUkkxHGJszQSJbRSnDWNS5jRV02X+SCCK
         z+bctJhPIB7hbpVvO37klqIDbLBsO13AMEFrWzO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190904182949.GA22025@gmail.com>
References: <20190904182949.GA22025@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190904182949.GA22025@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.3-rc8
X-PR-Tracked-Commit-Id: 52d083472e0b64d1da5b6469ed3defb1ddc45929
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13133f933ac463f233fbf118061c4c47cd72eecf
Message-Id: <156771810610.8025.1118786210637246111.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Sep 2019 21:15:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 4 Sep 2019 20:29:49 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.3-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13133f933ac463f233fbf118061c4c47cd72eecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
