Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52BE1C2EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbfJAIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 04:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729543AbfJAIei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:34:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F6FFAF27;
        Tue,  1 Oct 2019 08:34:36 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen/efi: have a common runtime setup function
To:     Juergen Gross <jgross@suse.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191001082534.12067-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <c8ff366c-dd2c-b4b3-1832-8b93d11d1181@suse.com>
Date:   Tue, 1 Oct 2019 10:34:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001082534.12067-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.2019 10:25, Juergen Gross wrote:
> @@ -281,4 +270,26 @@ void xen_efi_reset_system(int reset_type, efi_status_t status,
>  		BUG();
>  	}
>  }
> -EXPORT_SYMBOL_GPL(xen_efi_reset_system);
> +
> +/*
> + * Set XEN EFI runtime services function pointers. Other fields of struct efi,
> + * e.g. efi.systab, will be set like normal EFI.
> + */
> +void __init xen_efi_runtime_setup(void)
> +{
> +	efi.get_time			= xen_efi_get_time;
> +	efi.set_time			= xen_efi_set_time;
> +	efi.get_wakeup_time		= xen_efi_get_wakeup_time;
> +	efi.set_wakeup_time		= xen_efi_set_wakeup_time;
> +	efi.get_variable		= xen_efi_get_variable;
> +	efi.get_next_variable		= xen_efi_get_next_variable;
> +	efi.set_variable		= xen_efi_set_variable;
> +	efi.set_variable_nonblocking	= xen_efi_set_variable;
> +	efi.query_variable_info		= xen_efi_query_variable_info;
> +	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
> +	efi.update_capsule		= xen_efi_update_capsule;
> +	efi.query_capsule_caps		= xen_efi_query_capsule_caps;
> +	efi.get_next_high_mono_count	= xen_efi_get_next_high_mono_count;
> +	efi.reset_system		= xen_efi_reset_system;
> +}
> +EXPORT_SYMBOL_GPL(xen_efi_runtime_setup);

I don't think exporting an __init function is a good idea, and I also
don't see why the function would need exporting had it had the __init
dropped. With the line dropped
Reviewed-by: Jan Beulich <jbeulich@suse.com>

Jan

