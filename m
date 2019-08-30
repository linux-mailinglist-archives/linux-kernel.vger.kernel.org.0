Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A8A3C33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH3QkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfH3QkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:07 -0400
Subject: Re: [git pull] drm fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567183207;
        bh=RQpENOibGm538Vo2VFQB4mDCy6CplOCqcKnCCEE2qpc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lj/tSXdxoz5HdDxhFuE2q8X+jlgnEI+HoucnDAwbWQW2nSSs5at036FQzmK8iaG62
         gNXccfBCqge/PRokeb2pTJ0qHLGtiTSejm30ZM01OXHFTO6QxFQ8lfiaBz1jOicfao
         /COFZRLofbvGRODFLii8uhJZ8bw3gmXf5evt2aks=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzaHaDUoSGC6_ESxTFWQxqgAZnDWzYNqx0zX17bv4KTUQ@mail.gmail.com>
References: <CAPM=9tzaHaDUoSGC6_ESxTFWQxqgAZnDWzYNqx0zX17bv4KTUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzaHaDUoSGC6_ESxTFWQxqgAZnDWzYNqx0zX17bv4KTUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-08-30
X-PR-Tracked-Commit-Id: 1c0d63eb0e824cb2916a77523ec7a4fa0e9753c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f69f199271ec5f765b056dfca703587d6d2b7aae
Message-Id: <156718320715.32023.8029988842983680256.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 16:40:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 13:51:31 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f69f199271ec5f765b056dfca703587d6d2b7aae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
