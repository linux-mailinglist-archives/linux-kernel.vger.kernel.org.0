Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10761F30A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfKGNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:54:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfKGNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573134884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+GpHBRriMbogZ8e0AcN1f5YzGvR15HQmscsOF5sEEs=;
        b=hrH1FtfBGQY4kLzy0TUThiaWhQYJ309mZOd1QfcdD0BkViRa+q7anb+Po3G1Rvqtso6cij
        Jm5JrImd7UNnWV4cOc4RiTXu83GrrzQ6RPZcQmLn6zVVkzkUnHjWbNkF4vuhL5RKfpMe7X
        aDm3wrx/2CuzKrFInBjHb+Yv7JaaQNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-csnduqu1M-CvpMRPYB7mTA-1; Thu, 07 Nov 2019 08:54:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BFB7800C72;
        Thu,  7 Nov 2019 13:54:39 +0000 (UTC)
Received: from ovpn-124-234.rdu2.redhat.com (ovpn-124-234.rdu2.redhat.com [10.10.124.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4061D5DA32;
        Thu,  7 Nov 2019 13:54:38 +0000 (UTC)
Message-ID: <7467951caf48f00f7b3f6cffb588579d462c996b.camel@redhat.com>
Subject: Re: [PATCH 2/9] c6x: Include <linux/unaligned/generic.h> instead of
 duplicating it
From:   Mark Salter <msalter@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Date:   Thu, 07 Nov 2019 08:54:37 -0500
In-Reply-To: <20191028200700.213753-3-bvanassche@acm.org>
References: <20191028200700.213753-1-bvanassche@acm.org>
         <20191028200700.213753-3-bvanassche@acm.org>
Organization: Red Hat, Inc
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: csnduqu1M-CvpMRPYB7mTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 13:06 -0700, Bart Van Assche wrote:
> Use the generic __{get,put}_unaligned_[bl]e() definitions instead of
> duplicating these. Since a later patch will add more definitions into
> <linux/unaligned/generic.h>, this patch ensures that these definitions
> have to be added only once. See also commit a7f626c1948a ("C6X: headers")=
.
> See also commit 6510d41954dc ("kernel: Move arches to use common unaligne=
d
> access").
>=20
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  arch/c6x/include/asm/unaligned.h | 65 +-------------------------------
>  1 file changed, 1 insertion(+), 64 deletions(-)
>=20
> diff --git a/arch/c6x/include/asm/unaligned.h b/arch/c6x/include/asm/unal=
igned.h
> index b56ba7110f5a..d628cc170564 100644
> --- a/arch/c6x/include/asm/unaligned.h
> +++ b/arch/c6x/include/asm/unaligned.h
> @@ -10,6 +10,7 @@
>  #define _ASM_C6X_UNALIGNED_H
> =20
>  #include <linux/swab.h>
> +#include <linux/unaligned/generic.h>
> =20
>  /*
>   * The C64x+ can do unaligned word and dword accesses in hardware
> @@ -100,68 +101,4 @@ static inline void put_unaligned64(u64 val, const vo=
id *p)
> =20
>  #endif
> =20
> -/*
> - * Cause a link-time error if we try an unaligned access other than
> - * 1,2,4 or 8 bytes long
> - */
> -extern int __bad_unaligned_access_size(void);
> -
> -#define __get_unaligned_le(ptr) (typeof(*(ptr)))({=09=09=09\
> -=09sizeof(*(ptr)) =3D=3D 1 ? *(ptr) :=09=09=09=09=09\
> -=09  (sizeof(*(ptr)) =3D=3D 2 ? get_unaligned_le16((ptr)) :=09=09\
> -=09     (sizeof(*(ptr)) =3D=3D 4 ? get_unaligned_le32((ptr)) :=09=09\
> -=09=09(sizeof(*(ptr)) =3D=3D 8 ? get_unaligned_le64((ptr)) :=09\
> -=09=09   __bad_unaligned_access_size())));=09=09=09\
> -=09})
> -
> -#define __get_unaligned_be(ptr) (__force typeof(*(ptr)))({=09\
> -=09sizeof(*(ptr)) =3D=3D 1 ? *(ptr) :=09=09=09=09=09\
> -=09  (sizeof(*(ptr)) =3D=3D 2 ? get_unaligned_be16((ptr)) :=09=09\
> -=09     (sizeof(*(ptr)) =3D=3D 4 ? get_unaligned_be32((ptr)) :=09=09\
> -=09=09(sizeof(*(ptr)) =3D=3D 8 ? get_unaligned_be64((ptr)) :=09\
> -=09=09   __bad_unaligned_access_size())));=09=09=09\
> -=09})
> -
> -#define __put_unaligned_le(val, ptr) ({=09=09=09=09=09\
> -=09void *__gu_p =3D (ptr);=09=09=09=09=09=09\
> -=09switch (sizeof(*(ptr))) {=09=09=09=09=09\
> -=09case 1:=09=09=09=09=09=09=09=09\
> -=09=09*(u8 *)__gu_p =3D (__force u8)(val);=09=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 2:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_le16((__force u16)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 4:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_le32((__force u32)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 8:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_le64((__force u64)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09default:=09=09=09=09=09=09=09\
> -=09=09__bad_unaligned_access_size();=09=09=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09}=09=09=09=09=09=09=09=09\
> -=09(void)0; })
> -
> -#define __put_unaligned_be(val, ptr) ({=09=09=09=09=09\
> -=09void *__gu_p =3D (ptr);=09=09=09=09=09=09\
> -=09switch (sizeof(*(ptr))) {=09=09=09=09=09\
> -=09case 1:=09=09=09=09=09=09=09=09\
> -=09=09*(u8 *)__gu_p =3D (__force u8)(val);=09=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 2:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_be16((__force u16)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 4:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_be32((__force u32)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09case 8:=09=09=09=09=09=09=09=09\
> -=09=09put_unaligned_be64((__force u64)(val), __gu_p);=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09default:=09=09=09=09=09=09=09\
> -=09=09__bad_unaligned_access_size();=09=09=09=09\
> -=09=09break;=09=09=09=09=09=09=09\
> -=09}=09=09=09=09=09=09=09=09\
> -=09(void)0; })
> -
>  #endif /* _ASM_C6X_UNALIGNED_H */

Acked-by: Mark Salter <msalter@redhat.com>


