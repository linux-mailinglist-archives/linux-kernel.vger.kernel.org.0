Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02217535
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfEHJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 05:35:59 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:35161 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEHJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:35:59 -0400
Received: from [192.168.1.41] ([92.148.209.44])
        by mwinf5d59 with ME
        id 9lbw200030y1A8U03lbwXh; Wed, 08 May 2019 11:35:57 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 May 2019 11:35:57 +0200
X-ME-IP: 92.148.209.44
Subject: Re: [PATCH] scsi: bnx2fc: fix incorrect cast to u64 on shift
 operation
To:     Colin King <colin.king@canonical.com>,
        QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190504164829.26631-1-colin.king@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <718d3ec2-c3e6-bdfa-bbd2-7988f7783bde@wanadoo.fr>
Date:   Wed, 8 May 2019 11:35:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504164829.26631-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/05/2019 à 18:48, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently an int is being shifted and the result is being cast to a u64
> which leads to undefined behaviour if the shift is more than 31 bits. Fix
> this by casting the integer value 1 to u64 before the shift operation.
>
> Addresses-Coverity: ("Bad shift operation")
> Fixes: 7b594769120b ("[SCSI] bnx2fc: Handle REC_TOV error code from firmware")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/scsi/bnx2fc/bnx2fc_hwi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> index 19734ec7f42e..747f019fb393 100644
> --- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> +++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
> @@ -830,7 +830,7 @@ static void bnx2fc_process_unsol_compl(struct bnx2fc_rport *tgt, u16 wqe)
>   			((u64)err_entry->data.err_warn_bitmap_hi << 32) |
>   			(u64)err_entry->data.err_warn_bitmap_lo;
>   		for (i = 0; i < BNX2FC_NUM_ERR_BITS; i++) {
> -			if (err_warn_bit_map & (u64) (1 << i)) {
> +			if (err_warn_bit_map & ((u64)1 << i)) {
>   				err_warn = i;
>   				break;
>   			}


Hi, just for the records and if you need additional ack, see

    https://lkml.org/lkml/2016/11/26/172

just my 2c :-)

CJ

