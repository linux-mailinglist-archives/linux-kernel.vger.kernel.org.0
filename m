Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6F127B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLTMps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 07:45:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLTMps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:45:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1E298AF24;
        Fri, 20 Dec 2019 12:45:39 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] xen-blkback: support live update
To:     Paul Durrant <pdurrant@amazon.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20191211152956.5168-1-pdurrant@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <5f6cb6e6-0358-a38b-b61a-3793ebb89a1e@suse.com>
Date:   Fri, 20 Dec 2019 13:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211152956.5168-1-pdurrant@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.19 16:29, Paul Durrant wrote:
> Patch #1 is clean-up for an apparent mis-feature.
> 
> Paul Durrant (4):
>    xenbus: move xenbus_dev_shutdown() into frontend code...
>    xenbus: limit when state is forced to closed
>    xen/interface: re-define FRONT/BACK_RING_ATTACH()
>    xen-blkback: support dynamic unbind/bind
> 
>   drivers/block/xen-blkback/xenbus.c         | 56 +++++++++++++++-------
>   drivers/xen/xenbus/xenbus.h                |  2 -
>   drivers/xen/xenbus/xenbus_probe.c          | 35 ++++----------
>   drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
>   drivers/xen/xenbus/xenbus_probe_frontend.c | 24 +++++++++-
>   include/xen/interface/io/ring.h            | 29 ++++-------
>   include/xen/xenbus.h                       |  1 +
>   7 files changed, 81 insertions(+), 67 deletions(-)

Series pushed to xen/tip.git for-linus-5.5b


Juergen

