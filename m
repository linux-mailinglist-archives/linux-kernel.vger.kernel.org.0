Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607E41702B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBZPg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:36:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgBZPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:36:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so3572891wre.9;
        Wed, 26 Feb 2020 07:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tLYmvTo+IUiYZSw2mbf7ipuU9Qwuuvs8XHZ4xNHHFbA=;
        b=lPBbrh1eufzYZCHFdm3Pi+txT+IMMtQMEeq+OoYo3+S6Zz/MkFGT/vl6qj8yDhK88o
         UifU83mxURCJ8cLmfgfY0bMbiiiGWfHqHif2w8OESaK8LOe7ce4GQfg21/LC5zVJNMIW
         IoGleLz3ajqD7vIZG/5WDta/lhnxVwg+p3VYlb27NEMIspiPMqsI9rNkwix72vCrwWC/
         b9pA5DjeW7Y0Wh50jU9dRlO6iDJR6gHQKawPIQDM3ZLp8aWkN0AvJ+7HCauebYVvvehO
         vGpai9X9kUlTI8wbHZ8W2S0yz43u/bJmlPDhDDMkrsIFQQAGh05YUmZ/RC4Ptuc/gvc5
         YOBw==
X-Gm-Message-State: APjAAAWmf0bZfZW5/IXJBrCR1UWYBOrVm2YF9jv9UHmqgwmcD5PLSvf/
        hdJe6fp7/oZdeZotKVZrXZlocFsP
X-Google-Smtp-Source: APXvYqz2z0j7xPVqtvGvdftuajp1Pa6DO/s4HXcHlN/f5JYww38hIMjAzWmZ6xfCp61SpGZaeIFzZw==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr6015479wrm.75.1582731414675;
        Wed, 26 Feb 2020 07:36:54 -0800 (PST)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id z16sm3556272wrp.33.2020.02.26.07.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 07:36:54 -0800 (PST)
Reply-To: efremov@linux.com
Subject: Re: [PATCH 15/16] floppy: separate the FDC's base address from its
 registers
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224212352.8640-1-w@1wt.eu> <20200226080732.1913-1-w@1wt.eu>
 <20200226080732.1913-5-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <ab69fbdc-7ccb-05ef-6c25-7fb6ed6fce59@linux.com>
Date:   Wed, 26 Feb 2020 18:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226080732.1913-5-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> One place in the ARM code used to check if the port was equal to FD_DOR,
> this was changed to testing the register by applying a mask to the port,
> as was already done in the sparc code.
> 
> The sparc, m68k and parisc code could now be slightly cleaned up to
> benefit from the macro definitions above instead of the equivalent
> hard-coded values.

Just to note for future ref: the mask (7) can be introduced as define
during future clean up of these magic constants.

> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  arch/arm/include/asm/floppy.h |  2 +-
>  drivers/block/floppy.c        |  9 ++++-----
>  include/uapi/linux/fdreg.h    | 18 +++++-------------
>  3 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
> index c665136..4e3fb71 100644
> --- a/arch/arm/include/asm/floppy.h
> +++ b/arch/arm/include/asm/floppy.h
> @@ -12,7 +12,7 @@
>  #define fd_outb(val,port)						\
>  	do {								\
>  		int new_val = (val);					\
> -		if ((port) == (u32)FD_DOR) {				\
> +		if ((port) & 7 == FD_DOR) {				\
>  			if (new_val & 0xf0)				\
>  				new_val = (new_val & 0x0c) |		\
>  					  floppy_selects[new_val & 3];	\
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 250a451..4e43a7e 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -171,7 +171,6 @@ static int print_unex = 1;
>  #include <linux/kernel.h>
>  #include <linux/timer.h>
>  #include <linux/workqueue.h>
> -#define FDPATCHES
>  #include <linux/fdreg.h>
>  #include <linux/fd.h>
>  #include <linux/hdreg.h>
> @@ -594,14 +593,14 @@ static unsigned char fsector_t;	/* sector in track */
>  static unsigned char in_sector_offset;	/* offset within physical sector,
>  					 * expressed in units of 512 bytes */
>  
> -static inline unsigned char fdc_inb(int fdc, unsigned long addr)
> +static inline unsigned char fdc_inb(int fdc, int reg)
>  {
> -	return fd_inb(addr);
> +	return fd_inb(fdc_state[fdc].address + reg);
>  }
>  
> -static inline void fdc_outb(unsigned char value, int fdc, unsigned long addr)
> +static inline void fdc_outb(unsigned char value, int fdc, int reg)
>  {
> -	fd_outb(value, addr);
> +	fd_outb(value, fdc_state[fdc].address + reg);
>  }
>  
>  static inline bool drive_no_geom(int drive)
> diff --git a/include/uapi/linux/fdreg.h b/include/uapi/linux/fdreg.h
> index 5e2981d..1318881 100644
> --- a/include/uapi/linux/fdreg.h
> +++ b/include/uapi/linux/fdreg.h
> @@ -7,26 +7,18 @@
>   * Handbook", Sanches and Canton.
>   */
>  
> -#ifdef FDPATCHES
> -#define FD_IOPORT fdc_state[fdc].address
> -#else
> -/* It would be a lot saner just to force fdc_state[fdc].address to always
> -   be set ! FIXME */
> -#define FD_IOPORT 0x3f0

Again, just to note: FD_IOPORT (now removed), FDC1, FDC_BASE are pointing to
the same port 0x3f0 in many cases.
And at least in some cases used directly:
$ fgrep --include='*floppy*' -nrie '0x3f0' .
./arch/mips/include/asm/mach-generic/floppy.h:113:      return 0x3f0;
./arch/m68k/include/asm/floppy.h:124:     return 0x3f0;
./drivers/block/floppy.c:234:static unsigned short virtual_dma_port = 0x3f0;

> -#endif
> -
>  /* Fd controller regs. S&C, about page 340 */
> -#define FD_STATUS	(4 + FD_IOPORT )
> -#define FD_DATA		(5 + FD_IOPORT )
> +#define FD_STATUS	4
> +#define FD_DATA		5
>  
>  /* Digital Output Register */
> -#define FD_DOR		(2 + FD_IOPORT )
> +#define FD_DOR		2
>  
>  /* Digital Input Register (read) */
> -#define FD_DIR		(7 + FD_IOPORT )
> +#define FD_DIR		7
>  
>  /* Diskette Control Register (write)*/
> -#define FD_DCR		(7 + FD_IOPORT )
> +#define FD_DCR		7
>  
>  /* Bits of main status register */
>  #define STATUS_BUSYMASK	0x0F		/* drive busy mask */
> 

Denis
