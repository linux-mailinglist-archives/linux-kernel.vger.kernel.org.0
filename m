Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B923F3907
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKGT4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 14:56:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:39350 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfKGTz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:55:59 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EA5F62C1;
        Thu,  7 Nov 2019 19:55:58 +0000 (UTC)
Date:   Thu, 7 Nov 2019 12:55:57 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
Message-ID: <20191107125557.0522eb49@lwn.net>
In-Reply-To: <20191031135245.7984-1-changbin.du@gmail.com>
References: <20191031135245.7984-1-changbin.du@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 21:52:45 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The 'functions' directive is not only for functions, but also works for
> structs/unions. So the name is misleading. This patch renames it to
> 'identifiers', which specific the functions/types to be included in
> documentation. We keep the old name as an alias of the new one before
> all documentation are updated.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2:
>   o use 'identifiers' as the new directive name.

It would have been nice to update that last text for v3 ... but the patch
looks better, so I've gone ahead and applied it, thanks.

jon
