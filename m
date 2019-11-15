Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A5FDB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKOK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 05:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfKOK2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:28:39 -0500
Received: from linux-8ccs (x2f7fc5a.dyn.telefonica.de [2.247.252.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A522077B;
        Fri, 15 Nov 2019 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573813719;
        bh=p09PBLNMgnAEXY+60gOXHO/rGEsig0DEVJFu6o6RFtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0JWgTV/nsJzEluka3dQIVylZcH9wTidr41I6f4sbkfXKcDQAdWXETgcIBErT35xT
         X0ylLxwM4V10Leln4RGo6+ytLreMZ4i4HgpMyKbsOWyd7eA/bn6UsNTsVvr0hl+hau
         5EzQDo99gPtN1CWNgMro3OFRi4CqM0we9VXV1TrU=
Date:   Fri, 15 Nov 2019 11:28:33 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Barret Rhoden <brho@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/1] kernel/module.c: wakeup processes in module_wq on
 module unload
Message-ID: <20191115102832.GA1647@linux-8ccs>
References: <20191113092950.15556-1-khorenko@virtuozzo.com>
 <20191113092950.15556-2-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191113092950.15556-2-khorenko@virtuozzo.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Konstantin Khorenko [13/11/19 12:29 +0300]:
>Fix the race between load and unload a kernel module.
>
>sys_delete_module()
> try_stop_module()
>  mod->state = _GOING
>					add_unformed_module()
>					 old = find_module_all()
>					 (old->state == _GOING =>
>					  wait_event_interruptible())
>
>					 During pre-condition
>					 finished_loading() rets 0
>					 schedule()
>					 (never gets waken up later)
> free_module()
>  mod->state = _UNFORMED
>   list_del_rcu(&mod->list)
>   (dels mod from "modules" list)
>
>return
>
>The race above leads to modprobe hanging forever on loading
>a module.
>
>Error paths on loading module call wake_up_all(&module_wq) after
>freeing module, so let's do the same on straight module unload.
>
>Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
>for modules that have finished loading")
>
>Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Thanks Konstantin for catching this. I've applied this to
modules-next.

Jessica

