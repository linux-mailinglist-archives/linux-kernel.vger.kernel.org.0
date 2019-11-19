Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93624101441
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 06:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfKSFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 00:32:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:42535 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfKSFb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 21:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="204411168"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2019 21:31:56 -0800
Message-ID: <5DD37FE4.4000407@intel.com>
Date:   Tue, 19 Nov 2019 13:38:44 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>
CC:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_balloon: fix pages_to_free calculation
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com> <20191118213811.22017-1-khazhy@google.com> <20191118175648-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191118175648-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2019 07:08 AM, Michael S. Tsirkin wrote:
> So I really think we should do something like the below instead.
> Limit playing with balloon pages so we can gradually limit it to legacy.
> Testing, review would be appreciated.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 226fbb995fb0..7cee05cdf3fb 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
>   	return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
>   }
>   
> +static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> +                                          unsigned long pages_to_free)
> +{
> +	return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) /
> +		VIRTIO_BALLOON_PAGES_PER_PAGE;
> +}
> +

Looks good to me, too. (just a reminder that the returning type of 
leak_balloon is "unsigned int",
we may want them to be consistent).

Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Best,
Wei

