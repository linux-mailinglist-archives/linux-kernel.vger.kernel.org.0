Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A55ED3F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfKCRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 12:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfKCRPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:15:05 -0500
Subject: Re: [GIT PULL] USB fixes for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572801305;
        bh=zy64mMfFoaabPue1WLiYD7/7Haa3CKxc30MQcp2EXfo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0uZAeEnNGwA6aEJXXYcOl+7UDBGsmM/XpydXrnFFk7EQKoPtTKAit4kzVUT+ErWhE
         cPdVawcs32+cB4xPxhpZnvrz4B+u7Inj3kG9le4w/iG0DVuRD1yIJqql+44XdIaiFu
         dOsaNR1A+BZZXCszxjQE4W9tUaTb9WjpJykW6OXk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191103141534.GA661190@kroah.com>
References: <20191103141534.GA661190@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191103141534.GA661190@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc6
X-PR-Tracked-Commit-Id: d8eca64eec7103ab1fbabc0a187dbf6acfb2af93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a69c9e522950020d4973317201f4a419ee6d6a3
Message-Id: <157280130515.32367.149258093078714852.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Nov 2019 17:15:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Nov 2019 15:15:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a69c9e522950020d4973317201f4a419ee6d6a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
