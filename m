Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAC12D3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 19:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfL3S5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 13:57:10 -0500
Received: from ms.lwn.net ([45.79.88.28]:60434 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfL3S5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:57:07 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 05DB2536;
        Mon, 30 Dec 2019 18:57:05 +0000 (UTC)
Date:   Mon, 30 Dec 2019 11:57:05 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH] Doc: x86: Fix a typo in mm.rst
Message-ID: <20191230115705.2a490e96@lwn.net>
In-Reply-To: <20191226162138.17601-1-standby24x7@gmail.com>
References: <20191226162138.17601-1-standby24x7@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 01:21:38 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fix a spelling typo in mm.rst.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/x86/x86_64/mm.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
> index 267fc4808945..e5053404a1ae 100644
> --- a/Documentation/x86/x86_64/mm.rst
> +++ b/Documentation/x86/x86_64/mm.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> -================
> -Memory Managment
> -================
> +=================
> +Memory Management
> +=================

Applied, thanks.

jon
