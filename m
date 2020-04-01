Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9487419B87D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 00:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgDAWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 18:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733164AbgDAWfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:35:18 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585780517;
        bh=ZlR4YxwcQrxBAKuDQ7x5NVYWynkwjauJ0dG963bqR5E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L7zSZwkf+nlc/vKaIXaTgQCys/3DfWO9qK1bMpw2qvBHpKaVpgRR3bpW1d7J/tYX9
         hM2X4do6vPlMm0FAGdsqF2GEMkOHaBq3nvjQje9/PkQ7bZlnMjugtvikdmWuSXwmO/
         UN8Fy4Vn8StYdvx9lIWwnWNSI0k1oxHy8s/eegMI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com>
References: <CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-v5.7
X-PR-Tracked-Commit-Id: 0a67003b1985c79811160af1b01aca07cd5fbc53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4646de87d32526ee87b46c2e0130413367fb5362
Message-Id: <158578051756.24680.13640836559917741865.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Apr 2020 22:35:17 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Mar 2020 23:47:56 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4646de87d32526ee87b46c2e0130413367fb5362

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
