Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64714AEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 05:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgA1Enf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 23:43:35 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44922 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1Enf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 23:43:35 -0500
Received: by mail-pf1-f173.google.com with SMTP id y5so2911275pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 20:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o/eiodGD5lp4RWZNR205Jfk41Ea2mOrlpEOAJGFIIOE=;
        b=RDbsI95fxayjdpnQGgTzzWcOn+WF5GX4k/uSyZQlGLHI+1rbOZT/V0Go2Bfaaq/LXi
         +GTw9RApTN5AaG+yvm+3S7bxl1mEWmLqecwTtD/Pr/MiRZ5jueoHu351RXFAGSdnUpE+
         M5CHud/zIRiBVrqG2IQcdWM2IypgB52/sJgKA1D3lv1sQQ2L83IUz0eT/IdnwMOX5doh
         yrd5RBaYVxQe6BtZvJetc96h167zt+dQpuOreo+vr0tvVLzOlUcgAElvJsOz1IlUeSFI
         fSkvu+z1LyVLIuHoXF4Y/9bMA8P7+dmC1zERot7GkrKYBcG5O3YqMYytWzXAD48AxCxc
         eURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/eiodGD5lp4RWZNR205Jfk41Ea2mOrlpEOAJGFIIOE=;
        b=Uot6eRdWuzXhWb/fZ+q1YU5g92snU6H921IKET44fOLylvQC7xNzHWI1d16tsAqibh
         7B0AVszH4JJ41ViN9WNHTd2JsPRJg5H/miwBybnx32jH+jK73WqW3IOPsOHXVIc5gLtM
         7DOswkhxLmUJIpiDZyjC0Fi+IDxsUNmb662Zt7UxLX1ppj2d0AIWpe+fNPNiixTuKJux
         Y8YfIcuyF5yzjUERDaDqPvT9uJDNvs/LV+mBUPAD026Cbg11cTk2ZeMWHe94jEpRaIXe
         ZDyvYdEHkWh8GfuDSgXkJLkReprQu6ubUExYOHMFdCfQqUkBTw5gnBZnpX102qWUQPsA
         5d+A==
X-Gm-Message-State: APjAAAWOFbnlb2FyeBDKaJ0SxD1TZEreLfthFzLl30t5npxL0sbZW6TE
        bHz0zS+2NvaIJiwndM6JADk=
X-Google-Smtp-Source: APXvYqwxDJIVmbpnATu5bEpg3pxqqVwS4f7Pl082BK6VxiT99QH6kMl4MJUW5za+f9V+ZY+s5MRTDQ==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr22273186pgi.448.1580186614618;
        Mon, 27 Jan 2020 20:43:34 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id z14sm17352926pgj.43.2020.01.27.20.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 20:43:33 -0800 (PST)
Date:   Tue, 28 Jan 2020 13:43:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] console: Avoid positive return code from
 unregister_console()
Message-ID: <20200128044332.GA115889@google.com>
References: <20200127114719.69114-1-andriy.shevchenko@linux.intel.com>
 <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127114719.69114-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/27 13:47), Andy Shevchenko wrote:
[..]
>  	res = _braille_unregister_console(console);
> -	if (res)
> +	if (res < 0)
>  		return res;
> +	if (res > 0)
> +		return 0;
>  
> -	res = 1;
> +	res = -ENODEV;
>  	console_lock();
>  	if (console_drivers == console) {
>  		console_drivers=console->next;
> @@ -2838,6 +2840,9 @@ int unregister_console(struct console *console)
>  	if (!res && (console->flags & CON_EXTENDED))
>  		nr_ext_console_drivers--;
>  
> +	if (res && !(console->flags & CON_ENABLED))
> +		res = 0;

Console is not on the console_drivers list. Why does !ENABLED case
require extra handling? What about the case when console is ENABLED
but still not registered?

I think that if the console is not on the list (was never registered)
then we can just bail out, without console_sysfs_notify(), etc. IOW,

	if (res) {
		console->flags &= ~CON_ENABLED; /* just in case */
		console_unlock();
		return res;
	}

	-ss
