Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D254B165C33
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBTKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:54:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42464 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:54:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so33144120edv.9;
        Thu, 20 Feb 2020 02:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OlJB8KVjaJu4V3iCSe/8/XtMjoIEyaojr8gxPkxkMGA=;
        b=YmLSGpyqQuMziwODSpiwznHIecMt8xlGtrE6mNRoF0DPVpAAQkDzrFC6456P8JYVGl
         Pr9MdWMYhnH9VFIvaM6K60sPA4YvF1i5zSN9Ylm6lCp1rFvQ1vhrKmwpheJtIj7wRod3
         JFcuSInrVe8e+Qzgh4qLoi/zpp0TkqVtQnC0BJbYh2ylA9JJVjGWTfaZt7/PEr3+ngee
         /HRBBHiZnSkaGWpx1tjd5SwhExz7xLR7Mdr3SHryLqzKsl9B5XiyFevh+0cU62VKEdOb
         wfxUcr+lvVyb2qAak3+SBTLfjkcBwF7WjboFPsCBG5Hn2mg8A5hcpzWd2MsfN1BsmQga
         a/8w==
X-Gm-Message-State: APjAAAVome3DkTQ+F70X1Og+pXmaZMs+5pHZ8/+1WxqhKvyO0WrqXmIh
        V7r68nEQYKbY1JIamT0eS1E=
X-Google-Smtp-Source: APXvYqwyUudb+r8CvxVMqeA7AYv9LWCba2g0beLumjzze2LHmRQY3XC4lygmlBj+6JSDEmDo5t0KbQ==
X-Received: by 2002:a17:906:20c5:: with SMTP id c5mr28401732ejc.330.1582196075658;
        Thu, 20 Feb 2020 02:54:35 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id a10sm76892edt.50.2020.02.20.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:54:34 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:54:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Donghoon Yu <hoony.yu@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
Message-ID: <20200220105432.GA24587@pi3>
References: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:26:27AM +0100, Greg Kroah-Hartman wrote:
> There is no need to tie this driver to only a specific SoC, or compile
> test, so remove that dependancy from the Kconfig rules.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Donghoon Yu <hoony.yu@samsung.com>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

