Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B658D1913F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCXPNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 11:13:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgCXPNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1820EAB6D;
        Tue, 24 Mar 2020 15:13:49 +0000 (UTC)
Subject: Re: [PATCH 1/2] xen: expand BALLOON_MEMORY_HOTPLUG description
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20200324150015.50496-1-roger.pau@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <42a7b408-1ea1-04fa-e70b-cbdaba54c558@suse.com>
Date:   Tue, 24 Mar 2020 16:13:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324150015.50496-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.20 16:00, Roger Pau Monne wrote:
> To mention it's also useful for PVH or HVM domains that require
> mapping foreign memory or grants.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>   drivers/xen/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index 61212fc7f0c7..57ddd6f4b729 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -19,6 +19,10 @@ config XEN_BALLOON_MEMORY_HOTPLUG
>   	  It is very useful on critical systems which require long
>   	  run without rebooting.
>   
> +	  It's also very useful for translated domains (PVH or HVM) to obtain

I'd rather say "(non PV)" or "(PVH, HVM or Arm)".

> +	  unpopulated physical memory ranges to use in order to map foreign
> +	  memory or grants.
> +
>   	  Memory could be hotplugged in following steps:
>   
>   	    1) target domain: ensure that memory auto online policy is in
> 

With that:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
