Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DA13DBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 14:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAPNXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 08:23:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56122 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgAPNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:23:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3735079wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EVRpEFPY1VREO4ncfrXKbPDXxUPEIIvDqwIatn/kDTo=;
        b=hDYEdePfJY15H+bqoszFBiEN98V7DpLOMtZfzzkGNnQA/JKpeXUSCFoqFo68UOUzSX
         Ux7WfQElJv8WQraKyvxKU24cBlhgitGs/fhMbU3ZC8zykiHGwQVeXYU/zvS56i5tDo74
         fWepVTr75iE7uVM7hbz8WTUnW4xsC6EIAsslIj0h9LrtJNi7xHa6LJ+sm/Lniz9xm9yJ
         3lfJHh7iLNRP9OL8zMI+WoGfG6dBYTkrX32sUyj6rWiaHxclV1d9AuoDAi2ijDgmzhbj
         NB9hk2ms/qIimkTy0x5nsgks5kSEfxY4YY6MXT7WzMHxJ8Y7ogXLuDAbwWh8KhzOzDgR
         u3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EVRpEFPY1VREO4ncfrXKbPDXxUPEIIvDqwIatn/kDTo=;
        b=EDqN+69qbzYdEIFS+w8Sul1glw2ehVm7CkJ4akRM6gVBgA/fl/n1CKvRbOdYwFQ/M7
         TKzcJZJEDV4slHqxjVqA6LN2bxgDAcySUehWmXAYZVS64t8OMhgxSmpIcaMYzN+kJcGS
         fTnegx4tm00PjIaGyVIE/Izpq8l+XgBalnkUK45a5KTpWtpG07NH6+eQ6TsHclnm5VyC
         exOJvfKWI1c5q1ux9vINbzfH2o/kREht4zUsuL1EbYyvzcKs/gD7WyXjRRPXBVPjLPca
         ZvYI4jlmDLdskTTxk9ZGBqLAQpzbFOtf9xbC3Q+6poOSKUbMgXvMaTKYdNAJYoc5CfUu
         vBvw==
X-Gm-Message-State: APjAAAWPg6BBP2gzYzW+sB5pE38luzFG5SARdfWO4NfGxUg48BbtZjzD
        cLMiD2OUV5YIHvE5dsZSdolcQQ==
X-Google-Smtp-Source: APXvYqz7ydMS0qzshbUgoBS//emT2beO6d3qTTEWrAIC1Cdjj8QZE4VgiSxaXE2Ec4kbtWE775xjig==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr5892550wmc.119.1579181018638;
        Thu, 16 Jan 2020 05:23:38 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id h2sm30644072wrt.45.2020.01.16.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:23:38 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:23:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] mfd: cs47l15: Add missing register default
Message-ID: <20200116132357.GK325@dell>
References: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Charles Keepax wrote:

> Accessory detect mode 1 is missing a default, add one to the table.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> This patch can be applied separately from the other patches in the series,
> if needed.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/cs47l15-tables.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
