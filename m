Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020A9638F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfGIP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 11:58:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:58992 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfGIP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:58:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D47A0737;
        Tue,  9 Jul 2019 15:58:08 +0000 (UTC)
Date:   Tue, 9 Jul 2019 09:58:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     NitinGote <nitin.r.gote@intel.com>
Cc:     joe@perches.com, akpm@linux-foundation.org, apw@canonical.com,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Added warnings in checkpatch.pl script to :
Message-ID: <20190709095807.72adb380@lwn.net>
In-Reply-To: <20190709154806.26363-1-nitin.r.gote@intel.com>
References: <20190709154806.26363-1-nitin.r.gote@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Jul 2019 21:18:06 +0530
NitinGote <nitin.r.gote@intel.com> wrote:

> From: Nitin Gote <nitin.r.gote@intel.com>
> 
> 1. Deprecate strcpy() in favor of strscpy().
> 2. Deprecate strlcpy() in favor of strscpy().
> 3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().
> 
> Updated strncpy() section in Documentation/process/deprecated.rst
> to cover strscpy_pad() case.
> 
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
>  Change log:
>  v1->v2
>  - For string related apis, created different %deprecated_string_api
>    and these will get emitted at CHECK Level using command line option
>    -f/--file to avoid bad patched from novice script users.
> 
>  v2->v3
>  - Avoided use of $check in implementation.
>  - Incorporated trivial comments.
> 
>  v3->v4
>  - Incorporated comment by removing "c:func:"

But you ignored the comment asking for a proper subject line on the
patch.  

Also,

> -only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
> -(Users of :c:func:`strscpy` still needing NUL-padding will need an
> -explicit :c:func:`memset` added.)
> +only NUL-terminated strings. In this case, the safe replacement is
> +`strscpy()`. If, however, the destination buffer still needs NUL-padding,
> +the safe replacement is `strscpy_pad()`.

Please make those just strscpy(), not `strscpy()`.  As I said, the right
thing will happen.

Thanks,

jon
