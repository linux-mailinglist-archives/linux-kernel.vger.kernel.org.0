Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03E91B433
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 12:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfEMKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 06:43:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33080 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfEMKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:43:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so6589028pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/9H7eEjZDZuXtxOJcFbxKLH+cRoZn/hc0SR3Jx+X1Co=;
        b=n6/Snc2PuWQKlDXdLLvbDS/Ti0DxL8BzCO6ouqqGvwDVLCKLzapDByjTofJJN4oNTp
         iyc6gMTnyDiSJeynSNBxtzUrR9RP4mPd4W1p0Kf+uG5kezVko374sKJ01hk+D9vTSl1k
         XV5CI2RtyUL1m15K8OTqnaAaEAsBhjwLa4CruGyC7UkyGfR7SYWxEHmoRvizW7eQ+n6J
         dewLoUMg/ygEMCFlrz3UcOglmKKKZTrWdz7AoVQj7AYbckr+oAzaRUjpKau+7IfiD2B/
         awCcKg4p4TSEb+tpOLANjkBLHNsfJYGvMF/ZXxuQEg4nDPFDiEf67SGvbWB03jufgbgF
         HnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/9H7eEjZDZuXtxOJcFbxKLH+cRoZn/hc0SR3Jx+X1Co=;
        b=Xj4GNxFuryy+xThyOOuAsOYVWKZSCgds5kRRva1RlrNACPgBwZ/yxUhX4WNwtzn+Uu
         XwsPwV2zimcqHsubAgVnsAyS4ZdWfgOtRMtO2DZ4FFr6/8EY4yXz9hqZFuOl1SJ1w8Jf
         NAO5IIupu9fw5GYq3EykRWnOgDHwtV44TigvLT9/lnHpqSWu+65yzHGgAdEbEA6mRtDJ
         oKVSs77glE1pKHlwOegJGXbyuWHWfxGEVpAfRRoJKvXbrbyUL5SnET3/84KnvhJVT9Od
         e3IYLgYjVySTA5UJts5MRCAdl81nM/Wx2Ob3b807vAG/h95dpm/HRx8fqCO3Tb3xdtzc
         mEYQ==
X-Gm-Message-State: APjAAAUJs35ExJGsgHmc3+nNH2og80S63AJsNuDIyZxOflmmVS0QoAdY
        015gWmFVce5IWKsb/SxUYyc=
X-Google-Smtp-Source: APXvYqzRge4MvcFVzpGPFZsHAxD+cQfFDOmmWKrMTRRLkZ0sz6XKKYKDSeff9hpzHmgx4KBt6zH0XQ==
X-Received: by 2002:a63:6841:: with SMTP id d62mr30398546pgc.17.1557744216431;
        Mon, 13 May 2019 03:43:36 -0700 (PDT)
Received: from [192.168.1.7] ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id v66sm15246064pfa.38.2019.05.13.03.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:43:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/8] Staging: kpc2000: kpc_dma: Resolve coding style
 errors reported by checkpatch.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
 <20190512234000.16555-2-bnvandana@gmail.com>
 <20190513084217.GA17959@kroah.com>
From:   Vandana BN <bnvandana@gmail.com>
Message-ID: <edce8621-86df-6e43-18e3-96d48851ca99@gmail.com>
Date:   Mon, 13 May 2019 16:13:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513084217.GA17959@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/05/19 2:12 PM, Greg KH wrote:
> On Mon, May 13, 2019 at 05:09:54AM +0530, Vandana BN wrote:
>> This patch resolves below errors reported by checkpatch
>> ERROR: "(foo*)" should be "(foo *)"
>> ERROR: "foo * bar" should be "foo *bar"
>> ERROR: "foo __init  bar" should be "foo __init bar"
>> ERROR: "foo __exit  bar" should be "foo __exit bar"
>>
>> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> Better...
>
> But your subject lines are almost all the same, with some being
> identical to others, yet you are doing different things in each of the
> patch.
>
> So please provide a better subject line saying, in a unique way, exactly
> what you are doing here.
>
> thanks,
>
> greg k-h

Thanks, have sent another patch set with better subject lines.

regards,

Vandana.

