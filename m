Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03280FE89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfD3RMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 13:12:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52035 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:12:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44tp3y58RLz9v1k9;
        Tue, 30 Apr 2019 19:12:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y+BPCfFl; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7IpCUdIa0TSw; Tue, 30 Apr 2019 19:12:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44tp3y3rYfz9v1k7;
        Tue, 30 Apr 2019 19:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556644334; bh=I6U/WMxuM/ZK7tYarUOuYY237DpcVURiegr1EP4PwhY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y+BPCfFlQth4Q3F4g09mhVDLltZ5p3Mj2+f6vObRBwtp83X+EBMQ7W/cEJ9lu+7PJ
         U7Lu6rlIhX1oP9BOJN7JC4H6TcF0fBF1sJ++alaqcd2Ea2lR9anAaYMuuATjNakepe
         ONOZwv+6heJPV/00barKCBVJyByRCJfQFYHYnV1Q=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EE138B8F1;
        Tue, 30 Apr 2019 19:12:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IvLfQpKYtXoV; Tue, 30 Apr 2019 19:12:16 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94E648B8DF;
        Tue, 30 Apr 2019 19:12:15 +0200 (CEST)
Subject: Re: [PATCH 2/5] soc/fsl/qe: qe.c: reduce static memory footprint by
 1.7K
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     Valentin Longchamp <valentin.longchamp@keymile.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        Rob Herring <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
 <20190430133615.25721-3-rasmus.villemoes@prevas.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <51b00425-58a7-089a-67a9-61cd315d5097@c-s.fr>
Date:   Tue, 30 Apr 2019 19:12:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430133615.25721-3-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/04/2019 à 15:36, Rasmus Villemoes a écrit :
> The current array of struct qe_snum use 256*4 bytes for just keeping
> track of the free/used state of each index, and the struct layout
> means there's another 768 bytes of padding. If we just unzip that
> structure, the array of snum values just use 256 bytes, while the
> free/inuse state can be tracked in a 32 byte bitmap.
> 
> So this reduces the .data footprint by 1760 bytes. It also serves as
> preparation for introducing another DT binding for specifying the snum
> values.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/soc/fsl/qe/qe.c | 37 ++++++++++++-------------------------
>   1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 855373deb746..d0393f83145c 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -14,6 +14,7 @@
>    * Free Software Foundation;  either version 2 of the  License, or (at your
>    * option) any later version.
>    */
> +#include <linux/bitmap.h>
>   #include <linux/errno.h>
>   #include <linux/sched.h>
>   #include <linux/kernel.h>
> @@ -43,25 +44,14 @@ static DEFINE_SPINLOCK(qe_lock);
>   DEFINE_SPINLOCK(cmxgcr_lock);
>   EXPORT_SYMBOL(cmxgcr_lock);
>   
> -/* QE snum state */
> -enum qe_snum_state {
> -	QE_SNUM_STATE_USED,
> -	QE_SNUM_STATE_FREE
> -};
> -
> -/* QE snum */
> -struct qe_snum {
> -	u8 num;
> -	enum qe_snum_state state;
> -};
> -
>   /* We allocate this here because it is used almost exclusively for
>    * the communication processor devices.
>    */
>   struct qe_immap __iomem *qe_immr;
>   EXPORT_SYMBOL(qe_immr);
>   
> -static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
> +static u8 snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
> +static DECLARE_BITMAP(snum_state, QE_NUM_OF_SNUM);
>   static unsigned int qe_num_of_snum;
>   
>   static phys_addr_t qebase = -1;
> @@ -308,6 +298,7 @@ static void qe_snums_init(void)
>   	};
>   	const u8 *snum_init;
>   
> +	bitmap_zero(snum_state, QE_NUM_OF_SNUM);

Doesn't make much importance, but wouldn't it be more logical to add 
this line where the setting of .state = QE_SNUM_STATE_FREE was done 
previously, ie around the for() loop below ?

>   	qe_num_of_snum = qe_get_num_of_snums();
>   
>   	if (qe_num_of_snum == 76)
> @@ -315,10 +306,8 @@ static void qe_snums_init(void)
>   	else
>   		snum_init = snum_init_46;
>   
> -	for (i = 0; i < qe_num_of_snum; i++) {
> -		snums[i].num = snum_init[i];
> -		snums[i].state = QE_SNUM_STATE_FREE;
> -	}
> +	for (i = 0; i < qe_num_of_snum; i++)
> +		snums[i] = snum_init[i];

Could use memcpy() instead ?

>   }
>   
>   int qe_get_snum(void)
> @@ -328,12 +317,10 @@ int qe_get_snum(void)
>   	int i;
>   
>   	spin_lock_irqsave(&qe_lock, flags);
> -	for (i = 0; i < qe_num_of_snum; i++) {
> -		if (snums[i].state == QE_SNUM_STATE_FREE) {
> -			snums[i].state = QE_SNUM_STATE_USED;
> -			snum = snums[i].num;
> -			break;
> -		}
> +	i = find_first_zero_bit(snum_state, qe_num_of_snum);
> +	if (i < qe_num_of_snum) {
> +		set_bit(i, snum_state);
> +		snum = snums[i];
>   	}
>   	spin_unlock_irqrestore(&qe_lock, flags);
>   
> @@ -346,8 +333,8 @@ void qe_put_snum(u8 snum)
>   	int i;
>   
>   	for (i = 0; i < qe_num_of_snum; i++) {
> -		if (snums[i].num == snum) {
> -			snums[i].state = QE_SNUM_STATE_FREE;
> +		if (snums[i] == snum) {
> +			clear_bit(i, snum_state);
>   			break;
>   		}
>   	}

Can we replace this loop by memchr() ?

Christophe

