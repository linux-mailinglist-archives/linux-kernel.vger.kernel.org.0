Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7E11A7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfLKJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:44:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55100 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfLKJo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:44:29 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyXd-0000Q3-9M; Wed, 11 Dec 2019 17:44:21 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyXa-0001wm-5k; Wed, 11 Dec 2019 17:44:18 +0800
Date:   Wed, 11 Dec 2019 17:44:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] padata lockdep, cpumask, and doc fixes
Message-ID: <20191211094418.wsh4khcnym2udflq@gondor.apana.org.au>
References: <20191203193114.238912-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203193114.238912-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 02:31:09PM -0500, Daniel Jordan wrote:
> This series depends on all of Herbert's recent padata fixes to reduce
> merge conflicts on his end:
> 
>   crypto: pcrypt - Do not clear MAY_SLEEP flag in original request
>   padata: Remove unused padata_remove_cpu
>   [v3] crypto: pcrypt - Avoid deadlock by using per-instance padata queues
>   crypto: pcrypt - Fix user-after-free on module unload
>   padata: Remove broken queue flushing 
> 
> If this should be based on something else, please let me know.
> 
> Thanks,
> Daniel
> 
> v2:
>  - documentation patch RST-ized according to Jon's comments
>  - "validate cpumask" patch added
>  - rebased onto v5.4 and updated since Herbert's fixes have changed
> 
> Daniel Jordan (5):
>   padata: validate cpumask without removed CPU during offline
>   padata: always acquire cpu_hotplug_lock before pinst->lock
>   padata: remove cpumask change notifier
>   padata: remove reorder_objects
>   padata: update documentation
> 
>  Documentation/core-api/index.rst  |   1 +
>  Documentation/core-api/padata.rst | 169 ++++++++++++++++++++++++++++++
>  Documentation/padata.txt          | 163 ----------------------------
>  crypto/pcrypt.c                   |   1 -
>  include/linux/cpuhotplug.h        |   1 +
>  include/linux/padata.h            |  28 ++---
>  kernel/padata.c                   | 124 ++++++++--------------
>  7 files changed, 220 insertions(+), 267 deletions(-)
>  create mode 100644 Documentation/core-api/padata.rst
>  delete mode 100644 Documentation/padata.txt

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
