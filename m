Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9966112F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEBGDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 02:03:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbfEBGDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:03:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46E1EAEF4;
        Thu,  2 May 2019 06:03:02 +0000 (UTC)
Subject: Re: [PATCH 12/24] libfc: switch to SPDX tags
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-13-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3ae164d9-f1b0-c1b9-e867-f592b0fef4c2@suse.de>
Date:   Thu, 2 May 2019 08:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-13-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 6:14 PM, Christoph Hellwig wrote:
> Use the the GPLv2 SPDX tag instead of verbose boilerplate text.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/libfc/fc_disc.c  | 14 +-------------
>   drivers/scsi/libfc/fc_elsct.c | 14 +-------------
>   drivers/scsi/libfc/fc_exch.c  | 14 +-------------
>   drivers/scsi/libfc/fc_fcp.c   | 14 +-------------
>   drivers/scsi/libfc/fc_frame.c | 14 +-------------
>   drivers/scsi/libfc/fc_libfc.c | 14 +-------------
>   drivers/scsi/libfc/fc_libfc.h | 14 +-------------
>   drivers/scsi/libfc/fc_lport.c | 14 +-------------
>   drivers/scsi/libfc/fc_npiv.c  | 14 +-------------
>   drivers/scsi/libfc/fc_rport.c | 14 +-------------
>   include/scsi/fc/fc_encaps.h   | 14 +-------------
>   include/scsi/fc/fc_fc2.h      | 14 +-------------
>   include/scsi/fc/fc_fcoe.h     | 14 +-------------
>   include/scsi/fc/fc_fcp.h      | 14 +-------------
>   include/scsi/fc/fc_fip.h      | 14 +-------------
>   include/scsi/fc/fc_ms.h       | 17 +++--------------
>   include/scsi/libfc.h          | 14 +-------------
>   17 files changed, 19 insertions(+), 222 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
