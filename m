Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D25A80AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfIDKuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 06:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfIDKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B5822CED;
        Wed,  4 Sep 2019 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567594218;
        bh=0tkc2jStShXinGVSzG1SMj1S3e4mv0ZyVqBpJ3BnKSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufhHy86DcEa4OgYPh1cNAq0rNmKo6v9+YtXdTsJ8TYeX643w5eIuYWco04QP9c0QX
         3uHKFSjHM9hATDVq0EzRC6ow0ulmU3Q7goAKmM6ffz3OU4P1tBtQCUDFIYULz8qJ4I
         bawUaSeb/3lNLyxendaa7YlFDdSsE/by9sSuKODo=
Date:   Wed, 4 Sep 2019 12:50:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
Message-ID: <20190904105015.GA21698@kroah.com>
References: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190826132916.GB12281@kroah.com>
 <87bb0adb-1d36-6481-6845-a93e5a3e5d17@i-love.sakura.ne.jp>
 <5ea28431-c677-0552-41aa-1c67779e2248@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea28431-c677-0552-41aa-1c67779e2248@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 07:19:47PM +0900, Tetsuo Handa wrote:
> Ping? Syzbot is still reporting this problem.

It's in my queue, give me a chance :)

greg k-h
