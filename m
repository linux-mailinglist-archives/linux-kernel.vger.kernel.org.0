Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1777148C87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbgAXQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 11:52:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:46178 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbgAXQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:52:38 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1917F2D6;
        Fri, 24 Jan 2020 16:52:38 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:52:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Yue Hu <zbestahu@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] zram: correct documentation about sysfs node of huge
 page writeback
Message-ID: <20200124095236.530d2eb2@lwn.net>
In-Reply-To: <20200123015534.GE249784@google.com>
References: <20200120102949.12132-1-zbestahu@gmail.com>
        <20200123015534.GE249784@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020 17:55:34 -0800
Minchan Kim <minchan@kernel.org> wrote:

> On Mon, Jan 20, 2020 at 06:29:49PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > sysfs node for huge page writeback is writeback rather than write.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> Acked-by: Minchan Kim <minchan@kernel.org>

Applied, thanks.

jon
