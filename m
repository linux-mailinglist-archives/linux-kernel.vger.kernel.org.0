Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A68CD8CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 21:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJFTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Oct 2019 15:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJFTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E832077B;
        Sun,  6 Oct 2019 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570388917;
        bh=BcvGHiL+p+7ntg/3PF6YfqrRfphYWWCc4jkG1eHl7LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIdqH6hHNI9YsfNptiXFPA2D6mlUCPwKaLQIDbXX/aAMAHucmZCLzrnOXpL0T8t+B
         1cDEGP7P9hYsPSWMXkHNSi+DaPaEHFiAfwXW1BwmTz0Wmd9uOyuTEgws/zMg/Frszh
         K5s4fQKTR8zQKCtaWl3RDNvIuvxHfOvuTAEddRS0=
Date:   Sun, 6 Oct 2019 21:08:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk, olsonse@umich.edu
Subject: Re: [PATCH] staging: comedi: Fix camelcase check warning
Message-ID: <20191006190835.GC237538@kroah.com>
References: <20191006184453.11765-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006184453.11765-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:44:53PM +0100, Jules Irenge wrote:
> Capitalize unit_ma to fix camelcase check warning.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/comedi/comedi.h    | 4 ++--
>  drivers/staging/comedi/comedidev.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> index 09a940066c0e..df770043b37d 100644
> --- a/drivers/staging/comedi/comedi.h
> +++ b/drivers/staging/comedi/comedi.h
> @@ -674,7 +674,7 @@ struct comedi_rangeinfo {
>   * linear (for the purpose of describing the range), with sample value %0
>   * mapping to @min, and the 'maxdata' sample value mapping to @max.
>   *
> - * The currently defined units are %UNIT_volt (%0), %UNIT_mA (%1), and
> + * The currently defined units are %UNIT_volt (%0), %UNIT_MA (%1), and
>   * %UNIT_none (%2).  The @min and @max values are the physical range multiplied
>   * by 1e6, so a @max value of %1000000 (with %UNIT_volt) represents a maximal
>   * value of 1 volt.
> @@ -909,7 +909,7 @@ struct comedi_bufinfo {
>  #define RF_EXTERNAL		0x100
>  
>  #define UNIT_volt		0
> -#define UNIT_mA			1
> +#define UNIT_MA			1

Sorry, but "mA" is a unit of measurement of power, and needs to stay
as-is.

thanks,

greg k-h
