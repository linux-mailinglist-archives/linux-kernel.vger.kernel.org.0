Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1B0137875
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 22:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgAJVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 16:24:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39962 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgAJVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:24:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so1315365plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=maSb7NbKA8RvJCKXTu3J6eAjmLjqK2UyEvGtUUh/Ctc=;
        b=Zveaai5/9cXZtqeck7OmqZP52tAyNc8qpNe54bieASVVuCSGAWQvdNywubCKZt6Hyc
         jNnNCwCwd8Ee41gYguC2uRH18nHbhLeMhwYhhsiL95t4hwBNtLU0YFFnT4+9zP3cQmOp
         QbfFuDHwqi2dIKCvd+JrRHK0iDIop4xNQKogoZ0Rlm3mJvNvhoqTJPR0fwaE97Pk9x7x
         JJgmYjp65pdZ3cKWseBYTBJGdpV+bnjAuALSoB+xk0vxiEGCjq74PzUx/TGaLTpUx7e4
         8B00vnCl0dPDfKT0akhxe1KhVh0zLsSzg6+NkRRtO8eO8Ytm5KMBep5wEYePm8LDTrm1
         MCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=maSb7NbKA8RvJCKXTu3J6eAjmLjqK2UyEvGtUUh/Ctc=;
        b=Ij+k6skjZdIhGxAleVi0B9h5E6+2R3qJ1V5cWBUeKh0BfSmCGh/VEh2crYaIdO45Jc
         v4DgGyz4t2lzszubpXWzCJ+mYxeSCtIWPnQPHzm4iWQQUQbjEwIKpO6kbBuoPqzcwvDS
         H1eZsLjnnaWUsEKzFtztyw/sVGbMqCHLYMt+CAhIJ1afRCm1/5A/fU1af91uiRXFKLpP
         cEeG3CaXUYAvsoFCxc7BLaklhS1qZ1gWy5Qk3C8ci1H2kBlVWIg6+wkZk5l2ZCMlg0aP
         KW+/l8ZVcfEonOD5KW72PFe80qAC7UM3afMKclrlTJ8PqmOVNHQcCEEYVFE47JbFN0uJ
         r6dA==
X-Gm-Message-State: APjAAAWXBYxT9BJwIsZ42gCcd/YyKkRMuygrG2TKCNAtG5ft8xhoTWxf
        0+EeRtMtr1VGLnGCMJSd8HawGA==
X-Google-Smtp-Source: APXvYqz0xN3YzQi+V8Q6l0p+gowP+/bS/MOw7GEhPN3cUQ2tDIyWmEtQw9cQ4CP20+JsQGY+xUpETA==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr669024pls.70.1578691458706;
        Fri, 10 Jan 2020 13:24:18 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
        by smtp.gmail.com with ESMTPSA id d2sm3914889pjv.18.2020.01.10.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:24:18 -0800 (PST)
Date:   Fri, 10 Jan 2020 13:24:18 -0800 (PST)
X-Google-Original-Date: Fri, 10 Jan 2020 13:24:08 PST (-0800)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH v2] riscv: keep 32-bit kernel to 32-bit phys_addr_t
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
To:     Olof Johansson <olof@lixom.net>
In-Reply-To: <20200106232024.97137-1-olof@lixom.net>
References: <20200106232024.97137-1-olof@lixom.net> <20200106231611.10169-1-olof@lixom.net>
Message-ID: <mhng-d39bd2da-7e27-484a-b8f8-a96edf1336c0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020 15:20:24 PST (-0800), Olof Johansson wrote:
> While rv32 technically has 34-bit physical addresses, no current platforms
> use it and it's likely to shake out driver bugs.
>
> Let's keep 64-bit phys_addr_t off on 32-bit builds until one shows up,
> since other work will be needed to make such a system useful anyway.
>
> PHYS_ADDR_T_64BIT is def_bool 64BIT, so just remove the select.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>
> v2: Just remove the select, since it's set by default if CONFIG_64BIT
>
>  arch/riscv/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a31169b02ec06..569fc6deb94d6 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,8 +12,6 @@ config 32BIT
>
>  config RISCV
>  	def_bool y
> -	# even on 32-bit, physical (and DMA) addresses are > 32-bits
> -	select PHYS_ADDR_T_64BIT
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ

I gave 5.5-rc5 a quick test on a 32-bit QEMU with 8GiB of RAM and the system
wouldn't boot, so we've got at least some bugs floating around somewhere.
Given that this doesn't work I don't see any reason to keep it around as an
option, as if someone wants to make it work there's a lot more to do than make
things compile.

I've put this on for-next.  If anyone cares about 34-bit physical addresses on
rv32 then now is the right time to speak up... ideally by fixing it :)

Thanks!
