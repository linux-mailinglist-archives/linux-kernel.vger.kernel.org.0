Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1554E180BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgCJWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 18:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:40:06 -0400
Subject: Re: [GIT PULL] auxdisplay for v5.6-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583880006;
        bh=luFx5NDZxC/IegO5Me0oisrnc+mVHAyB2SBxgQdODG8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A/wRG42pdIR2zEwzyQRfIbkS9qGbYJ9X0uY+GVK6I9BRyw8FuosOiTOckUQNTRcSM
         ykktc47PLuwz1GVScq3oJ9dxFXeYNQwlkll+5KTC8V8A0PhVj6h5S8bPM9Y3H8IK52
         BSl5Y0+QabzodrOKBGvIV2QDQ9tzqCmaK5HwDzng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200310161330.GA16596@gmail.com>
References: <20200310161330.GA16596@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200310161330.GA16596@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/auxdisplay-for-linus-v5.6-rc6
X-PR-Tracked-Commit-Id: 2f920c0f0e29268827c2894c6e8f237a78159718
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a48b37931572802e980dc059e03ec29a33d2963
Message-Id: <158388000636.13098.906091997509689875.pr-tracker-bot@kernel.org>
Date:   Tue, 10 Mar 2020 22:40:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Mar 2020 17:13:30 +0100:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a48b37931572802e980dc059e03ec29a33d2963

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
