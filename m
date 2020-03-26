Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F43D19413D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgCZO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgCZO0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:26:00 -0400
Received: from kernel.org (unknown [87.70.82.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4E120737;
        Thu, 26 Mar 2020 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585232760;
        bh=KMkEwoFLR0gA4f1WF6jeYdZ+fFFbpN1NEKW94s38IeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeDhPEvk0eFtq+gXdH4d4sq590TuOJzGFmBo5wIFU2+S8saJft+6H3HS2PZfZ+LMy
         KIDo8zl84Krh+qBUA28KeUM44MpeT3UVlTrZ/GPLbMsYbiLCsX2RAZFljWB/W53zTf
         FOLroABLtXiEiVaY5pcrEdWDFWrLDZBqOcpQ970w=
Date:   Thu, 26 Mar 2020 16:25:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] mm: Remove dummy struct bootmem_data/bootmem_data_t
Message-ID: <20200326142549.GA3544@kernel.org>
References: <20200326022617.26208-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326022617.26208-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:26:17PM -0400, Waiman Long wrote:
> Both bootmem_data and bootmem_data_t structures are no longer defined.
> Remove the dummy forward declarations.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/alpha/include/asm/mmzone.h | 2 --
>  include/linux/mmzone.h          | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
> index 7ee144f484f1..9b521c857436 100644
> --- a/arch/alpha/include/asm/mmzone.h
> +++ b/arch/alpha/include/asm/mmzone.h
> @@ -8,8 +8,6 @@
>  
>  #include <asm/smp.h>
>  
> -struct bootmem_data_t; /* stupid forward decl. */
> -
>  /*
>   * Following are macros that are specific to this numa platform.
>   */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..5c388eced889 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -706,7 +706,6 @@ struct deferred_split {
>   * Memory statistics and page replacement data structures are maintained on a
>   * per-zone basis.
>   */
> -struct bootmem_data;
>  typedef struct pglist_data {
>  	struct zone node_zones[MAX_NR_ZONES];
>  	struct zonelist node_zonelists[MAX_ZONELISTS];
> -- 
> 2.18.1
> 
> 

-- 
Sincerely yours,
Mike.
