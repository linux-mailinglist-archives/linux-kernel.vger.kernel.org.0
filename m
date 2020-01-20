Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A9143130
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgATR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 12:58:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:48640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgATR6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:58:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B209AD5B;
        Mon, 20 Jan 2020 17:58:37 +0000 (UTC)
Date:   Mon, 20 Jan 2020 09:51:44 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] lib/rbtree: avoid pointless rb_node alignment
Message-ID: <20200120175144.67625skg6eiprpsa@linux-p48b>
References: <20200110215429.30360-1-dave@stgolabs.net>
 <CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Geert Uytterhoeven wrote:

>timerqueue_del() uses rbtree, and
>
>    #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
>
>relies on all objects being 4-byte aligned.  But your patch broke that
>assumption on m68k, where the default alignment is 2-byte.
>
>Andrew: please drop this patch.

Yeah that's too bad. I'll send a patch improving the comment around the alignment
once the patch is dropped.

Thanks,
Davidlohr
