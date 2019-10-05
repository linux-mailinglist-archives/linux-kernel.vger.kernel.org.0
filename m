Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E69CC6DD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 02:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfJEAM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 20:12:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37708 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfJEAM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:12:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id l3so11035841qtr.4;
        Fri, 04 Oct 2019 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=UB1bvAHKtB8Fu/zPJekZdh4cFOIGI0vJgOHseb20dz4=;
        b=F6l7A8HWxprwza4dQkT8lMxz7mQHRHhzQMCewXGRc7Qc/CL6Iw4cIB5DMTPdB1dOlX
         MfthZ6k5vqUn/ELztTIsnTTwYetTee+wNiaYFnD3MaLbxyxW8AHi3sZlM0UdxXraefMR
         kzBb/4wTtUG45ILORv4+bg/1QKnum/eXkyIbFKwCvJLUmQ1EVo4HtOt3FQxogAvksi+v
         wrFmyqGbhVgLGPCb5vp6s1KJygxTt+EfkPIWMXJ+Cd7x15Sk9rG3jC3WNeoZghdgcjd5
         NpFq0T8csCR5IWatlP6WNBWHQXAXjjrm7qUAmxbVn0y9NaSTJAxCFKHCoM0CF39KnyMX
         gY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=UB1bvAHKtB8Fu/zPJekZdh4cFOIGI0vJgOHseb20dz4=;
        b=S3Y2RkKItfRh1BocbXU3vQPjnZKNzQ5BhUYpOENSuzGVyCNWZb0st11atxKoiEajB5
         PLqHbn0nnDfRodJActn0Htk7JfhCBJDob1CvmGGVMz++BC73H8Y/DG29pyGMzLPnBG8K
         dDowV6iynbQaDryGy51vpdRovXZHDjYOyNm5SMbhVI8mgw4qNEoc554PDAN0foJbYvxk
         SUxoZuq1WCT4yF1YHF4aiQA7meuNIIFajcF5WW1847k8LiNR6DeryBwzCf0JWsWIui/j
         RqC53VfHa61LsrcwIATCMk2d+sg1o4B/hDjia2qNutrt48hy8J+Gt0nfbqiwTPlExZmf
         ghzA==
X-Gm-Message-State: APjAAAXPtkpzIVpmeoaFKmIA4G0GZb4tQLpA9bS3zMUArNsoKcZanJcI
        H2YqDaASWIIPYoBnG6DqLYA=
X-Google-Smtp-Source: APXvYqwxkCMkxqCY7rTcF0hWNScWD9jtpiVdtBj5m+74GTZ7BHjR9EaQ7gM6cdj+k1+g44ppGU+LoA==
X-Received: by 2002:aed:3e66:: with SMTP id m35mr18462098qtf.325.1570234377602;
        Fri, 04 Oct 2019 17:12:57 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id w73sm4012016qkb.111.2019.10.04.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 17:12:56 -0700 (PDT)
Date:   Fri, 4 Oct 2019 20:12:56 -0400
Message-ID: <20191004201256.GB32368@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>, Andrew Lunn <andrew@lunn.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: fsl_lpuart: Fix lpuart_flush_buffer()
In-Reply-To: <20191004215537.5308-1-andrew.smirnov@gmail.com>
References: <20191004215537.5308-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Fri,  4 Oct 2019 14:55:37 -0700, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Fix incorrect read-modify-write sequence in lpuart_flush_buffer() that
> was reading from UARTPFIFO and writing to UARTCFIFO instead of
> operating solely on the latter.
> 
> Fixes: 9bc19af9dacb ("tty: serial: fsl_lpuart: Flush HW FIFOs in .flush_buffer")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

This fixes the TTY on my ZII Devel Boards Rev B and C:

Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
Tested-by: Vivien Didelot <vivien.didelot@gmail.com>


Thank you!

	Vivien
