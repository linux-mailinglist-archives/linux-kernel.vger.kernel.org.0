Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AD62A47
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2019 22:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404941AbfGHUU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jul 2019 16:20:58 -0400
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:49292 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbfGHUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1562617256;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=uPawzHgSXshI+XHGB6J1ayR3ywnOsHKWmwACBnodim8=;
        b=WRtxMatR0hA6JDxkxO6CtPf3jkw04T7iVP47f2NnMk6BacWo9MWaSSgNkpSTzctv
        xL1SF+FcGnVBjsVlk2UU338vlietdiGTqB80aJ5ZHWvAtnh+Jn1yy4qxA5QRgOF2pwR
        lSfY4BemfcRxdfFqfDodWcXNAfNoyreGxEYGK8Bw=
Date:   Mon, 8 Jul 2019 20:20:56 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Marco Elver <elver@google.com>
cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v5 4/5] mm/slab: Refactor common ksize KASAN logic into
 slab_common.c
In-Reply-To: <20190708170706.174189-5-elver@google.com>
Message-ID: <0100016bd33f19f3-46ea67c2-d930-4e22-9934-41d6b25d5bd5-000000@email.amazonses.com>
References: <20190708170706.174189-1-elver@google.com> <20190708170706.174189-5-elver@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.08-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Marco Elver wrote:

> This refactors common code of ksize() between the various allocators
> into slab_common.c: __ksize() is the allocator-specific implementation
> without instrumentation, whereas ksize() includes the required KASAN
> logic.

Acked-by: Christoph Lameter <cl@linux.com>

