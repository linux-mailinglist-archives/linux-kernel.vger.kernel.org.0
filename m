Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF06417D5D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Mar 2020 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCHTVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Mar 2020 15:21:10 -0400
Received: from gentwo.org ([3.19.106.255]:43428 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCHTVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:21:10 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 5D6383F1C0; Sun,  8 Mar 2020 19:21:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5A5433E998;
        Sun,  8 Mar 2020 19:21:09 +0000 (UTC)
Date:   Sun, 8 Mar 2020 19:21:09 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Kees Cook <keescook@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Vitaly Nikolenko <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Relocate freelist pointer to middle of object
In-Reply-To: <202003051624.AAAC9AECC@keescook>
Message-ID: <alpine.DEB.2.21.2003081919290.14266@www.lameter.com>
References: <202003051624.AAAC9AECC@keescook>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020, Kees Cook wrote:

> Instead of having the freelist pointer at the very beginning of an
> allocation (offset 0) or at the very end of an allocation (effectively
> offset -sizeof(void *) from the next allocation), move it away from
> the edges of the allocation and into the middle. This provides some
> protection against small-sized neighboring overflows (or underflows),
> for which the freelist pointer is commonly the target. (Large or well
> controlled overwrites are much more likely to attack live object contents,
> instead of attempting freelist corruption.)

Sounds good. You could even randomize the position to avoid attacks on via
the freelist pointer.

Acked-by: Christoph Lameter <cl@linux.com>
