Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB6E5601
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfJYVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfJYVgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:36:24 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79B822084C;
        Fri, 25 Oct 2019 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039383;
        bh=E4lkMbIFGs07dUtv9M8GhB45SbnpOSz4PqDKVYnEmSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WkYKSdhn0xFzEDFlOydOOV1zjOfxSkShdjsy68pkL+Cy8u8ahbyhN43S5fq9LVYy3
         feJFnbkgxiKPfiIWKTyKnixaTs9DUh9qtfn2ZOTmu6xfTHuQbiYU6a1txZc6Pv3q9n
         68z6KuoS68mBmUx4XXPvoIuKE/hZxD+h2zvWGehI=
Date:   Fri, 25 Oct 2019 14:36:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+742a9c5d4ab05d343c49@syzkaller.appspotmail.com>
Cc:     hughd@google.com, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: WARNING in collapse_file
Message-Id: <20191025143623.3e9b0a916635a45865a11ed3@linux-foundation.org>
In-Reply-To: <00000000000066214a0595b7ea86@google.com>
References: <00000000000066214a0595b7ea86@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 01:27:07 -0700 syzbot <syzbot+742a9c5d4ab05d343c49@syzkaller.appspotmail.com> wrote:

> syzbot found the following crash on:
> 
> HEAD commit:    a6fcdcd9 Add linux-next specific files for 20191021
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11145ed8e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=32434321999f01e9
> dashboard link: https://syzkaller.appspot.com/bug?extid=742a9c5d4ab05d343c49
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+742a9c5d4ab05d343c49@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1080 at mm/khugepaged.c:1643  

Yup, thanks, this was addressed in v4:

https://ozlabs.org/~akpm/mmotm/broken-out/mmthp-recheck-each-page-before-collapsing-file-thp-v4.patch
