Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043D3156438
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 13:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBHMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 07:34:54 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57844 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 07:34:54 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 018CX4NR077663;
        Sat, 8 Feb 2020 21:33:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Sat, 08 Feb 2020 21:33:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 018CWvOG077502
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Feb 2020 21:33:04 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
To:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     tysand@google.com, mst@redhat.com, david@redhat.com,
        alexander.h.duyck@linux.intel.com, rientjes@google.com,
        mhocko@kernel.org, namit@vmware.com
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
Date:   Sat, 8 Feb 2020 21:32:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/06 17:01, Wei Wang wrote:
> There are cases that users want to shrink balloon pages after the
> pagecache depleted. The conservative_shrinker lets the shrinker
> shrink balloon pages when all the pagecache has been reclaimed.
> 
> @@ -796,6 +800,10 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>  {
>  	unsigned long pages_freed = 0;
>  
> +	/* Balloon pages only gets shrunk when the pagecache depleted */
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> +		return 0;
> +

Is this NUMA aware? Can "node-A's NR_FILE_PAGES is already 0 and node-B's
NR_FILE_PAGES is not 0, but allocation request which triggered this shrinker
wants to allocate from only node-B" happen? Can some thread keep this shrinker
defunctional by keep increasing NR_FILE_PAGES?

Is this patch from "Re: Balloon pressuring page cache" thread? I hope that
the guest could start reclaiming memory based on host's request (like OOM
notifier chain) which is issued when host thinks that host is getting close
to OOM and thus guests should start returning their unused memory to host.
Maybe "periodically (e.g. 5 minutes)" in addition to "upon close to OOM
condition" is also possible.
