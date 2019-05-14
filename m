Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09F1C848
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 14:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENMOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 08:14:11 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:50248 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:14:11 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 May 2019 08:14:10 EDT
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 46C4F12F2625;
        Tue, 14 May 2019 14:04:34 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JVAF5zPZzDM4; Tue, 14 May 2019 14:04:26 +0200 (CEST)
Received: from probook (geri.datenkhaos.de [81.7.17.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Tue, 14 May 2019 14:04:26 +0200 (CEST)
Date:   Tue, 14 May 2019 14:04:21 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <20190514120416.GA11736@probook>
References: <20190423183827.GA4012@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423183827.GA4012@beast>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019 Apr 23, Kees Cook wrote:
> When building x86 with Clang LTO and CFI, CFI jump regions are
> automatically added to the end of the .text section late in linking. As a
> result, the _etext position was being labelled before the appended jump
> regions, causing confusion about where the boundaries of the executable
> region actually are in the running kernel, and broke at least the fault
> injection code. This moves the _etext mark to outside (and immediately
> after) the .text area, as it already the case on other architectures
> (e.g. arm64, arm).
> 
> Reported-and-tested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index bad8c51fee6e..de94da2366e7 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -141,11 +141,11 @@ SECTIONS
>  		*(.text.__x86.indirect_thunk)
>  		__indirect_thunk_end = .;
>  #endif
> -
> -		/* End of text section */
> -		_etext = .;
>  	} :text = 0x9090
>  
> +	/* End of text section */
> +	_etext = .;
> +
>  	NOTES :text :note
>  
>  	EXCEPTION_TABLE(16) :text = 0x9090
> -- 
> 2.17.1

This breaks the build on my system:

  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
  CC      arch/x86/boot/compressed/early_serial_console.o
  CC      arch/x86/boot/compressed/kaslr.o
  AS      arch/x86/boot/compressed/mem_encrypt.o
  CC      arch/x86/boot/compressed/kaslr_64.o
Invalid absolute R_X86_64_32S relocation: _etext
make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
make: *** [arch/x86/Makefile:283: bzImage] Error 2



-- 
Regards,
  Johannes

