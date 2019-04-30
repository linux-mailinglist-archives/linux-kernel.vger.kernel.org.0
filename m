Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68EF897
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfD3MQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 08:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfD3MQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:16:16 -0400
Received: from linux-8ccs (p5B164EF0.dip0.t-ipconnect.de [91.22.78.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05575205ED;
        Tue, 30 Apr 2019 12:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556626576;
        bh=H4/4dT9BDXgmTLrM3JhAKhMqwOU404G2VfdlNa7qgMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqWiNKJ7KoJAip0wlu4QLyfLHyp7plR4731w4+lsTQnR4TTWkDySwGLqU9Xt37xkU
         ZlaBOi61KqfcBVBxvO19pFa8zNBqnDWaVOOcErmKr252MgY4rHMNpfFA9pKGNx7aoM
         AV130XZMq8j8J1ZMC64B7iz5o3nTWZqS+FGOXTk8=
Date:   Tue, 30 Apr 2019 14:16:11 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: Reschedule while waiting for modules to
 finish loading
Message-ID: <20190430121611.GA29488@linux-8ccs>
References: <20190429151751.15424-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190429151751.15424-1-prarit@redhat.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Prarit Bhargava [29/04/19 11:17 -0400]:
>Heiko, do you want a Signed-off-by or a Reported-by?  Either one works
>for me.
>
>P.
>
>----8<----
>
>On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>loading the s390_trng.ko module.
>
>Add a reschedule point to the loop that waits for modules to complete
>loading.
>
>Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
>Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Jessica Yu <jeyu@kernel.org>

Thanks for the fix! Applied to modules-next.

Jessica

