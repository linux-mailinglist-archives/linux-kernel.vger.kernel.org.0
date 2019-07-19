Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E5C6EB43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfGSTp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 15:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387565AbfGSTpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:25 -0400
Subject: Re: [PULL] drm-next fixes for -rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565524;
        bh=i+PCBNu57gHOpirHmEo1+Qwpm5zVD18MBNcnfEZKYPg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Megbv5LGEDYK7/pSL5O+w8eZZxQInmOV5nNlUAdLTLFrMEaH7c9ad5aCor2Jtu4Av
         aj2PTfv9ED1/kYCxpJ9627PelcwetpXglNRttuRtpCo5AryAs9tr5nOCZz5qXLrzBd
         rysi0O5x70dC3LW7DvKRS5l4tDB7B/U6KazUH6eo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719154207.GA9708@phenom.ffwll.local>
References: <20190719154207.GA9708@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719154207.GA9708@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2019-07-19
X-PR-Tracked-Commit-Id: 8ee795625665208589a97972b01790bb04ea83e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31cc088a4f5d83481c6f5041bd6eb06115b974af
Message-Id: <156356552472.25668.6959970865866797426.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:24 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 17:42:56 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2019-07-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31cc088a4f5d83481c6f5041bd6eb06115b974af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
