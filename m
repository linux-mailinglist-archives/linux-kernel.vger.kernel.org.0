Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127DC10D566
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfK2MF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 07:05:58 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2MF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:05:58 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47PYB84LcQz9sR2;
        Fri, 29 Nov 2019 23:05:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575029155;
        bh=RgqQ6J3nCEijMroo3dPDXfMcTSuhbY20fzV//BwrQ7Q=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qMZUtX6f1gYjXhiwAf5QzK9IPtW2/Vrc6yE30o1jdtSlV/smWKBUhG/6e9ZZ5SbaC
         J45fHBly2fsIc2h4Oc6lDi5krivAxvNvIhzG28SfIl0F55x4er9ArJ4FGupcJkGvGJ
         ycFQMcbfHd8aiOX4SmKofGPa3GjY6MllAavbp+tUGh/cKIJ2O7WKeDJBySB5eQL/kC
         3gWTlBoSiY/o2Sh1WRqB/Ol6c+anbsqMYOs3V6rjqKTo0ErDTHMrfPghBBk3jaUE+H
         VEB3pAZ48nDzWYDSl9Nm7KJYpz83z5cIOGChkENINOcChDUUYZQWNMm5xjPZFZF5gO
         tsL3i85GXvRuQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YueHaibing <yuehaibing@huawei.com>, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, jwboyer@fedoraproject.org,
        yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/efi: remove unused variables
In-Reply-To: <20191115130830.13320-1-yuehaibing@huawei.com>
References: <20191115130830.13320-1-yuehaibing@huawei.com>
Date:   Fri, 29 Nov 2019 23:05:49 +1100
Message-ID: <87a78ega5e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:
> commit ad723674d675 ("x86/efi: move common keyring
> handler functions to new file") leave this unused.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/integrity/platform_certs/load_uefi.c | 5 -----
>  1 file changed, 5 deletions(-)

Thanks for spotting this, my x86 test builds did trigger it, but I
didn't notice the new warnings.

I've picked this up into the powerpc tree, as that's where the offending
commit is.

cheers

> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index 4369204..111898a 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -11,11 +11,6 @@
>  #include "../integrity.h"
>  #include "keyring_handler.h"
>  
> -static efi_guid_t efi_cert_x509_guid __initdata = EFI_CERT_X509_GUID;
> -static efi_guid_t efi_cert_x509_sha256_guid __initdata =
> -	EFI_CERT_X509_SHA256_GUID;
> -static efi_guid_t efi_cert_sha256_guid __initdata = EFI_CERT_SHA256_GUID;
> -
>  /*
>   * Look to see if a UEFI variable called MokIgnoreDB exists and return true if
>   * it does.
> -- 
> 2.7.4
