Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A259BFE414
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKORfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 12:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfKORfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:06 -0500
Subject: Re: [git pull] drm fixes for 5.4-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839306;
        bh=qRUpeut5kwGB05XEdaCmELLksALookGgKdjeXYvSEIo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f+Fb9w3XaZLUlDF34lXlewqZuVfPQTqhD28a7/M3frMHm4+TSRMY63pdz38092JF0
         zTZef3tOOyKonRrvf0NrDu/X2362E+VwTolj4VwPy0P3su9kZvIl3XI4p4kUyajyxe
         qWx1frAeml2TBJcLkAwUF0nq42JCeuIqgA/DHWTA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twvcfHPb4nrAQnHaEWhQrbByR0CfGXbWo_479c3YR47uw@mail.gmail.com>
References: <CAPM=9twvcfHPb4nrAQnHaEWhQrbByR0CfGXbWo_479c3YR47uw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twvcfHPb4nrAQnHaEWhQrbByR0CfGXbWo_479c3YR47uw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-11-15
X-PR-Tracked-Commit-Id: 07ceccacfb27be0e151b876caeda3a556cef099c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37b49f31e800b563ed7a601816ea4b6fc3c5d165
Message-Id: <157383930603.31249.14123556472751707976.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 11:18:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37b49f31e800b563ed7a601816ea4b6fc3c5d165

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
