Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0014F12A0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 12:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLXLmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 06:42:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35446 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfLXLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:42:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id j1so13220448lja.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 03:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A9+/jlzxejOXGqGuMphO+K4YrVBFVrGdSz2snKyj29o=;
        b=Rw70dVZwXrsRRVRfmfqeZsX4G9Fe2idWs1COznV7TftE3Sdg2noDkvaR6TNS4tp2Py
         oF2SFqrXaXhzpukBAhGPD50KAYYuds2zmrISXOsJasPJrVe3gPW7MAQR4Wx7UQuabpBK
         BRvoY5XLKvxNR6y5KGgjH7p2zYP7likMnikIKNzniGQ84wYy3oRsjZpNqUzvam6Q626m
         U/q4E9UYL4uR+UjIozFFKQmEz46638H+GE/Ar7KCWlqfciRYciRakNciti21cgjJS7vx
         9m9jZz7VOA4Vix89Y0wLo39cLE9rSTyy3qyeG1Iku4GtH3CgTM7giADWRr5uNr5SeU0r
         CamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=A9+/jlzxejOXGqGuMphO+K4YrVBFVrGdSz2snKyj29o=;
        b=un+oZMu+lTA121pl9EcxmbFkPgFkfh0w1MuEcBXcfrgmU5pwDuFGAkD9FmKkI2DN+l
         5cAqxapQaHbRhiPT9qHtg0fnEMUc3xh1Jyzgj+hGxLSOKThn0QYZHPmW40nebhmaQwGY
         KzvGMN2ml8OLmKEbjtHU3OBVl2zJL+0QqLdCWR2TDyje9CXw4TynI7uDdZGVb20QpGx9
         qxOL/G1RzZYgtWEKs/uL4MXBMhNDX1kgZj9seKieii61eRR0ijNzzn/jM2pL65/MWe7f
         uGjF/EiKu02+dm3GWVeE9w7/3UDtiF4L967epl4mN6xbkbG+bpqQjSvQuZnwihGvHkY3
         PWCQ==
X-Gm-Message-State: APjAAAUXzy0Jq7ns37C3vOusMyPrth0js6qh+Wbm6LoFOM6WFmgA9DkJ
        TGXENchWZrvHMKD6JIU92RrHKtrhkKg=
X-Google-Smtp-Source: APXvYqy7dcoXvIYCuzCyChcVd9xAZaFC/RTj2+GYvm2Sv92TzoZuNlWedBq9tndQdoBgWXppPLhMvw==
X-Received: by 2002:a2e:2d11:: with SMTP id t17mr20102628ljt.177.1577187739239;
        Tue, 24 Dec 2019 03:42:19 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:441d:5f5:f336:feb9:305c:b1aa])
        by smtp.gmail.com with ESMTPSA id r20sm9818028lfi.91.2019.12.24.03.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 03:42:18 -0800 (PST)
Subject: Re: [PATCH] ppp: Remove redundant BUG_ON() check in ppp_pernet
To:     Xu Wang <vulab@iscas.ac.cn>, paulus@samba.org
Cc:     davem@davemloft.net, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1577180224-16405-1-git-send-email-vulab@iscas.ac.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <d3b4fbce-3349-d51d-4a2c-220ccadac506@cogentembedded.com>
Date:   Tue, 24 Dec 2019 14:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1577180224-16405-1-git-send-email-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/24/2019 12:37 PM, Xu Wang wrote:

> Passing NULL to ppp_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generici() also has the same effect.

   s/generici/generic/. :-)

> This patch removes the redundant BUG_ON check on the same parameter.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
[...]

MBR, Sergei
