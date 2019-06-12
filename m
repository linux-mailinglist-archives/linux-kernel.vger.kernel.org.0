Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A741F23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbfFLIcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:32:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39084 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407716AbfFLIcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:32:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so5558089wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=elnxBkNCma41sMkOxOWDVjUsgCU/GoA9ERrnaNF4eUU=;
        b=zM8zui/rXaEteSzriFQT3Jw20fT1pOfMGsOIliWLkX7DvPBrbj2W58l3/vlXfU0Fiy
         UNqeKZis0dgx+GIleGinZnabgE9Q9GiaYVU8L6wiotBGstWOZkGeKJNdamb//XUDe/rV
         H6nd848y8pYePp0OhTLa63x3oG3IGqOo2or56Aus8GctLuhWXkoEUX/bcbQp8Jf2fR5E
         MKUM0g3O/nbxnpui5Sr1la7SgRAJjK2T1z47GIGVoEfNSJj0Hl0BBoy5Ttyjm+jZSpr3
         TUkpcPLr+BLJnPlEblHxFGniFpXk/iw9P6lLjnIEVettDHf67wxFtYOb6913R+x7fREo
         BMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=elnxBkNCma41sMkOxOWDVjUsgCU/GoA9ERrnaNF4eUU=;
        b=W7AQQDucWYccK48pY9vCRQ3QYRkYLCrHh3zQeUEIwuk0W45Vw8PRTkRaAhZCkyltLo
         Tqt4OC5jd1SSQ5KAi+/XNZy3RCXjy4jDLoJX326CJ78wg98kRG1GuurCHYF6xYZS6zPF
         k8LI/okInLF2O5iTqMtkjU6TbcKLGk1Y2DNFx28lRxV50ekTErWFKzBqDN1QcjY8ZoOV
         VAS7Jz2JvxWd2HxkuqE4ykjCMWE71rUH1Ku9Kym+JfkxlbBqFdUU/OYVLQ2svBvyNdiF
         e6PgNVhbynO1o5s4dy37Sy+bJjfDHMYBEXTfWz8YPddL+tx8iuxdrtSTko4KJqj3QLI0
         pDPQ==
X-Gm-Message-State: APjAAAXj8eYe5RG6qxkjrnQjTXH6RlBS7J/ET+ovUYzAqDjE+R7cFkLV
        gPB0bRMXo0NH0kVTEUQDBTKZa2h6DyE=
X-Google-Smtp-Source: APXvYqyZ64afzsciAZHPy/iMujom6OU8npQfrsuuP1wG3ZSRwXtA1bBlWHx1KoW4Mh2Kxb5yQ+iB7A==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr20027023wmd.54.1560328333629;
        Wed, 12 Jun 2019 01:32:13 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id v2sm12823354wrn.30.2019.06.12.01.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:32:13 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:32:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     arnd@arndb.de, natechancellor@gmail.com, ottosabart@seberm.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 4/4] mfd: madera: Add supply mapping for MICVDD
Message-ID: <20190612083210.GW4797@dell>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
 <20190520090628.29061-4-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520090628.29061-4-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019, Charles Keepax wrote:

> Currently we are relying on the exact match of the regulator name to
> find MICVDD, we should add an explicit supply mapping to allow this to
> be found more reliably.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
