Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A7131342
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgAFNzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 08:55:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40833 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgAFNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:55:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so15340021wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOvgs8hj7dePLPcNePLrt69XdZXpuWMsK+N/ZHyA1es=;
        b=m07u5nGnCZpJUI8A1ZnfY9d4w82zqcxobiRXp776JbxpKTIQIEsJHPGkBHNS4W6WL3
         5Kx/Zzo57gpeETH9v6lmhEqf68ArMe4CCddVfKc344tGJpOamH7emZUBUa4eRKfntile
         gjsaMgMfCj52sK0/e5dbPTEup6sOFkQNQPHKdIn0S2C1c3hcAtVLFcj8MUvSMNZi5FKR
         ITJtf9U7J6AWqGG2YK030C4OSyMJk9nX97rtgnbq6bUhOXPSC8pzyCt89JomXp2Nc8ZF
         UCTjtcKd9CqZ99r8TSZBINo7CQcE506lfzfjmuoU4w5IjrEwkCBd1YTJw+3p2/I20AFu
         yZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOvgs8hj7dePLPcNePLrt69XdZXpuWMsK+N/ZHyA1es=;
        b=k7TJnAYQzbgzUWuG3Kx2beYOOh3OArQFNNNJXTMiSs7gEKo55jrbM6draqbKdgnex5
         EL7s6wBCXoBUMBy/04F7I89BftFYBARWO3LYLEM5zaZtA8Fz4bcnxAf5PdXEPnqBAvDZ
         w1iPxSkmEKbuemcab5H696jLyuJs+r6FhZKl1O6p6FgTnFWb8ATq4PyQgImjb70E1V1P
         J4tg0iAtxNmacVI6PhSDyFkjjtZ/hTiaaz5aONx3VUqsv6f3qFbAmrUZRNzcbH7qfb6N
         pK/NuxgqywQ17JEmFKIV4aYDbrbKYPPpLAw3JFgciZtiZCMtN3GGbBQPidx6MfqkHwau
         JydA==
X-Gm-Message-State: APjAAAUqZw46DZlIuj21OZzWwpoM1VaIGQe6G+gAf/k2BgEr5UQwDrPq
        VvbIxstWog+20bIrrE2qbhjpUCfTbkY=
X-Google-Smtp-Source: APXvYqw890CrpRTdI5nRuZqhpN0XGRsEVvYreHKiTznR18ImmnALK7ahdFzMlIcQknZUfcelJWjSmw==
X-Received: by 2002:a05:600c:290f:: with SMTP id i15mr35413242wmd.115.1578318949072;
        Mon, 06 Jan 2020 05:55:49 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y7sm22744018wmd.1.2020.01.06.05.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 05:55:48 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx: ocotp: introduce ocotp_ctrl_reg
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577355442-2140-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <34e0a567-04ee-4ff3-38da-cd4e3d8b4b3f@linaro.org>
Date:   Mon, 6 Jan 2020 13:55:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1577355442-2140-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/12/2019 10:20, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Introduce ocotp_ctrl_reg to include the low 16bits mask of CTRL
> register.
> 
> i.MX chips will have different layout of the low 16bits of CTRL
> register, so use ocotp_ctrl_reg will make it clean to add new
> chip support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/nvmem/imx-ocotp.c | 79 ++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 57 insertions(+), 22 deletions(-)

Applied thanks,

--srini
