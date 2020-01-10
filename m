Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE613753C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgAJRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:50:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:52164 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgAJRuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:50:46 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 129C72C0;
        Fri, 10 Jan 2020 17:50:46 +0000 (UTC)
Date:   Fri, 10 Jan 2020 10:50:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3 1/8] Documentation: nfsroot.txt: convert to ReST
Message-ID: <20200110105044.0877ad21@lwn.net>
In-Reply-To: <91ab26d120888f4f0a5fb535a42bf47ae5729238.1577917076.git.dwlsalmeida@gmail.com>
References: <cover.1577917076.git.dwlsalmeida@gmail.com>
        <91ab26d120888f4f0a5fb535a42bf47ae5729238.1577917076.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jan 2020 19:26:08 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Convert nfsroot.txt to RST and move it to admin-guide. Content remains
> mostly the same.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

*sigh*

So, I was ready to apply this whole set, finally, but couldn't do it.  To
see why...

>  Documentation/admin-guide/nfs/index.rst       |   1 +
>  .../nfs/nfsroot.rst}                          | 140 +++++++++---------
>  2 files changed, 75 insertions(+), 66 deletions(-)
>  rename Documentation/{filesystems/nfs/nfsroot.txt => admin-guide/nfs/nfsroot.rst} (83%)
> 
> diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
> index f5c0180f4e5e..c2b87e9f0fed 100644
> --- a/Documentation/admin-guide/nfs/index.rst
> +++ b/Documentation/admin-guide/nfs/index.rst
> @@ -6,4 +6,5 @@ NFS
>      :maxdepth: 1
>  
>      nfs-client
> +    nfsroot

Documentation/admin-guide/nfs doesn't exist in any tree I can see, and
neither does the nfs-client file referenced here.  Which tree was this
generated against?

Can you make me a version that applies to docs-next, and we'll get it into
5.6?

Thanks,

jon
