Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F611737
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 12:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEBK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 06:26:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40625 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:26:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so1464876lfl.7;
        Thu, 02 May 2019 03:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h2cWxngpT20ZMfG3eOK3pNNe/GlsC/KIDAQpK5RfIwg=;
        b=BIr6nPRwjadS7Rbnhlm4RxIdDabgyPyj7reDPc9MzQKBLxZLR9TAdhSKV6hLKxbiI5
         Ind9JEz8+VJ83RW28e8TFjT9A1PiT0J2oq5uNap1S7pPuZ07iCB2plYtvYnoOULgfWzV
         ePX98uXaRKb4uGMk6PE3s324XkjuZRv0AYNVDbIVCfCrIeiBQFU4Pd4902LzrmF6mLU8
         m63XgSvQd6IhqoZfMCockysxRgZGnO/zI9PCZA/d5x8ydApkv6R0DVmORW6E2cj3xyxK
         d3NbAiT2EMbHddOeEAexwxKjVdm75mJmo/1vXJ62Xe5rsNUGcegyp8wSuwZSrsFmcR1B
         qhng==
X-Gm-Message-State: APjAAAXDuCQpnnUA/Za56EbgPI5ykxW4zjyFaSjvIWr91tLOUc6UV/q+
        gCBMPv88TO37DsXoowNQs+4=
X-Google-Smtp-Source: APXvYqyLVM37TMfk9L9nCPHALYb1CpY8WCN2mVZesSegxWseGQ5TVBvqvuoedXc67VIzvMAl7Pg7Wg==
X-Received: by 2002:ac2:4465:: with SMTP id y5mr1550419lfl.82.1556792760262;
        Thu, 02 May 2019 03:26:00 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k4sm5931777lja.18.2019.05.02.03.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 03:25:59 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hM8um-0004gG-I2; Thu, 02 May 2019 12:26:09 +0200
Date:   Thu, 2 May 2019 12:26:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502102608.GS26546@localhost>
References: <20190501213329.GA26972@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501213329.GA26972@embeddedor>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (bufferLength == 0) {
>        ^
> drivers/usb/serial/io_edgeport.c:1755:3: note: here
>    case EXPECT_HDR2:
>    ^~~~
> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>      if (bufferLength == 0) {
>         ^
> drivers/usb/serial/io_edgeport.c:1816:3: note: here
>    case EXPECT_DATA: /* Expect data */
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comments are modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
>    instead of warning level 2.
>  - All warnings in the switch statement are addressed now.
> 
> Notice that these are the last remaining fall-through warnings
> in the USB subsystem. :)

>  drivers/usb/serial/io_edgeport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 4ca31c0e4174..7ad10328f4e2 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>  				edge_serial->rxState = EXPECT_HDR2;
>  				break;
>  			}
> -			/* otherwise, drop on through */
> +			/* Fall through - otherwise, drop on through */
>  		case EXPECT_HDR2:
>  			edge_serial->rxHeader2 = *buffer;
>  			++buffer;
> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>  				}
>  				/* Else, drop through */
>  			}
> +			/* Fall through */
>  		case EXPECT_DATA: /* Expect data */

Looks like you forgot to take the original review feedback you got into
account:

	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no

Johan
