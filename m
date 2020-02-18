Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA53A162A35
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBRQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 11:16:52 -0500
Received: from gentwo.org ([3.19.106.255]:41626 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgBRQQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:16:52 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 277453E998; Tue, 18 Feb 2020 16:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 2664D3E997;
        Tue, 18 Feb 2020 16:16:51 +0000 (UTC)
Date:   Tue, 18 Feb 2020 16:16:51 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] slabinfo: parse all NUMA attributes
In-Reply-To: <20200217084828.9092-1-tobin@kernel.org>
Message-ID: <alpine.DEB.2.21.2002181615550.20682@www.lameter.com>
References: <20200217084828.9092-1-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020, Tobin C. Harding wrote:

> I found a few files in /sys/kernel/slab/foo/ that contain NUMA info that
> is not currently being parsed by `slabinfo.c`.  I do not know whether
> this is intentional or not?  Since I did not know this I just printed
> the info in the NUMA report section like is done for the per node slabs
> and partial slabs info.
>
> Just for your interest; I found these while re-writing slabinfo in Rust,
> thanks to the type-system.  I guess that if they were unintentionally
> missed then this is a small win, if they were intentionally missed then
> this series is just noise :)

It was just to make the display simpler and I did not get around to the
full implementation (by adding some sort of NUMA option) since other
things kept coming up.
