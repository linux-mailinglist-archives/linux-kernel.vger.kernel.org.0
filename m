Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDBA506E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 09:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbfIBHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 03:54:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:46806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729606AbfIBHyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:54:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5326BAFBE;
        Mon,  2 Sep 2019 07:54:16 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] x86/xen/efi: Fix EFI variable 'name' type
 conversion
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190901065828.7762-1-adam.zerella@gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <84ce8eca-b02a-de32-2e1b-a0bf3542c674@suse.com>
Date:   Mon, 2 Sep 2019 09:54:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901065828.7762-1-adam.zerella@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2019 08:58, Adam Zerella wrote:
> This resolves a type conversion from 'char *' to 'unsigned short'.

Could you explain this? There's no ...

> --- a/arch/x86/xen/efi.c
> +++ b/arch/x86/xen/efi.c
> @@ -118,8 +118,8 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>  	unsigned long size;
>  
>  	size = sizeof(secboot);
> -	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
> -				  NULL, &size, &secboot);
> +	status = efi.get_variable((efi_char16_t *)L"SecureBoot",
> +				  &efi_variable_guid, NULL, &size, &secboot);

... "char *" resulting as type for L"" type strings, hence there
should be no need for a cast: In fact I consider such casts
dangerous, as they may hide actual problems. To me this looks
more like something that wants fixing in sparse; the compilers,
after all, have no issue with such wide character string literals.

> @@ -158,7 +158,7 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
>  	return efi_secureboot_mode_unknown;
>  }
>  
> -void __init xen_efi_init(struct boot_params *boot_params)
> +static void __init xen_efi_init(struct boot_params *boot_params)
>  {
>  	efi_system_table_t *efi_systab_xen;

If I was a maintainer of this code, I'd request this not be part
of a patch with a title being entirely unrelated to the change.

Jan
