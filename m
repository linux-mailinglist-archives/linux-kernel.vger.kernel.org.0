Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A3E107638
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfKVRIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 12:08:46 -0500
Received: from ms.lwn.net ([45.79.88.28]:41366 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:08:45 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4410B6D9;
        Fri, 22 Nov 2019 17:08:45 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:08:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete obsolete magic constants from documentation
Message-ID: <20191122100844.2e9b22c6@lwn.net>
In-Reply-To: <20191121191536.186051-1-pterjan@google.com>
References: <20191121191536.186051-1-pterjan@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 19:15:36 +0000
Pascal Terjan <pterjan@google.com> wrote:

> Those no longer appear in the code.
> I have some more patches to cleanup some of them from the code but this
> is an easy first step.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  Documentation/process/magic-number.rst        | 44 -------------------
>  .../it_IT/process/magic-number.rst            | 44 -------------------
>  .../zh_CN/process/magic-number.rst            | 44 -------------------
>  3 files changed, 132 deletions(-)

So I absolutely love this patch; we really need to clean this kind of
cruft out of the docs.

Unfortunately, it doesn't apply to docs-next; did you prepare it against
linux-next, perhaps?  Is there any chance I could get a version against
docs-next?

If you're up for further work on this file, it would be nice to get rid of
the 2.x "changelog" text at the beginning; I don't think that has any real
value now.

Thanks,

jon
