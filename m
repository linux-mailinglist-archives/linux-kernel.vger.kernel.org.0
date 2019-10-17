Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727FDDBA48
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 01:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441810AbfJQXpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 19:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732678AbfJQXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:45:05 -0400
Subject: Re: [PULL 0/6] xtensa fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571355905;
        bh=DsIeZVKxk6uBBwAlO9Bg1hDtoXfMM4WPeWWBIZ2WdnA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ECDaNZn1QEfEW+8LyLo0ypZg8m0+ilGbGxwki1ShkGVGfS3YIFiVVFOxkFKdzr+3D
         r+q1NifzOPc6iQNwA1mQA4hutuHtw0uv6hKI67X0Vg2Xo7Ww8VMj5ODhoeGFb5PctR
         GrZ6pMz1fgA0aHJDk75IiyB1C8dAFc993y9adLts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017224910.18457-1-jcmvbkbc@gmail.com>
References: <20191017224910.18457-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017224910.18457-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20191017
X-PR-Tracked-Commit-Id: 775fd6bfefc66a8c33e91dd9687ed530643b954d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad32fd7426e192cdf5368eda23a6482ff83c2022
Message-Id: <157135590509.25652.1426724248164384090.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 23:45:05 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Oct 2019 15:49:10 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20191017

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad32fd7426e192cdf5368eda23a6482ff83c2022

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
