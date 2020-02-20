Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D76165C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBTKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:55:46 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38879 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTKzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:55:45 -0500
Received: by mail-ed1-f66.google.com with SMTP id p23so33159067edr.5;
        Thu, 20 Feb 2020 02:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HxC4605+KVWJsNCk5tm1pp2NBu/lLGZBF0ln8nNCRHI=;
        b=RUdAChxRR6JCADu4AxQT9usfuHUJxQuZ+gwXMMpYPBjS3lVZJDfUXwuny/Ln+7wSyf
         OEuLGH+SQSoVtLjGeOB9F4SVVsgRuvC51DbxwJM+msOrRFucqAzuX8bL69qqIu+8obOA
         C0K5zm66MpuuEPe/KEZJXYqpaoHwzPB0FZbTnSOc2wClcWr6ZUFtfeLf3PJYMfZ9eAiR
         j2Y431SYLjNPbDhI7aLQ8cGLFrrBqlQVKsbD7Ix6n9Z+7ybZjJhXjiXqQV5J8s03B3RU
         pMr4LF1KesQMr3CeJRQtPXkw9aThugHJPq+d5Rlw/1m/roK4bMonn4eO8jASAifCGtua
         ZECQ==
X-Gm-Message-State: APjAAAVeRpNaz9iBkUVZXKScaUZDKjdqXRWcmgGvRDIOD0fGv2LP5hi3
        W50yvirnRHSci5VdKGs9uuQ=
X-Google-Smtp-Source: APXvYqzTLPh931RWB799Q6pryHxossHIt8rBOWsQX0wPKNGao+iaWcMDnUGW9wCQFJALFke4UzixDQ==
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr29314401ejj.184.1582196143675;
        Thu, 20 Feb 2020 02:55:43 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id cb20sm84735edb.1.2020.02.20.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:55:43 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:55:41 +0100
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
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: remove SERIAL_SAMSUNG_DEBUG
Message-ID: <20200220105541.GB24587@pi3>
References: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
 <20200220102628.3371996-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200220102628.3371996-2-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:26:28AM +0100, Greg Kroah-Hartman wrote:
> Since a05025d0ce72 ("tty: serial: samsung_tty: use standard debugging
> macros") this configuration option is not used at all, so remove it from
> the Kconfig file.
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
>  drivers/tty/serial/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

