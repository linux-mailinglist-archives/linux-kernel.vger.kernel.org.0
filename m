Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4817F5A185
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfF1Q4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 12:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfF1Q4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B15A8AB92;
        Fri, 28 Jun 2019 16:56:48 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:56:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rbtree: avoid generating code twice for the cached
 versions
Message-ID: <20190628165642.r754xozttawmg5yh@linux-r8p5>
References: <20190628045008.39926-1-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190628045008.39926-1-walken@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019, Michel Lespinasse wrote:

>As was already noted in rbtree.h, the logic to cache rb_first (or rb_last)
>can easily be implemented externally to the core rbtree api.
>
>Change the implementation to do just that. Previously the update of
>rb_leftmost was wired deeper into the implemntation, but there were
>some disadvantages to that - mostly, lib/rbtree.c had separate
>instantiations for rb_insert_color() vs rb_insert_color_cached(), as well
>as rb_erase() vs rb_erase_cached(), which were doing exactly the same
>thing save for the rb_leftmost update at the start of either function.

I think this makes sense, and is more along the lines of the augmented
cached doing the static inline instead of separate instantiations of the
calls.

>Change-Id: I0cb62be774fc0138b81188e6ae81d5f1da64578d
what is this?

>Signed-off-by: Michel Lespinasse <walken@google.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>

Thanks!
