Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669951560E1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGVzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 16:55:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgBGVzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:18 -0500
Subject: Re: [git pull] drm fixes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112518;
        bh=eOg7uCNUfLa/+rx8dVAnlqV5Q9xH+G5SaYr0Z0vRbfY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZmKoPJzqR97Ld84+oP3V0vF7CuJbs8UeLbMf02Fl3kwBqsZTtnycw7OmpXk7fSdLj
         1HHfdDu0drAEEKzDxs2ppxH3Yj4Tzb51aP3X4pOsZrn3W9qSZwJDsPTKmZNjRmKjKr
         fJszRvn5qP6ji4VYHKc2IuMCrL7Jw+KATeDJhaUg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
References: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzWZoQ_t-v2p=m4LKFE+Mb9oofL406dLvaXOiappqcNhA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-next-2020-02-07
X-PR-Tracked-Commit-Id: 9f880327160feb695de03caa29604883b0d00087
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c16b99d6c5a3f103ae45e33084055a2440d70544
Message-Id: <158111251847.9631.6641473871149555872.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:18 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 13:29:48 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-02-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c16b99d6c5a3f103ae45e33084055a2440d70544

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
