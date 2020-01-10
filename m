Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDA1375C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgAJSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 13:04:39 -0500
Received: from ms.lwn.net ([45.79.88.28]:52248 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgAJSEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:04:39 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7F5EF77D;
        Fri, 10 Jan 2020 18:04:38 +0000 (UTC)
Date:   Fri, 10 Jan 2020 11:04:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Documentation: filesystems: convert vfat.txt to RST
Message-ID: <20200110110437.1a028da8@lwn.net>
In-Reply-To: <20191223010030.434902-1-dwlsalmeida@gmail.com>
References: <20191223010030.434902-1-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2019 22:00:30 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> Converts vfat.txt to the reStructuredText format, improving presentation
> without changing the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> -----------------------------------------------------------
> Changes in v3:
> Removed unnecessary markup.
> Removed section "BUG REPORTS" as recommended by the maintainer.
> 
> Changes in v2:
> Refactored long lines as pointed out by Jonathan
> Copied the maintainer
> Updated the reference in the MAINTAINERS file for vfat
> 
> I did not move this into admin-guide, waiting on what the
> maintainer has to say about this and also about old sections
> in the text, if any.

Things seem to have calmed down here for now, so I've gone ahead and
applied this.  We can always move it in the future if that seems to make
sense.

Thanks,

jon
