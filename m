Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35BB1076AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 18:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKVRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 12:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:45:05 -0500
Subject: Re: [git pull] drm fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574444704;
        bh=kQYKiTk7zb6jNlv5eVIlG9ohIWg/3K5a0IpZFhJDlSo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JhePflTCymCOIzX8FRr+WcY8U4aAGNvdY4a3rsXVAeJGsa5HmPakqpJ127p3SRBpK
         5xbhZR6SS5MTklbsxazgHL1P/kU3x3r2iEyUPIqvimAuBzpRprjqeGVWCV3XSnUwLH
         eF1J5OQfPFelplTGl0ratmL3yKvzrlpiCUQhkCrw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txZ7F80TCRMtgRbkCGcv=gCp9_+YoZLZRBo2N7H09jN=Q@mail.gmail.com>
References: <CAPM=9txZ7F80TCRMtgRbkCGcv=gCp9_+YoZLZRBo2N7H09jN=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txZ7F80TCRMtgRbkCGcv=gCp9_+YoZLZRBo2N7H09jN=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-11-22
X-PR-Tracked-Commit-Id: 51658c04c338d7ef98d6c2c19009e4814632db50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d867ab037e58da3356b95bd1a7cb8efe3501958
Message-Id: <157444470451.7762.2473889646692778156.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Nov 2019 17:45:04 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 10:43:28 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d867ab037e58da3356b95bd1a7cb8efe3501958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
