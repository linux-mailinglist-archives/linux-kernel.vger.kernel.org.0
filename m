Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8176EB58AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 01:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfIQXkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 19:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfIQXkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:40:23 -0400
Subject: Re: [GIT PULL] OpenRISC updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568763622;
        bh=kLKZitWy51c39whjamUqyD8DswbGqDysDVYJ5EsQEes=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PkcVRpjXNUOHBm5M55/zkOmDEeblhQUhy1U7BmKl+flnOz5n2Ox0XajYa+BTINtir
         q2MNEOEn+Ef0iXQdrOTKPuNwVo+J9g3RnKQdBiJ06RN+0D9gCIqAM3P+n1MWq7Qe2h
         kVhTtwK0Wf+Ux0tRrG3kwlEyyi3jOQRxUvLlfLNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917123312.GC24874@lianli.shorne-pla.net>
References: <20190917123312.GC24874@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917123312.GC24874@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: f3b17320db25b4cdd50f0396b096644455357dac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e24aaabdee9e07f19b09bd305ffc069b0b07371
Message-Id: <156876362260.26432.2354402645003335433.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 23:40:22 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, hch@lst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 21:33:12 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e24aaabdee9e07f19b09bd305ffc069b0b07371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
