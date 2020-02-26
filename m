Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC9316F911
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBZIJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:09:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43067 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgBZIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:09:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id e3so904306lja.10;
        Wed, 26 Feb 2020 00:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZAhX4Kjo49a/2nrW9qMMuYh2FGtltiAUaTTCoWUNQzg=;
        b=PDenjLes/GWTVzHKoE/Lf3aacAyb7nPmJALDm/LuSDhMODjG0r2EXcppKP2F/QM/0z
         EOsPX4rHFPIva+tkHNQfmgafiP/m9pMaBqiZJRqEHEzgnILghV7jkjGO5Ks76eiC2dQc
         X2lvX3TOqNEXw2nz832ud925hnPfmE8vnLm3EXgaNzMSBesZooJ5d7aNUB7eN4nSeZjO
         lajp9IwdyKiDpJC4T3sY/xdKo1CUsgloppOVpBi5AX6y3h64O5f0FpKs6YZbOyj5wU58
         i9vyZh8K8Y26SoEbugxEQLy50sMz+Bw+LbusSJLnoWx4LqoGJ3DojYmYmk5WqIF1UoZ5
         eMVA==
X-Gm-Message-State: APjAAAUr4cGcUEPPekMarEthiTYXyIDWBsBfgn4c0toTCFH12AnU7E4t
        Z9h5PFW9aDVatGfnm88ZB7o=
X-Google-Smtp-Source: APXvYqy2c9A7UaDZGtGr2NVUzZ8Jdh6Kobi7GpHvV93wWsGLiJ3jESZEAk9pFU+2KOdWibxOnvzc7g==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr2072219ljo.125.1582704547829;
        Wed, 26 Feb 2020 00:09:07 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id q24sm579459lfm.78.2020.02.26.00.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:09:06 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j6rkg-0001VD-1N; Wed, 26 Feb 2020 09:09:06 +0100
Date:   Wed, 26 Feb 2020 09:09:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 2/2] USB: core: Fix potential memory leak in
 usb_get_configuration()
Message-ID: <20200226080906.GV32540@localhost>
References: <1582697723-7274-1-git-send-email-yangtiezhu@loongson.cn>
 <1582697723-7274-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582697723-7274-2-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:15:23PM +0800, Tiezhu Yang wrote:
> Make sure to free all the allocated memory before exiting from the function
> usb_get_configuration() when an error is encountered.

There's no leak in this function as far as I can tell. Any allocated
memory is released in usb_destroy_configuration() when the last
reference to the struct usb_device is dropped.

> Additionally, just initialize the variable "bigbuffer" with NULL to avoid
> the following build warning:
> 
>   CC      drivers/usb/core/config.o
> drivers/usb/core/config.c: In function ‘usb_get_configuration’:
> drivers/usb/core/config.c:956:2: warning: ‘bigbuffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   kfree(bigbuffer);
>   ^

No need to mention warnings that you introduce yourself while creating
your patch. It can give the false impression that your addressing an
existing issue.

Johan
