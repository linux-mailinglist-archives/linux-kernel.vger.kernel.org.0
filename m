Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43EC18BDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCSRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCSRZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:25:07 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584638706;
        bh=lnsQjdeqJQsdSGPoMaKkmJ46L3EHOJRkUYALAl/T4nI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QfURL3qSTgykW8OKyPew6FC2qUrN+6/U1ZCOiFVKUtL8cKHL3n4GJHltI+6X+J/OO
         rzpswnOyInQDAqygVyXYmYzPstfdrzozoUuKiylrQ39vVV+LIQ4eam9xCQW3/2Shfv
         UW1Bxi+FiM0wqRGrjBz3OUqMaWHd49QCYE5E7aNM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
References: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 5.6-rc6-smb3-fixes
X-PR-Tracked-Commit-Id: 979a2665eb6c603ddce0ab374041ab101827b2e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd607737f3b84432b8a00cd31ac753dab1c38678
Message-Id: <158463870646.20508.5032357592544063265.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Mar 2020 17:25:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Mar 2020 23:51:13 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git 5.6-rc6-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd607737f3b84432b8a00cd31ac753dab1c38678

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
