Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF747738E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfGZVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 17:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfGZVkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:40:19 -0400
Subject: Re: [PULL] drm-fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564177219;
        bh=emBU+oPGje0smBOyOoPBoM1vo0glhiK92u22oNz4+Js=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yKbz555GdrYsBy2/oTadiLaafo+HU144c9UtWqM5mieiESv/8TpScuRjhg0kfayTk
         zsgMVbFG2c1nwhXXA+XRdYqNt7VqJ4nEP8XltM2yUhmpsN6s9t3zaGDGZ4RsF1BeA8
         ehCdhN+FrAyt/MQI2rvUdTtR3JXEsg8BHMTGChxs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190726194555.GA30301@phenom.ffwll.local>
References: <20190726194555.GA30301@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190726194555.GA30301@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-07-26
X-PR-Tracked-Commit-Id: 4d5308e7852741318e4d40fb8d43d9311b3984ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2921f9f95f1c1355a39e54dc038ad95b6e032be
Message-Id: <156417721902.826.16445476014312983791.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 21:40:19 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 21:45:55 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-07-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2921f9f95f1c1355a39e54dc038ad95b6e032be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
