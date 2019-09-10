Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438D3AE201
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 03:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbfIJBld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 21:41:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59009 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfIJBld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:41:33 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8A1fV71048310;
        Tue, 10 Sep 2019 10:41:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Tue, 10 Sep 2019 10:41:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8A1fVW7048306;
        Tue, 10 Sep 2019 10:41:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x8A1fVdu048305;
        Tue, 10 Sep 2019 10:41:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201909100141.x8A1fVdu048305@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] mm: avoid slub allocation while holding
 =?ISO-2022-JP?B?bGlzdF9sb2Nr?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Yu Zhao <yuzhao@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Tue, 10 Sep 2019 10:41:31 +0900
References: <e5e25aa3-651d-92b4-ac82-c5011c66a7cb@I-love.SAKURA.ne.jp> <20190909213938.GA53078@google.com>
In-Reply-To: <20190909213938.GA53078@google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao wrote:
> I think we can safely assume PAGE_SIZE is unsigned long aligned and
> page->objects is non-zero. But if you don't feel comfortable with these
> assumptions, I'd be happy to ensure them explicitly.

I know PAGE_SIZE is unsigned long aligned. If someone by chance happens to
change from "dynamic allocation" to "on stack", get_order() will no longer
be called and the bug will show up.

I don't know whether __get_free_page(GFP_ATOMIC) can temporarily consume more
than 4096 bytes, but if it can, we might want to avoid "dynamic allocation".

By the way, if "struct kmem_cache_node" is object which won't have many thousands
of instances, can't we embed that buffer into "struct kmem_cache_node" because
max size of that buffer is only 4096 bytes?
