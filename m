Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64801352EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 07:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgAIGAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 01:00:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44018 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgAIGAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:00:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so5825562ljm.10;
        Wed, 08 Jan 2020 22:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jdjS6K2dIf4AKtftWVFNoSuaQ6gkNryIMRphxB0WPic=;
        b=r3DqpCgsfrrcRXkqqgjNkSRcJV6mAIHAXcB/Es/dGepwDboRjHlTRB50mEbmSRav0h
         oA/zMRGTcAgZHj0jlwpU0TZVMS7ylSdCX8z++bWi7WG5MxsKwSRiVT8I/7VLFqRdShDE
         fzAG1hfJsN0hoCtd93RkjyUg0YD/WLfBIBfXzXc1yE0hlNH8Ai5V1guSuC7JZn/Y53Qw
         zZ0nHX59S8fuORc/P7dAnvXh/kbzFIDflq/ntCpGsjAr9ihxAWdgkpze7YGm1nV0Ds69
         UyDmoFuXeaCqnER4R51ZQH9Mfype/zxLBg9zzimVtIRnlLD5pdZi0yJpmEFq+xyPSVzG
         8R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jdjS6K2dIf4AKtftWVFNoSuaQ6gkNryIMRphxB0WPic=;
        b=mp/4aYu99NJ80uDaU8oWzi+QfxYLZRE3us3NsYsGEy/AdbIqTR9CCubs6BeNz390Zq
         EsOZPlVAZr6WGJOwgKPpq2FUPY5LUFMrUo2YIghAcYlxa9pkL10AWadodo0ROFxF4Erl
         Vfg7uHzHLtXnsHke3/55b/SRVkqiEjiqON7VGrCqTVbFd0Py7p46g2yB7+zC0/w1mEOM
         thCrUYUc6gPB0Hy7qCxUe88oP27Z6cE9zuGCx1GnWwcFjRvSNd05iLgmF7UfuSkLcAkw
         Fw67+/ZWHHMn4V1qQes5iRmjKAnstC4DKZYzRZ2UlSMrGupsD/oIzJMbHEWnApEzUe20
         HvKw==
X-Gm-Message-State: APjAAAXUcNZERb8DPgwqR0LKhWHhS9SkWaANUR+c+FjuvsRNsTO5glJx
        kfd9xU0ph4lOn9UdK33xU9hbNeSU
X-Google-Smtp-Source: APXvYqxu08nOLwdO35di1kCgbajKiCZxvikl5+mhzPOA7uD3hfkdbIDcg4B0CkCG30IfZCp2pVL84w==
X-Received: by 2002:a2e:b4cf:: with SMTP id r15mr5368398ljm.52.1578549618663;
        Wed, 08 Jan 2020 22:00:18 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z5sm2305493lji.40.2020.01.08.22.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 22:00:18 -0800 (PST)
Subject: Re: [PATCH v3] regmap: add iopoll-like atomic polling macro
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fa5198bf-0001-3a57-017f-1b40e0188606@gmail.com>
Date:   Thu, 9 Jan 2020 09:00:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1578546590-24737-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.01.2020 08:09, Sameer Pujar пишет:
> This patch adds a macro 'regmap_read_poll_timeout_atomic' that works
> similar to 'readx_poll_timeout_atomic' defined in linux/iopoll.h; This
> is atomic version of already available 'regmap_read_poll_timeout' macro.
> 
> It should be noted that above atomic macro cannot be used by all regmaps.
> If the regmap is set up for atomic use (flat or no cache and MMIO) then
> only it can use.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---

Could you please explain what is the targeted use-case here?
