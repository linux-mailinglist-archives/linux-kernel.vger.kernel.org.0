Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4292510C56C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 09:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfK1Isw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 03:48:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:48160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfK1Isw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:48:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 619A9ACF1;
        Thu, 28 Nov 2019 08:48:50 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] xen/gntdev: sanitize user interface handling
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191107111546.26579-1-jgross@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <442417bc-ec65-0864-0a99-59583a52f866@suse.com>
Date:   Thu, 28 Nov 2019 09:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191107111546.26579-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.11.19 12:15, Juergen Gross wrote:
> The Xen gntdev driver's checking of the number of allowed mapped pages
> is in need of some sanitizing work.
> 
> Changes in V2:
> - enhanced commit message of patch 1 (Andrew Cooper)
> 
> Juergen Gross (2):
>    xen/gntdev: replace global limit of mapped pages by limit per call
>    xen/gntdev: switch from kcalloc() to kvcalloc()
> 
>   drivers/xen/gntdev-common.h |  2 +-
>   drivers/xen/gntdev-dmabuf.c | 11 +++------
>   drivers/xen/gntdev.c        | 55 +++++++++++++++++++--------------------------
>   3 files changed, 27 insertions(+), 41 deletions(-)
> 

Boris, could you please comment on the patches?


Juergen
